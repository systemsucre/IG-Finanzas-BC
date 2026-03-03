import pool from "../bdConfig.js";

export class Ingresos {
  /**
   * Crear un nuevo ingreso vinculado a un trámite
   */
  crear = async (datos) => {
    try {
      // Añadimos id_tramite a la desestructuración
      const { id_tramite, id_cliente, monto, tipo, fecha_ingreso, detalle, usuario, created_at } = datos;

      // 1. Verificamos la existencia y estado del trámite
      let numero = 1; // Valor por defecto
      const [ultRow] = await pool.query(`SELECT MAX(numero) AS maximo FROM ingresos where id_tramite = ${pool.escape(id_tramite)} `);

      // Si hay registros, el resultado no será null. 
      // Sumamos 1 para el siguiente correlativo.
      if (ultRow.length > 0 && ultRow[0].maximo !== null) {
        numero = ultRow[0].maximo + 1;
      } else {
        numero = 1;
      }

      const sql = `
        INSERT INTO ingresos (id,  id_tramite,id_cliente, numero, monto, tipo, fecha_ingreso, detalle, usuario, created_at, updated_at)
        VALUES (UUID(), ?, ?,?,?,?, ?, ?, ?, ?, ?)
      `;
      const [result] = await pool.query(sql, [
        id_tramite,
        id_cliente,
        numero,
        monto,
        tipo,
        fecha_ingreso,
        detalle,
        usuario,
        created_at,
        created_at
      ]);
      return result.affectedRows > 0;
    } catch (error) {
      console.error("Error al crear ingreso:", error);
      throw error;
    }
  };

  /**
   * Listar ingresos vinculados a un trámite específico
   */
  listarPorTramite = async (idTramite) => {
    try {
      const sql = `
        SELECT 
          i.*, 
          t.codigo AS codigo_tramite,
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
   * Listar ingresos vinculados a un trámite específico
   */
  obtener = async (id) => {
    try {
      const sql = `
        SELECT  * FROM ingresos 
        WHERE id = ?
      `;
      const [rows] = await pool.query(sql, [id]);

      // console.log(rows)
      return rows;
    } catch (error) {
      console.error("Error al listar ingresos por trámite:", error);
      throw error;
    }
  };


  /**
   * Actualizar un ingreso (incluyendo posibilidad de reasignar trámite)
   */
  actualizar = async (id, datos) => {
    try {
      const { monto, tipo, fecha_ingreso, detalle, updated_at,id_cliente, usuario } = datos;
      const sql = `
        UPDATE ingresos 
        SET  monto = ?, tipo = ? , fecha_ingreso = ?, detalle = ?,id_cliente = ?, usuario=?, updated_at = ?
        WHERE id = ? 
      `;
      // console.log(id, ' id_del modelo')
      const [result] = await pool.query(sql, [monto, tipo, fecha_ingreso, detalle,id_cliente, usuario, updated_at, id]);
      return result.affectedRows > 0;
    } catch (error) {
      console.error("Error al actualizar ingreso:", error);
      throw error;
    }
  };

  /**
   * Eliminar un ingreso
   */
  eliminar = async (id) => {
    try {
      const sql = `DELETE FROM ingresos WHERE id = ? `;
      const [result] = await pool.query(sql, [id]);
      return result.affectedRows > 0;
    } catch (error) {
      console.error("Error al eliminar ingreso:", error);
      throw error;
    }
  };
}