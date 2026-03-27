import pool from "../bdConfig.js";

export class Salidas {


  obtenerSalida = async (id) => {
    try {
      const sql = `
       SELECT s.*, t.codigo AS codigo_tramite, concat(u.nombre ,' ', u.ap1) as usuario_nombre
        FROM salidas s
        INNER JOIN tramites t ON s.id_tramite = t.id
        inner join usuarios u on u.id = s.usuario_solicita_id
        WHERE s.id = ${pool.escape(id)}`;
      const [rows] = await pool.query(sql);
      // console.log(rows, '   tramites')

      return rows;
    } catch (error) {
      console.error("Error al listar trámites:", error);
      throw error;
    }
  };

  /**
   * Listar salidas de un trámite específico
   */
  listar = async (id) => {
    try {
      const sql = `
        SELECT s.*, t.codigo AS codigo_tramite, concat(u.nombre ,' ', u.ap1) as usuario_nombre
        FROM salidas s
        INNER JOIN tramites t ON s.id_tramite = t.id
        inner join usuarios u on u.id = s.usuario_solicita_id
        where id_tramite = ${pool.escape(id)}
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




  /**
   * Lógica de flujo de estados
   */
  cambiarEstado = async (id, nuevoEstado, fecha, usuarioId) => {
    try {
      let sql = "";
      let parametros = [];
      const fechaActual = fecha;

      switch (Number(nuevoEstado)) {
        case 2: // APROBAR
          sql = `UPDATE salidas SET estado = 2, usuario_aprueba_id = ?, fecha_aprobacion = ? WHERE id = ? AND estado = 1`;
          parametros = [usuarioId, fechaActual, id];
          break;
        case 3: // DESPACHAR
          sql = `UPDATE salidas SET estado = 3, usuario_despacha_id = ?, fecha_despacho = ? WHERE id = ? AND estado = 2`;
          parametros = [usuarioId, fechaActual, id];
          break;
        case 4: // RECHAZAR
          sql = `UPDATE salidas SET estado = 4 WHERE id = ? AND estado < 3`;
          parametros = [id];
          break;

        case 5: // HABILITAR EDICION
          sql = `UPDATE salidas SET estado = 1 WHERE id = ? AND estado > 1`;
          parametros = [id];
          break;
        default:
          throw new Error("Estado no válido para esta operación");
      }

      const [result] = await pool.query(sql, parametros);
      return result.affectedRows > 0;
    } catch (error) {
      console.error("Error al cambiar estado:", error);
      throw error;
    }
  };

}