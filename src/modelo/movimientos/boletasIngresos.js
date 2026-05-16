import pool from '../bdConfig.js';

export class BoletaIngresos {
  // Lista todas las boletas del sistema agrupadas
  async listarBoletas(entidad) {
    const sql = `
            SELECT 
                s.codigo_boleta as id,
                s.codigo_boleta, s.numero as numero_boleta,
                s.id_tramite,
                s.usuario, 
                t.codigo, -- Traemos el código del trámite para identificarlo
                t.detalle as detalle_tramite,
                s.estado,u.id as usuario,m.simbolo,
                SUM(s.monto) as monto_total,
                MIN(s.fecha_ingreso) as fecha,
                COUNT(s.id) as total_items,
                GROUP_CONCAT(s.detalle SEPARATOR ' | ') as detalles,
                CONCAT(u.nombre, ' ', u.ap1, ' ', IFNULL(u.ap2, '')) AS solicitado_por, -- Opcional: quién la creó
          CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) as cliente_nombre,
          c.id as idCliente

            FROM ingresos s
        left join clientes c on c.id = s.id_cliente

            LEFT JOIN tramites t ON s.id_tramite = t.id
          inner join monedas m on m.id = t.id_moneda

            LEFT JOIN usuarios u ON s.usuario = u.id
            WHERE s.estado = 2 and t.id_entidad = ${pool.escape(entidad)}
            GROUP BY s.codigo_boleta
            ORDER BY s.fecha_ingreso desc`;

    const [rows] = await pool.query(sql);
    return rows;
  }

  // -- CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente
  // -- LEFT JOIN clientes c ON t.id_cliente = c.id

  async obtenerItemsPorBoleta(codigo_boleta) {
    const sql = `
        SELECT 
          s.id,
          s.codigo_boleta, s.numero as numero_boleta,
          s.monto,
          s.detalle,
          s.fecha_ingreso as fecha_solicitud,
          2 as estado,
          s.usuario as usuario_solicita_id,
          t.id as value,
          t.codigo AS codigo_tramite,
          t.id as idTramite,
          t.detalle as detalle_tramite,
          u.id as usuario,m.simbolo,
          
          CONCAT(u.nombre, ' ', u.ap1) AS solicitado_por,
          CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) as cliente_nombre,
          c.id as idCliente
          FROM ingresos s
          inner join clientes c on c.id = s.id_cliente

          LEFT JOIN tramites t ON s.id_tramite = t.id
          inner join monedas m on m.id = t.id_moneda
          LEFT JOIN usuarios u ON s.usuario = u.id

          WHERE s.codigo_boleta = ?`;

    const [rows] = await pool.query(sql, [codigo_boleta]);
    return rows;
  }


  listarClientesActivos = async (entidad) => {
    try {
      const sql = `
      SELECT id as value, CONCAT(nombre, ' ', ap1, ' ', IFNULL(ap2, '')) as label 
      FROM clientes 
      WHERE estado = 1 and id_entidad = ${pool.escape(entidad)}
      ORDER BY nombre ASC`;
      const [rows] = await pool.query(sql);

      return rows;
    } catch (error) {
      console.error('Error al listar clientes auxiliares:', error);
      throw error;
    }
  };

  async crearBoletaMasiva(items, datosServidor) {
    const connection = await pool.getConnection();
    try {
      await connection.beginTransaction();

      // 1. Generar número de boleta único para el grupo
      const timestamp = Date.now().toString(36).toUpperCase(); // Basado en milisegundos
      const random = Math.random().toString(36).substr(2, 3).toUpperCase();
      const codBoletaUnico = `BOL-${timestamp}-${random}`;

      // 2. Lógica de estado automático por Rol
      // srol 2 (Gerente) o 3 (Cajero) -> Estado 3 (Despachado)
      // srol 4 (Auxiliar) o otros -> Estado 1 (Solicitado)
      let estadoAuto = 2; // (datosServidor.srol === 2 || datosServidor.srol === 3) ? 3 : 1;

      // 3. Obtener último correlativo para la columna 'numero'
      const [maxRes] = await connection.query(
        'SELECT MAX(numero) as numero_boleta FROM ingresos',
      );
      let ultimoNumeroBoleta = maxRes[0].numero_boleta || 0;
      let ultimoNumeroBol = 0;
      ultimoNumeroBoleta === 0
        ? (ultimoNumeroBol = 1)
        : (ultimoNumeroBol = ultimoNumeroBoleta + 1);

      for (const item of items) {


        // Usamos UUID() directamente en el INSERT de SQL

        const fechaCompleta = datosServidor.fecha;
        const usuario = datosServidor.usuario;
        const fechaRegistro = datosServidor.fecha_;

        const sql = `
            INSERT INTO ingresos (
                id,  
                codigo_boleta, 
                numero,
                id_tramite,
                estado, 
                monto,
                detalle,
                usuario, 
                fecha_ingreso,
                id_cliente,
                created_at
            ) VALUES (UUID(), 
             ?, ?, ?, ?,?, ?, ?, ?, ?,?)`;

        const values = [
          codBoletaUnico,
          ultimoNumeroBol,
          datosServidor.idTramite,
          estadoAuto,
          item.monto,
          item.detalle,
          usuario, // usuario_solicita_id
          fechaCompleta, // fecha_solicitud
          datosServidor.idCliente,
          fechaRegistro, // updated_at
        ];
        await connection.query(sql, values);
      }

      await connection.commit();
      return {
        ok: true,
        msg: 'Boleta registrada con éxito',
        codigo_boleta: codBoletaUnico,
      };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

async actualizarBoletaMasiva(codigo_boleta, items, datosServidor) {
  const connection = await pool.getConnection();
  try {
    await connection.beginTransaction();

    // 1. Validar existencia usando la conexión de la transacción
    const [res] = await connection.query(
      `SELECT i.id FROM tramites t 
       INNER JOIN ingresos i ON i.id_tramite = t.id 
       WHERE t.estado = 1 AND i.codigo_boleta = ? LIMIT 1`, 
      [codigo_boleta]
    );

    if (res.length === 0) {
      await connection.rollback();
      return { ok: false, msg: 'Boleta no encontrada o el trámite no está activo' };
    }

    // 2. Eliminar los items anteriores
    // IMPORTANTE: Asegúrate que usuario sea el correcto para permitir la edición
    const [delRes] = await connection.query(
      'DELETE FROM ingresos WHERE codigo_boleta = ? AND usuario = ?',
      [codigo_boleta, datosServidor.usuario]
    );

    if (delRes.affectedRows === 0) {
      await connection.rollback();
      return { ok: false, msg: 'No tiene permisos para editar esta boleta o ya fue eliminada' };
    }

    // 3. Obtener el último número correlativo (Global o por boleta, según tu lógica)
    const [maxRes] = await connection.query('SELECT MAX(numero) as numero_boleta FROM ingresos');
    let ultimoNumeroBol = (maxRes[0].numero_boleta || 0) + 1;

    // 4. Inserción Masiva
    const sql = `
      INSERT INTO ingresos (
        id, codigo_boleta, numero, id_tramite, estado, 
        monto, detalle, usuario, fecha_ingreso, id_cliente, 
        updated_at, created_at
      ) VALUES (UUID(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

    for (const item of items) {
      // Ajuste de fecha: Evita que falle si fecha_ no viene con espacio
      const horaActual = datosServidor.fecha_.includes(' ') 
                         ? datosServidor.fecha_.split(' ')[1] 
                         : '00:00:00';
      const fechaCompleta = datosServidor.fecha;

      const values = [
        codigo_boleta,
        ultimoNumeroBol,
        datosServidor.idTramite,
        2, // estadoAuto
        item.monto,
        item.detalle,
        datosServidor.usuario,
        fechaCompleta,
        datosServidor.idCliente,
        datosServidor.fecha_, // updated_at
        datosServidor.fecha_  // created_at
      ];

      console.log(codigo_boleta, items, datosServidor)
      await connection.query(sql, values);
    }

    await connection.commit();
    return { ok: true, msg: 'Boleta actualizada y registrada correctamente' };

  } catch (error) {
    if (connection) await connection.rollback();
    console.error("Error en actualizarBoletaMasiva:", error);
    return { ok: false, msg: 'Error interno del servidor', error: error.message };
  } finally {
    if (connection) connection.release();
  }
}

  async cambiarEstado(codigo, accion, auditoria, usuario, fecha_, srol) {
    let sql = '';

    let values = [];
    const ahora = fecha_.split(' ')[0] + ' 00:00:00';

    switch (accion) {
      case 'aprobar':
        sql = `UPDATE salidas SET estado = 2, usuario_aprueba_id = ?, fecha_aprobacion = ?, updated_at = ? WHERE codigo_boleta = ? and estado = 1
        ${srol === 2 ? '' : ' and 2=3'}
        `;
        values = [usuario, ahora, ahora, codigo];
        break;
      case 'despachar':
        sql = `UPDATE salidas SET estado = 3, usuario_despacha_id = ?, fecha_despacho = ?, updated_at = ? WHERE codigo_boleta = ? and estado = 2 
        ${srol === 3 ? '' : ' and 2=3'}
        `;
        values = [usuario, ahora, ahora, codigo];
        break;
      case 'aprobardespachar':
        sql = `UPDATE salidas SET estado = 3, usuario_aprueba_id = ?, fecha_aprobacion = ?, usuario_despacha_id = ?, fecha_despacho = ?,  updated_at = ? WHERE codigo_boleta = ? 
        ${srol === 3 ? `` : ` and 2=3`}
        `;
        values = [usuario, ahora, usuario, ahora, ahora, codigo];
        break;
      case 'rechazar':
        sql = `UPDATE salidas SET estado = 4, updated_at = ? WHERE id = ?`;
        values = [ahora, id];
        break;
      case 'edicion':
        sql = `UPDATE salidas SET estado = 1,usuario_aprueba_id = null, fecha_aprobacion = null, usuario_despacha_id = null, fecha_despacho = null  WHERE codigo_boleta = ? 
        ${srol === 2 || srol === 3 ? '' : ' and 2=3'}
        `;
        values = [codigo];
        break;
      case 'eliminar':
        // Solo permite eliminar si está en estado Solicitado (1)
        sql = `DELETE FROM ingresos WHERE codigo_boleta = ? AND usuario = ? `;
        values = [codigo, usuario];
        break;
    }

    const [res] = await pool.query(`select * from tramites t inner join ingresos i on i.id_tramite = t.id where t.estado = 1 and i.codigo_boleta = ?`, [codigo])
    if (res.length > 0) {
      const [result] = await pool.query(sql, values);
      return result.affectedRows > 0;
    } return false

  }
}
