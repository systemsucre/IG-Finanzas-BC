import pool from "./bdConfig.js";

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

                    WHERE ${id ? ` t.id = ${pool.escape(id)}` : `1=1`} and t.id_entidad = ?
                    GROUP BY t.id
                    ORDER BY t.numero DESC`;

            const [rows] = await pool.query(sql, [entidad]);

            // console.log(rows, ' tramites')
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
                    t.codigo, t.numero,
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
    getDataToIngresoPDF = async (idTramite) => {
        try {
            const sql = `
        SELECT 
          i.*, 
          t.codigo AS codigo_tramite, t.numero as numero_tramite,
          CONCAT(u.nombre, ' ', u.ap1) AS usuario_nombre, u.username, u.id as id_usuario  ,
           CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente_nombre   
        FROM ingresos i
        INNER JOIN clientes c ON i.id_cliente = c.id
        INNER JOIN tramites t ON i.id_tramite = t.id
        LEFT JOIN usuarios u ON i.usuario = u.id
        WHERE i.id_tramite = ?
        ORDER BY i.numero ASC
      `;
            const [rows] = await pool.query(sql, [idTramite]);
            return rows;
        } catch (error) {
            console.error("Error al listar ingresos por trámite:", error);
            throw error;
        }
    };



    // csript para PDF
    getDatatoSalidaPdf = async (id) => {
        try {
            const sql = `
                SELECT s.*, t.codigo AS codigo_tramite, t.numero as numero_tramite, concat(u.nombre ,' ', u.ap1) as usuario_nombre
                FROM salidas s
                INNER JOIN tramites t ON s.id_tramite = t.id
                inner join usuarios u on u.id = s.usuario_solicita_id
                where id_tramite = ${pool.escape(id)} and s.estado = 3
                ORDER BY s.numero ASC
            `;
            const [rows] = await pool.query(sql);

            // console.log(" listar salidas:", rows,  id);

            return rows;
        } catch (error) {
            console.error("Error al listar salidas:", error);
            throw error;
        }
    };


    // Reporte de Salidas entre fechas
    getSalidasExcel = async (id, desde, hasta) => {
        const sql = `
        SELECT s.*, s.fecha_solicitud as fecha, t.codigo AS codigo_tramite, t.numero as numero_tramite, t.detalle as tramite_detalle, s.codigo_boleta,
        CONCAT(u.nombre, ' ', u.ap1) as usuario_nombre
        FROM salidas s
        INNER JOIN tramites t ON s.id_tramite = t.id
        INNER JOIN usuarios u ON u.id = s.usuario_solicita_id
        WHERE s.id_tramite = ${pool.escape(id)} 
        AND s.estado = 3 
        AND s.fecha_despacho BETWEEN ${pool.escape(desde)} AND ${pool.escape(hasta)}
        ORDER BY s.numero ASC`;
        const [rows] = await pool.query(sql);
        return rows;
    };

    // INNER JOIN clientes c ON t.id_cliente = c.id

    // CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente_nombre,    t.id_cliente,


    // Reporte de Ingresos entre fechas
    getIngresosExcel = async (id, desde, hasta) => {
        const sql = `
        SELECT i.*, i.fecha_ingreso as fecha, t.codigo AS codigo_tramite, t.numero as numero_tramite, t.detalle as tramite_detalle,
        CONCAT(u.nombre, ' ', u.ap1) as usuario_nombre,
         CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente_nombre
        FROM ingresos i
        INNER JOIN clientes c ON i.id_cliente = c.id
        INNER JOIN tramites t ON i.id_tramite = t.id
        LEFT JOIN usuarios u ON i.usuario = u.id
        WHERE i.id_tramite = ${pool.escape(id)}
        AND i.fecha_ingreso BETWEEN ${pool.escape(desde)} AND ${pool.escape(hasta)}
        ORDER BY i.numero ASC`;
        const [rows] = await pool.query(sql);
        return rows;
    };


    reportaConsolidado = async (desde, hasta, estado, entidad) => {
        try {
            const sql = `
            SELECT
                t.id as value, 
                t.codigo as label,
                t.id, 
                t.codigo, t.numero,
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
                ${desde ? ` AND fecha_despacho >= ${pool.escape(desde)}` : ''}
                ${hasta ? ` AND fecha_despacho <= ${pool.escape(hasta)}` : ''}
                GROUP BY id_tramite
            ) s ON t.id = s.id_tramite

            WHERE ${estado === 4 ? '' : `t.estado = ${pool.escape(estado)} and `} t.eliminado = 1 and t.id_entidad = ${pool.escape(entidad)}
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
}