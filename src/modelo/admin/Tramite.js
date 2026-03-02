import pool from "../bdConfig.js";

export class Tramite {



  listar = async (id) => {
    try {
      const sql = `
      SELECT 
        t.id, 
        t.codigo, 
        t.detalle, 
        t.costo, 
        CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente_nombre, 
        t.id_cliente,
        t.estado, 
        t.eliminado, 
        t.fecha_ingreso, 
        t.fecha_finalizacion,
        tt.tipo_tramite AS nombre_tipo_tramite,

        /* Mantenemos los nombres de tu UI, pero con lógica de Ingresos Reales */
        IFNULL(SUM(DISTINCT i.monto_total), 0) AS total_ingresos, -- Informativo
        IFNULL(SUM(DISTINCT s.monto_total), 0) AS total_gastos,
        
        /* El saldo real: Suma Ingresos - Suma Salidas */
        (IFNULL(SUM(DISTINCT i.monto_total), 0) - IFNULL(SUM(DISTINCT s.monto_total), 0)) AS saldoDisponible

      FROM tramites t
      INNER JOIN clientes c ON t.id_cliente = c.id
      INNER JOIN tipo_tramites tt ON t.id_tipo_tramite = tt.id

      /* Unimos con ingresos (agrupados previamente por trámite para ligereza) */
      LEFT JOIN (
        SELECT id_tramite, SUM(monto) as monto_total 
        FROM ingresos 
        GROUP BY id_tramite
      ) i ON t.id = i.id_tramite

      /* Unimos con salidas (agrupados para evitar duplicar filas en el JOIN) */
      LEFT JOIN (
        SELECT id_tramite, SUM(monto) as monto_total 
        FROM salidas 
        WHERE estado = 3 
        GROUP BY id_tramite
      ) s ON t.id = s.id_tramite

      WHERE ${id ? ` t.id = ${pool.escape(id)}` : ``}
      GROUP BY t.id
      ORDER BY t.created_at DESC`;

      const [rows] = await pool.query(sql);
      return rows;
    } catch (error) {
      console.error("Error al listar trámites:", error);
      throw error;
    }
  };


  ObtenerTramite = async (id) => {
    try {
      const sql = `
      SELECT 
          t.id, 
          t.codigo, 
          t.fecha_ingreso, 
          t.fecha_finalizacion, 
          t.detalle, 
          t.costo, 
          t.otros, 
          t.estado, 
          t.id_cliente,
          t.id_tipo_tramite,
          CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente_nombre,
          tt.tipo_tramite AS nombre_tipo_tramite
      FROM tramites t
      INNER JOIN clientes c ON t.id_cliente = c.id
      INNER JOIN tipo_tramites tt ON t.id_tipo_tramite = tt.id
      WHERE t.id = ?`; // Filtramos por el ID recibido

      const [rows] = await pool.query(sql, [id]);

      // Retornamos solo el objeto encontrado, no la lista completa
      return rows.length > 0 ? rows[0] : null;

    } catch (error) {
      console.error("Error al obtener el trámite por ID:", error);
      throw error;
    }
  };


  /**
   * Obtiene lista simplificada de clientes activos para selects
   */
  listarClientesActivos = async () => {
    try {
      const sql = `
      SELECT id as value, CONCAT(nombre, ' ', ap1, ' ', IFNULL(ap2, '')) as label 
      FROM clientes 
      WHERE estado = 1 
      ORDER BY nombre ASC`;
      const [rows] = await pool.query(sql);
      return rows;
    } catch (error) {
      console.error("Error al listar clientes auxiliares:", error);
      throw error;
    }
  };

  /**
   * Obtiene lista simplificada de tipos de trámites activos para selects
   */
  listarTiposActivos = async () => {
    try {
      const sql = `SELECT id as value, tipo_tramite as label, codigo FROM tipo_tramites WHERE estado = 1 ORDER BY tipo_tramite ASC`;
      const [rows] = await pool.query(sql);
      return rows;
    } catch (error) {
      console.error("Error al listar tipos auxiliares:", error);
      throw error;
    }
  };

  /**
   * Registro de un nuevo trámite
   * @param {Object} datos - Incluye id_cliente, codigo, fechas, id_tipo_tramite, costo, etc.
   */
  // Dentro de tu clase Tramites
  insertar = async (datos) => {
    try {
      // 1. Obtener el prefijo del tipo de trámite (ej: 'ACC')
      const [tipo] = await pool.query(
        "SELECT codigo FROM tipo_tramites WHERE id = ? and id_entidad = ?",
        [datos.id_tipo_tramite, datos.id_entidadS]
      );

      if (!tipo || tipo.length === 0) {
        throw new Error("El tipo de trámite seleccionado no existe.");
      }

      const prefijo = tipo[0].codigo; // Ej: "ACC"

      // 2. Buscar el último código que empiece con ese prefijo
      const [ultimo] = await pool.query(
        "SELECT codigo FROM tramites WHERE id_entidad = ? and codigo LIKE ? ORDER BY created_at DESC LIMIT 1",
        [datos.id_entidadS,`${prefijo}-%`]
      );

      let nuevoNumero = 1;
      if (ultimo && ultimo.length > 0) {
        // Separamos por el guion y tomamos la segunda parte
        const partes = ultimo[0].codigo.split('-');
        const ultimoNumero = parseInt(partes[1]);

        if (!isNaN(ultimoNumero)) {
          nuevoNumero = ultimoNumero + 1;
        }
      }

      // 3. Formatear con 6 dígitos: ACC-000001
      const codigoFinal = `${prefijo}-${nuevoNumero.toString().padStart(6, '0')}`;

      // 4. Inserción en la base de datos
      const sql = `
            INSERT INTO tramites (
                id, id_cliente, codigo, fecha_ingreso, fecha_finalizacion, 
                id_tipo_tramite, detalle, costo, otros, estado, 
                usuario, id_entidad, created_at, eliminado
            ) VALUES (UUID(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), 1)
        `;

      const valores = [
        datos.id_cliente,
        codigoFinal,
        datos.fecha_ingreso,
        datos.fecha_finalizacion,
        datos.id_tipo_tramite,
        datos.detalle,
        datos.costo,
        datos.otros,
        datos.estado || 1,
        datos.usuario,
        datos.id_entidadS
      ];

      const [result] = await pool.query(sql, valores);

      return {
        status: "success",
        codigo: codigoFinal,
        id: result.insertId // Nota: Si usas UUID() en el SQL, el ID estará en el registro, no en insertId
      };

    } catch (error) {
      console.error("Error al generar trámite correlativo:", error);
      throw error;
    }
  };
  /**
   * Actualización de un trámite existente
   */
  actualizar = async (datos) => {
    try {
      const sql = `UPDATE tramites SET 
                   id_cliente = ${pool.escape(datos.id_cliente)},
                   fecha_ingreso = ${pool.escape(datos.fecha_ingreso)},
                   fecha_finalizacion = ${pool.escape(datos.fecha_finalizacion)},
                   id_tipo_tramite = ${pool.escape(datos.id_tipo_tramite)},
                   detalle = ${pool.escape(datos.detalle)},
                   estado = ${pool.escape(datos.estado)},
                   costo = ${pool.escape(datos.costo)},
                   otros = ${pool.escape(datos.otros)},
                   usuario = ${pool.escape(datos.usuario)},
                   modified_at = ${pool.escape(datos.modified_at)}
                   WHERE id = ${pool.escape(datos.id)} `;

      const [res] = await pool.query(sql);
      return res.affectedRows > 0 ? { ok: true } : { error: 1 };
    } catch (error) {
      console.error("Error al actualizar trámite:", error);
      throw error;
    }
  };



  /**
   * Eliminar logico
   */
  eliminar = async (datos) => {
    try {
      // Cambiamos DELETE por UPDATE
      // Asumimos que estado = 1 es ACTIVO y estado = 0 es ELIMINADO/INACTIVO
      const sql = `UPDATE tramites SET 
                eliminado = ${pool.escape(datos.estado)}, 
                usuario = ${pool.escape(datos.usuario)}, 
                modified_at = ${pool.escape(datos.fecha_)} 
                WHERE id = ${pool.escape(datos.id)}`;

      const [result] = await pool.query(sql);

      // Retornamos true si se encontró el registro y se modificó
      return result.affectedRows > 0;
    } catch (error) {
      console.error("Error al realizar eliminación lógica del trámite:", error);
      throw error;
    }
  };
}