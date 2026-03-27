import pool from "../bdConfig.js";

export class Honorarios {
  /**
   * Crear un nuevo registro de honorario
   */
  crear = async (datos) => {
    try {
      const { id_tramite, monto, tipo_pago, fecha_ingreso, descripcion, usuario, created_at } = datos;

      // 1. Generar correlativo (numero) por trámite para control interno
      let numero = 1;
      const [ultRow] = await pool.query(
        `SELECT MAX(numero) AS maximo FROM honorarios`
      );

      if (ultRow.length > 0 && ultRow[0].maximo !== null) {
        numero = ultRow[0].maximo + 1;
      }

      // 2. Insertar con UUID y borrado lógico (eliminado = 1)
      const sql = `
        INSERT INTO honorarios (
          id, id_tramite, numero, monto, tipo_pago, 
          fecha_ingreso, descripcion, id_usuario, created_at, updated_at, eliminado
        )
        VALUES (UUID(), ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)
      `;

      const [result] = await pool.query(sql, [
        id_tramite,
        numero,
        monto,
        tipo_pago,
        fecha_ingreso,
        descripcion,
        usuario,   // id_usuario en la tabla
        created_at,
        created_at // updated_at inicial
      ]);

      return result.affectedRows > 0;
    } catch (error) {
      console.error("Error al crear honorario:", error);
      throw error;
    }
  };

  /**
   * Listar honorarios de un trámite (Solo activos)
   */
  listarHonorarios = async () => {
    try {
      const sql = `
        SELECT 
          h.*, 
          t.codigo AS codigo_tramite,
          CONCAT(u.nombre, ' ', u.ap1) AS usuario_nombre, 
          u.username, 
          CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente 

        FROM honorarios h
        INNER JOIN tramites t ON h.id_tramite = t.id
        LEFT JOIN usuarios u ON h.id_usuario = u.id
          LEFT JOIN clientes c ON t.id_cliente = c.id

        WHERE  h.eliminado = 1
        ORDER BY h.fecha_ingreso DESC
      `;
      const [rows] = await pool.query(sql);
      // console.log(rows)
      return rows;
    } catch (error) {
      console.error("Error al listar honorarios:", error);
      throw error;
    }
  };


    listarHonorariosReporte = async (datos) => {
    try {
      const sql = `
        SELECT 
          h.*, 
          t.codigo AS codigo_tramite,
          CONCAT(u.nombre, ' ', u.ap1) AS usuario_nombre, 
          u.username, 
          CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente 

        FROM honorarios h
        INNER JOIN tramites t ON h.id_tramite = t.id
        LEFT JOIN usuarios u ON h.id_usuario = u.id
          LEFT JOIN clientes c ON t.id_cliente = c.id

        WHERE  h.eliminado = 1 and h.fecha_ingreso BETWEEN ${pool.escape(datos.desde)} AND ${pool.escape(datos.hasta)}
        ORDER BY h.fecha_ingreso DESC
      `;
      const [rows] = await pool.query(sql);
      // console.log(rows)
      return rows;
    } catch (error) {
      console.error("Error al listar honorarios:", error);
      throw error;
    }
  };
  /**
   * Obtener un registro por ID
   */
  obtener = async (id) => {
    try {
      const [rows] = await pool.query(
        "SELECT * FROM honorarios WHERE id = ? AND eliminado = 1", 
        [id]
      );
      return rows;
    } catch (error) {
      console.error("Error al obtener honorario:", error);
      throw error;
    }
  };

  /**
   * Actualizar honorario
   */
  actualizar = async (id, datos) => {
    try {
      const { monto, tipo_pago, fecha_ingreso, descripcion, usuario, updated_at } = datos;
      
      const sql = `
        UPDATE honorarios 
        SET monto = ?, tipo_pago = ?, fecha_ingreso = ?, 
            descripcion = ?, usuario_edit = ?, updated_at = ?
        WHERE id = ? AND eliminado = 1
      `;
      
      const [result] = await pool.query(sql, [
        monto, 
        tipo_pago, 
        fecha_ingreso, 
        descripcion, 
        usuario, 
        updated_at, 
        id
      ]);
      return result.affectedRows > 0;
    } catch (error) {
      console.error("Error al actualizar honorario:", error);
      throw error;
    }
  };

  /**
   * Eliminar honorario (Borrado Lógico)
   * En sistemas contables es mejor no usar DELETE físico.
   */
  eliminar = async (id) => {
    try {
      // Cambiamos el estado a 0 en lugar de borrar la fila
      const sql = `UPDATE honorarios SET eliminado = 0 WHERE id = ?`;
      const [result] = await pool.query(sql, [id]);
      return result.affectedRows > 0;
    } catch (error) {
      console.error("Error al eliminar honorario:", error);
      throw error;
    }
  };
}