import pool from "./bdConfig.js";

export class Reportes {

    tramites = async (id_entidad, id,) => {
        try {
            const sql = `
                    SELECT
                        t.id as value, 
                        concat(t.codigo,', ', t.detalle ) as label,
                        t.id, 
                        t.codigo, 
                        t.detalle, 
                        t.costo, 
                        t.estado, 
                        t.eliminado, 
                        t.fecha_ingreso, 
                        t.fecha_finalizacion,
                        tt.tipo_tramite AS nombre_tipo_tramite,

                        /* Mantenemos los nombres de tu UI, pero con lógica de Ingresos Reales */
                        IFNULL(SUM(DISTINCT i.monto_total), 0) AS total_ingresos, -- Informativo
                        IFNULL(SUM(DISTINCT s.monto_total), 0) AS total_gastos,
                        
                        /* El saldo real: Suma Ingresos - Suma Salidas */
                        (IFNULL(SUM(DISTINCT i.monto_total), 0) - IFNULL(SUM(DISTINCT s.monto_total), 0)) AS saldoDisponible,
                        t.fecha_ingreso, t.fecha_finalizacion

                    FROM tramites t
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

                    WHERE ${id ? ` t.id = ${pool.escape(id)}` : `t.id_entidad = ${pool.escape(id_entidad)}`}
                    GROUP BY t.id
                    ORDER BY t.created_at DESC`;

            const [rows] = await pool.query(sql);

            // console.log(rows)
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
                        t.id_tipo_tramite,
                        
                        tt.tipo_tramite AS nombre_tipo_tramite
                    FROM tramites t
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
   * Listar ingresos vinculados a un trámite específico
   */
    getDataToPDFINgresos = async (idTramite) => {
        try {
            const sql = `
        SELECT 
          i.*, 
          t.codigo AS codigo_tramite,
          i.id_cliente,
          CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente_nombre,
          CONCAT(u.nombre, ' ', u.ap1) AS usuario_nombre, u.username, u.id as id_usuario   
        FROM ingresos i
        INNER JOIN tramites t ON i.id_tramite = t.id
        INNER JOIN clientes c ON i.id_cliente = c.id

        LEFT JOIN usuarios u ON i.usuario = u.id
        WHERE i.id_tramite = ?
        ORDER BY i.fecha_ingreso DESC
      `;
            const [rows] = await pool.query(sql, [idTramite]);
            return rows;
        } catch (error) {
            console.error("Error al listar ingresos por trámite:", error);
            throw error;
        }
    };



    // csript para PDF
    getDatatoPdfSalidas = async (id) => {
        try {
            const sql = `
        SELECT s.*, t.codigo AS codigo_tramite, concat(u.nombre ,' ', u.ap1) as usuario_nombre
        FROM salidas s
        INNER JOIN tramites t ON s.id_tramite = t.id
        inner join usuarios u on u.id = s.usuario_solicita_id
        where id_tramite = ${pool.escape(id)} and s.estado = 3
        ORDER BY s.numero DESC  
      `;
            const [rows] = await pool.query(sql);

            // console.error("Error al listar salidas:", rows,  id);

            return rows;
        } catch (error) {
            console.error("Error al listar salidas:", error);
            throw error;
        }
    };


    // Reporte de Salidas entre fechas
    getSalidasExcel = async (id, desde, hasta) => {
        const sql = `
        SELECT s.*, t.codigo AS codigo_tramite, t.detalle as tramite_detalle, 
        CONCAT(u.nombre, ' ', u.ap1) as usuario_nombre
        FROM salidas s
        INNER JOIN tramites t ON s.id_tramite = t.id
        INNER JOIN usuarios u ON u.id = s.usuario_solicita_id
        WHERE s.id_tramite = ${pool.escape(id)} 
        AND s.estado = 3 
        AND s.fecha_solicitud BETWEEN ${pool.escape(desde)} AND ${pool.escape(hasta)}
        ORDER BY s.numero ASC`;
        const [rows] = await pool.query(sql);
        return rows;
    };

    // Reporte de Ingresos entre fechas
    getIngresosExcel = async (id, desde, hasta) => {

        const sql = `
        SELECT i.*, t.codigo AS codigo_tramite, t.detalle as tramite_detalle,
         i.id_cliente,
          CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente_nombre,
        CONCAT(u.nombre, ' ', u.ap1) as usuario_nombre
        FROM ingresos i
        INNER JOIN tramites t ON i.id_tramite = t.id
        INNER JOIN clientes c ON i.id_cliente = c.id
        LEFT JOIN usuarios u ON i.usuario = u.id
        WHERE i.id_tramite = ${pool.escape(id)}
        AND i.created_at BETWEEN ${pool.escape(desde)} AND ${pool.escape(hasta)}
        ORDER BY i.numero ASC`;
        const [rows] = await pool.query(sql);

        // console.log(rows)
        return rows;
    };


    reportaConsolidado = async (desde, hasta, estado) => {
        try {
            const sql = `
            SELECT
                t.id as value, 
                t.codigo as label,
                t.id, 
                t.codigo, 
                t.detalle, 
                t.costo, 
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
            INNER JOIN tipo_tramites tt ON t.id_tipo_tramite = tt.id

            /* Subconsulta de Ingresos con filtro de fecha_ingreso */
            LEFT JOIN (
                SELECT id_tramite, SUM(monto) as monto_total 
                FROM ingresos 
                WHERE 1=1
                ${desde ? ` AND fecha_ingreso >= ${pool.escape(desde)}` : ''}
                ${hasta ? ` AND fecha_ingreso <= ${pool.escape(hasta)}` : ''}
                GROUP BY id_tramite
            ) i ON t.id = i.id_tramite

            /* Subconsulta de Salidas con filtro de fecha_solicitud */
            LEFT JOIN (
                SELECT id_tramite, SUM(monto) as monto_total 
                FROM salidas 
                WHERE estado = 3 
                ${desde ? ` AND fecha_solicitud >= ${pool.escape(desde)}` : ''}
                ${hasta ? ` AND fecha_solicitud <= ${pool.escape(hasta)}` : ''}
                GROUP BY id_tramite
            ) s ON t.id = s.id_tramite

            WHERE ${estado === 4 ? '' : `t.estado = ${pool.escape(estado)} and `} t.eliminado = 1
            GROUP BY t.id
            ORDER BY t.created_at DESC`;

            const [rows] = await pool.query(sql);
            // console.log(rows)
            return rows;
        } catch (error) {
            console.error("Error al listar trámites con filtros:", error);
            throw error;
        }
    };

    // En tu clase Reportes  
    getStatsMensuales = async (id_entidad) => {
        const sql = `
        SELECT 
            months.mes,
            IFNULL(SUM(i.monto), 0) as ingresos,
            IFNULL(SUM(s.monto), 0) as gastos
        FROM (
            SELECT 1 as mes UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 
            UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12
        ) as months
        LEFT JOIN ingresos i ON MONTH(i.fecha_ingreso) = months.mes 
            AND YEAR(i.fecha_ingreso) = YEAR(CURDATE())
        LEFT JOIN salidas s ON MONTH(s.fecha_solicitud) = months.mes 
            AND s.estado = 3 AND YEAR(s.fecha_solicitud) = YEAR(CURDATE())
        GROUP BY months.mes
        ORDER BY months.mes ASC`;
        const [rows] = await pool.query(sql);
        return rows;
    };
}