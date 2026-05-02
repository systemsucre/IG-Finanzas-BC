import pool from './bdConfig.js';

export class Reportes {
  tramites = async (id, entidad) => {
    try {
      const sql = `
                    SELECT
                        t.id as value, 
                        t.codigo as label,
                        t.id, 
                        t.codigo, 
                        t.numero,
                        t.detalle, 
                        t.costo, 
                        t.estado, 
                        t.eliminado, 
                        t.fecha_ingreso, 
                        t.fecha_finalizacion,
                        m.id as id_moneda,
                        m.simbolo,
                        tt.tipo_tramite AS nombre_tipo_tramite,

                        /* Mantenemos los nombres de tu UI, pero con lógica de Ingresos Reales */
                        IFNULL(SUM(DISTINCT i.monto_total), 0) AS total_ingresos, -- Informativo
                        IFNULL(SUM(DISTINCT s.monto_total), 0) AS total_gastos,
                        
                        /* El saldo real: Suma Ingresos - Suma Salidas */
                        (IFNULL(SUM(DISTINCT i.monto_total), 0) - IFNULL(SUM(DISTINCT s.monto_total), 0)) AS saldoDisponible,
                        t.fecha_ingreso, t.fecha_finalizacion

                    FROM tramites t
                    INNER JOIN tipo_tramites tt ON t.id_tipo_tramite = tt.id
                    inner join monedas m on m.id = t.id_moneda
                    /* Unimos con ingresos (agrupados previamente por trámite para ligereza) */
                    LEFT JOIN (
                        SELECT id_tramite, SUM(monto) as monto_total 
                        FROM ingresos where estado = 2
                        GROUP BY id_tramite
                    ) i ON t.id = i.id_tramite

                    /* Unimos con salidas (agrupados para evitar duplicar filas en el JOIN) */
                    LEFT JOIN (
                        SELECT id_tramite, SUM(monto) as monto_total 
                        FROM salidas 
                        WHERE estado = 3 
                        GROUP BY id_tramite
                    ) s ON t.id = s.id_tramite

                    WHERE ${id ? ` t.id = ${pool.escape(id)}` : `1=1`} and t.id_entidad = ?
                    GROUP BY t.id
                    ORDER BY t.numero DESC`;

      const [rows] = await pool.query(sql, [entidad]);

      // console.log(sql, ' tramites')
      return rows;
    } catch (error) {
      console.error('Error al listar trámites:', error);
      throw error;
    }
  };

  listarModendas = async () => {
    try {
      const sql = `SELECT id as value, nombre as label, simbolo FROM monedas`;
      const [rows] = await pool.query(sql);
      return rows;
    } catch (error) {
      console.error('Error al listar tipos auxiliares:', error);
      throw error;
    }
  };

  ObtenerTramite = async (id) => {
    try {
      const sql = `
                SELECT 
                    t.id, 
                    t.codigo, t.numero,
                    t.fecha_ingreso, 
                    t.fecha_finalizacion, 
                    t.detalle, 
                    t.costo, 
                    t.otros, 
                    m.id as id_moneda, m.simbolo,
                    t.estado, 
                    t.id_tipo_tramite,
                    tt.tipo_tramite AS nombre_tipo_tramite
                FROM tramites t
                inner join monedas m on m.id = t.id_moneda
                INNER JOIN tipo_tramites tt ON t.id_tipo_tramite = tt.id
                WHERE t.id = ?`; // Filtramos por el ID recibido

      const [rows] = await pool.query(sql, [id]);

      // Retornamos solo el objeto encontrado, no la lista completa
      return rows.length > 0 ? rows[0] : null;
    } catch (error) {
      console.error('Error al obtener el trámite por ID:', error);
      throw error;
    }
  };

  /**
   * Listar ingresos vinculados a un trámite específico
   */
  getDataToIngresoPDF = async (idTramite) => {
    try {
      const sql = `
        SELECT 
          i.*, m.id as id_moneda, m.simbolo,
          t.codigo AS codigo_tramite, t.numero as numero_tramite,
          CONCAT(u.nombre, ' ', u.ap1) AS usuario_nombre, u.username, u.id as id_usuario  ,
           CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente_nombre   
        FROM ingresos i
        INNER JOIN clientes c ON i.id_cliente = c.id
        INNER JOIN tramites t ON i.id_tramite = t.id
                inner join monedas m on m.id = t.id_moneda

        LEFT JOIN usuarios u ON i.usuario = u.id
        WHERE i.id_tramite = ? and i.estado = 2
        ORDER BY i.numero ASC
      `;
      const [rows] = await pool.query(sql, [idTramite]);
      return rows;
    } catch (error) {
      console.error('Error al listar ingresos por trámite:', error);
      throw error;
    }
  };

  // csript para PDF
  getDatatoSalidaPdf = async (id) => {
    try {
      const sql = `
                SELECT s.*, t.codigo AS codigo_tramite, t.numero as numero_tramite, concat(u.nombre ,' ', u.ap1) as usuario_nombre,m.id as id_moneda, m.simbolo
                FROM salidas s
                INNER JOIN tramites t ON s.id_tramite = t.id
                inner join monedas m on m.id = t.id_moneda

                inner join usuarios u on u.id = s.usuario_solicita_id
                where id_tramite = ${pool.escape(id)} and s.estado = 3
                ORDER BY s.numero ASC
            `;
      const [rows] = await pool.query(sql);

      console.log(' listar salidas:', rows, id);

      return rows;
    } catch (error) {
      console.error('Error al listar salidas:', error);
      throw error;
    }
  };

  // Reporte de Salidas entre fechas
  getSalidasExcel = async (desde, hasta, moneda, id) => {
    const sql = `
        SELECT s.*, t.codigo AS codigo_tramite, t.numero as numero_tramite, t.detalle as tramite_detalle, m.id as id_moneda, m.simbolo,
        CONCAT(u.nombre, ' ', u.ap1) as usuario_nombre
        FROM salidas s
        INNER JOIN tramites t ON s.id_tramite = t.id
                inner join monedas m on m.id = t.id_moneda

        INNER JOIN usuarios u ON u.id = s.usuario_solicita_id
        WHERE ${id ? `s.id_tramite = ${pool.escape(id)} AND` : ''}
        ${moneda ? `t.id_moneda = ${pool.escape(moneda)} AND ` : ''}

        s.estado = 3 
        AND s.fecha_despacho BETWEEN ${pool.escape(desde)} AND ${pool.escape(hasta)} and t.eliminado = 1
        ORDER BY s.numero ASC`;
    const [rows] = await pool.query(sql);
    // console.log(sql)
    return rows;
  };

  // Reporte de Ingresos entre fechas
  getIngresosExcel = async (desde, hasta, moneda, id) => {
    const sql = `
        SELECT i.*, t.codigo AS codigo_tramite, t.numero as numero_tramite, t.detalle as tramite_detalle,m.id as id_moneda, m.simbolo,
        CONCAT(u.nombre, ' ', u.ap1) as usuario_nombre,
        CONCAT(c.nombre, ' ', c.ap1) as cliente_nombre

        FROM ingresos i
        INNER JOIN tramites t ON i.id_tramite = t.id
                inner join monedas m on m.id = t.id_moneda

        LEFT JOIN usuarios u ON i.usuario = u.id
        inner join clientes c on c.id = i.id_cliente

        WHERE i.estado = 2  ${id ? `and i.id_tramite = ${pool.escape(id)} AND ` : ''} 

        ${moneda ? `t.id_moneda = ${pool.escape(moneda)} AND ` : ''}

        i.fecha_ingreso BETWEEN ${pool.escape(desde)} AND ${pool.escape(hasta)} and t.eliminado = 1 and i.estado = 2 
        ORDER BY i.numero ASC`;
    const [rows] = await pool.query(sql);
    return rows;
  };

  reportaConsolidado = async (desde, hasta, estado, entidad, moneda) => {
    try {
      const sql = `
            SELECT
                t.id as value, 
                t.codigo as label,
                t.id, 
                t.codigo, t.numero,
                t.detalle, 
                t.costo, 
         m.id as id_moneda, m.simbolo,
                t.estado, 
                t.eliminado, 
                t.fecha_ingreso, 
                t.fecha_finalizacion,
                tt.tipo_tramite AS nombre_tipo_tramite,

                /* Totales filtrados por el rango de fechas proporcionado */
                IFNULL(i.monto_total, 0) AS total_ingresos,
                IFNULL(s.monto_total, 0) AS total_gastos,
                
                /* Saldo calculado sobre el rango filtrado */
                (IFNULL(i.monto_total, 0) - IFNULL(s.monto_total, 0)) AS saldoDisponible

            FROM tramites t
                inner join monedas m on m.id = t.id_moneda

            INNER JOIN tipo_tramites tt ON t.id_tipo_tramite = tt.id

            /* Subconsulta de Ingresos con filtro de fecha_ingreso */
            LEFT JOIN (
                SELECT id_tramite, SUM(monto) as monto_total 
                FROM ingresos 
                WHERE estado = 2 and
                ${desde ? ` AND fecha_ingreso >= ${pool.escape(desde)}` : ''}
                ${hasta ? ` AND fecha_ingreso <= ${pool.escape(hasta)}` : ''}
                GROUP BY id_tramite
            ) i ON t.id = i.id_tramite

            /* Subconsulta de Salidas con filtro de fecha_solicitud */
            LEFT JOIN (
                SELECT id_tramite, SUM(monto) as monto_total 
                FROM salidas 
                WHERE estado = 3 
                ${desde ? ` AND fecha_despacho >= ${pool.escape(desde)}` : ''}
                ${hasta ? ` AND fecha_despacho <= ${pool.escape(hasta)}` : ''}
                GROUP BY id_tramite
            ) s ON t.id = s.id_tramite

            WHERE ${estado === 4 ? '' : `t.estado = ${pool.escape(estado)} and `} t.eliminado = 1 and t.id_entidad = ${pool.escape(entidad)} and t.id_moneda=${pool.escape(moneda)}
            GROUP BY t.id
            ORDER BY t.created_at DESC`;

      const [rows] = await pool.query(sql);
      // console.log(rows)
      return rows;
    } catch (error) {
      console.error('Error al listar trámites con filtros:', error);
      throw error;
    }
  };

  //  and t.id_moneda = ${pool.escape(moneda)}
  getStatsMensuales = async (id_entidad, moneda) => {
    // console.log(moneda, ' moneda actual')
    // const idMoneda = parseInt(moneda) || 1
    const sql = `
                SELECT 
                    months.mes,
                    IFNULL(ing.total_ingresos, 0) as ingresos,
                    IFNULL(gas.total_gastos, 0) as gastos
                FROM (
                    SELECT 1 as mes UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
                    UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 
                    UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12
                ) as months
                LEFT JOIN (
                    /* Subconsulta de Ingresos por Entidad */
                    SELECT 
                        MONTH(i.fecha_ingreso) as mes, 
                        SUM(i.monto) as total_ingresos 
                    FROM ingresos i
                    inner join tramites t on t.id = i.id_tramite
                    WHERE t.id_entidad = ? and t.id_moneda = ? and t.eliminado = 1
                    AND YEAR(i.fecha_ingreso) = YEAR(CURDATE()) and i.estado = 2
                    GROUP BY MONTH(i.fecha_ingreso)
                ) as ing ON months.mes = ing.mes
                LEFT JOIN (
                    /* Subconsulta de Gastos por Entidad */
                    SELECT 
                        MONTH(s.fecha_solicitud) as mes, 
                        SUM(s.monto) as total_gastos 
                    FROM salidas s 
                    inner join tramites t on t.id = s.id_tramite 
                    WHERE t.id_entidad = ? and t.id_moneda = ? and t.eliminado = 1
                    AND s.estado = 3 
                    AND YEAR(s.fecha_despacho) = YEAR(CURDATE())
                    GROUP BY MONTH(s.fecha_solicitud)
                ) as gas ON months.mes = gas.mes
                ORDER BY months.mes ASC`;

    // Pasamos el id_entidad dos veces (una para cada subconsulta)
    const [rows] = await pool.query(sql, [
      id_entidad,
      moneda,
      id_entidad,
      moneda,
    ]);
    // console.log(rows)
    return rows;
  };

  listarCajas = async (entidad) => {
    try {
      const sql = `SELECT * FROM tramites where id_entidad = ? and eliminado = 1`;
      const [rows] = await pool.query(sql, [entidad]);
      return rows;
    } catch (error) {
      console.error('Error al listar tipos auxiliares:', error);
      throw error;
    }
  };

  // En tu modelo de Estadísticas (Estadisticas.js)
  getHistoricoParaIA = async (entidad, moneda) => {
    const sql = `
        SELECT 
            MONTH(fecha) as mes, 
            YEAR(fecha) as anio,
            SUM(ingreso) as total_ingresos,
            SUM(egreso) as total_gastos
        FROM (
            SELECT i.fecha_ingreso as fecha, i.monto as ingreso, 0 as egreso FROM ingresos i inner join tramites t on t.id = i.id_tramite where t.id_entidad = ? and t.id_moneda = ? and i.estado = 2
            UNION ALL
            SELECT s.fecha_despacho as fecha, 0 as ingreso, s.monto as egreso FROM salidas s inner join tramites t on t.id = s.id_tramite where t.id_entidad = ? and t.id_moneda = ?
        ) as movimientos
        GROUP BY anio, mes
        ORDER BY anio ASC, mes ASC`;

    const [rows] = await pool.query(sql, [entidad, moneda, entidad, moneda]);
    // console.log(rows, ' datos para la IA con fecha corregida');
    return rows;
  };
}
