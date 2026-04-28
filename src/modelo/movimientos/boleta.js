import pool from '../bdConfig.js';

export class Boleta {
  // Lista todas las boletas del sistema agrupadas
  async listarBoletas(entidad) {
    const sql = `
            SELECT 
                s.codigo_boleta as id,
                s.codigo_boleta, s.numero_boleta,
                s.id_tramite,
                s.usuario_solicita_id, 
                t.codigo, -- Traemos el código del trámite para identificarlo
                s.estado,u.id as usuario,m.simbolo,
                SUM(s.monto) as monto_total,
                MIN(s.fecha_solicitud) as fecha,
                COUNT(s.id) as total_items,
                GROUP_CONCAT(s.detalle SEPARATOR ' | ') as detalles,
                CONCAT(u.nombre, ' ', u.ap1, ' ', IFNULL(u.ap2, '')) AS solicitado_por -- Opcional: quién la creó
            FROM salidas s
            LEFT JOIN tramites t ON s.id_tramite = t.id
          inner join monedas m on m.id = t.id_moneda

            LEFT JOIN usuarios u ON s.usuario_solicita_id = u.id
            WHERE s.estado != 0 and t.id_entidad = ${pool.escape(entidad)}
            GROUP BY s.codigo_boleta
            ORDER BY s.numero_boleta desc`;

    const [rows] = await pool.query(sql);
    return rows;
  }

  // -- CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente
  // -- LEFT JOIN clientes c ON t.id_cliente = c.id

  async obtenerItemsPorBoleta(codigo_boleta) {
    const sql = `
        SELECT 
          s.id,
          s.numero,
          s.codigo_boleta, s.numero_boleta,
          s.monto,
          s.detalle,
          s.fecha_solicitud,
          3 as estado,
          s.usuario_solicita_id,
          t.costo,
          t.id as value,
          t.codigo AS codigo_tramite,
          u.id as usuario,m.simbolo,
          
          CONCAT(u.nombre, ' ', u.ap1) AS solicitado_por,
          CONCAT(uau.nombre, ' ', uau.ap1) AS autorizado_por,
          CONCAT(us.nombre, ' ', us.ap1) AS despachado_por,
          s.fecha_solicitud, s.fecha_aprobacion, s.fecha_despacho
         

          FROM salidas s
          LEFT JOIN tramites t ON s.id_tramite = t.id
          inner join monedas m on m.id = t.id_moneda
          LEFT JOIN usuarios u ON s.usuario_solicita_id = u.id
          LEFT JOIN usuarios uau ON s.usuario_aprueba_id = uau.id
          LEFT JOIN usuarios us ON s.usuario_despacha_id = us.id

          WHERE s.codigo_boleta = ?
          ORDER BY s.numero ASC`;

    const [rows] = await pool.query(sql, [codigo_boleta]);
    // console.log(rows)
    return rows;
  }

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
      let estadoAuto = 3; // (datosServidor.srol === 2 || datosServidor.srol === 3) ? 3 : 1;

      // 3. Obtener último correlativo para la columna 'numero'
      const [maxRes] = await connection.query(
        'SELECT MAX(numero_boleta) as numero_boleta FROM salidas',
      );
      let ultimoNumeroBoleta = maxRes[0].numero_boleta || 0;
      let ultimoNumeroBol = 0;
      ultimoNumeroBoleta === 0
        ? (ultimoNumeroBol = 1)
        : (ultimoNumeroBol = ultimoNumeroBoleta + 1);

      for (const item of items) {
        const [maxRes] = await connection.query(
          'SELECT MAX(numero) as ultimo FROM salidas where id_tramite = ?',
          [item.id_tramite],
        );
        let ultimoNumero = maxRes[0].ultimo || 0;
        ultimoNumero === 0
          ? (ultimoNumero = 1)
          : (ultimoNumero = ultimoNumero + 1);

        // Usamos UUID() directamente en el INSERT de SQL

        const fechaCompleta = `${item.fecha} ${datosServidor.fecha_.split(' ')[1] || '00:00:00'}`;
        const usuario = datosServidor.usuario;
        const fechaRegistro = datosServidor.fecha_;

        const sql = `
            INSERT INTO salidas (
                id, numero, codigo_boleta, numero_boleta, id_tramite, estado, 
                monto, detalle, usuario_solicita_id, fecha_solicitud,
                usuario_aprueba_id, fecha_aprobacion, 
                usuario_despacha_id, fecha_despacho,  created_at
            ) VALUES (UUID(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

        const values = [
          ultimoNumero,
          codBoletaUnico,
          ultimoNumeroBol,
          item.id_tramite,
          estadoAuto,
          item.monto,
          item.detalle,
          usuario, // usuario_solicita_id
          fechaCompleta, // fecha_solicitud
          usuario, // usuario_aprueba_id
          fechaCompleta, // fecha_aprobacion
          usuario, // usuario_despacha_id
          fechaCompleta, // fecha_despacho
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
    // console.log(codigo_boleta, items)
    const connection = await pool.getConnection();
    try {
      await connection.beginTransaction();

      // 1. Eliminar los items anteriores de esta boleta
      const result = await connection.query(
        'DELETE FROM salidas WHERE codigo_boleta = ? and usuario_solicita_id = ? ',
        [codigo_boleta, datosServidor.usuario],
      );

      // console.log(result, ' eliminando boleta,')

      if (result && result[0].affectedRows === 0)
        return { ok: false, msg: 'Boleta no disponible para su edicion' };
      // 2. Lógica de estado (mantenemos tu lógica de roles)
      let estadoAuto = 3; //(datosServidor.srol === 2 || datosServidor.srol === 3) ? 3 : 1;

      // 3. Obtener correlativo
      const [maxRes] = await connection.query(
        'SELECT MAX(numero_boleta) as numero_boleta  FROM salidas',
      );
      let ultimoNumeroBoleta = maxRes[0].numero_boleta || 0;
      let ultimoNumeroBol = 0;
      ultimoNumeroBoleta === 0
        ? (ultimoNumeroBol = 1)
        : (ultimoNumeroBol = ultimoNumeroBoleta + 1);

      for (const item of items) {
        const [maxRes] = await connection.query(
          'SELECT MAX(numero) as ultimo FROM salidas where id_tramite = ?',
          [item.id_tramite],
        );
        let ultimoNumero = maxRes[0].ultimo || 0;
        ultimoNumero === 0
          ? (ultimoNumero = 1)
          : (ultimoNumero = ultimoNumero + 1);

        const fechaCompleta = `${item.fecha} ${datosServidor.fecha_.split(' ')[1] || '00:00:00'}`;
        const usuario = datosServidor.usuario;
        const fechaRegistro = datosServidor.fecha_;

        const sql = `
            INSERT INTO salidas (
                id, numero, codigo_boleta, numero_boleta, id_tramite, estado, 
                monto, detalle, usuario_solicita_id, fecha_solicitud,
                usuario_aprueba_id, fecha_aprobacion, 
                usuario_despacha_id, fecha_despacho, updated_at, created_at
            ) VALUES (UUID(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

        const values = [
          ultimoNumero,
          codigo_boleta,
          ultimoNumeroBol,
          item.id_tramite,
          estadoAuto,
          item.monto,
          item.detalle,
          usuario, // usuario_solicita_id
          fechaCompleta, // fecha_solicitud
          usuario, // usuario_aprueba_id
          fechaCompleta, // fecha_aprobacion
          usuario, // usuario_despacha_id
          fechaCompleta, // fecha_despacho
          fechaRegistro, // updated_at
          fechaRegistro, // created_at
        ];

        await connection.query(sql, values);
      }

      await connection.commit();
      return { ok: true, msg: 'Boleta actualizada correctamente' };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
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
        sql = `DELETE FROM salidas WHERE codigo_boleta = ? AND usuario_solicita_id = ? `;
        values = [codigo, usuario];
        break;
    }

    // console.log(sql)
    const [result] = await pool.query(sql, values);
    return result.affectedRows > 0;
  }
}
