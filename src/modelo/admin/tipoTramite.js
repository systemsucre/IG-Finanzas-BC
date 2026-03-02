import pool from "../bdConfig.js";

export class TipoTramite {

  /**
   * Lista todos los trámites con datos de auditoría básica
   */
  listar = async (entidad) => {
    try {
      const sql = `
        SELECT 
            id, 
            tipo_tramite, codigo,
            estado, 
            usuario, 
            created_at, 
            updated_at 
        FROM tipo_tramites where id_entidad = ${pool.escape(entidad)}
        ORDER BY id DESC`;
      const [rows] = await pool.query(sql);
      return rows;
    } catch (error) {
      console.error("Error al listar tipos de trámites:", error);
      throw error;
    }
  };

  /**
   * Registro de nuevo trámite con auditoría
   * @param {Object} datos - { tipo_tramite, usuario, created_at }
   */
  insertar = async (datos) => {
    try {
      // 1. Validar duplicados
      const sqlCheck = `
      SELECT tipo_tramite, codigo FROM tipo_tramites 
      WHERE (tipo_tramite = ${pool.escape(datos.tipo_tramite)} OR codigo = ${pool.escape(datos.codigo)})
      AND id_entidad = ${pool.escape(datos.id_entidad)}`; // Aseguramos que solo compare con registros activos

      const [rows] = await pool.query(sqlCheck);

      if (rows.length > 0) {
        // Identificamos qué es lo que se está repitiendo para informar al usuario
        const repetido = rows[0].codigo === datos.codigo ? 'código' : 'nombre de tipo';
        return { existe: 1, mensaje: `El ${repetido} ya está registrado en esta entidad.` };
      }

      // 2. Insertar usando el objeto directo (mysql2 mapea las columnas)
      const [result] = await pool.query("INSERT INTO tipo_tramites SET ?", datos);

      return { id: result.insertId, ...datos };
    } catch (error) {
      console.error("Error al insertar trámite:", error);
      throw error;
    }
  };

  /**
   * Actualización con seguimiento de cambios
   * @param {Object} datos - { id, tipo_tramite, usuario, updated_at }
   */
actualizar = async (datos) => {
  try {
    // 1. Validar duplicados agrupando correctamente los criterios
    // Buscamos cualquier registro que NO sea el actual, 
    // pero que tenga el mismo nombre O el mismo código dentro de la misma entidad.
    const sqlCheck = `
      SELECT tipo_tramite, codigo FROM tipo_tramites 
      WHERE id != ${pool.escape(datos.id)} 
      AND id_entidad = ${pool.escape(datos.id_entidadS)}
      AND (tipo_tramite = ${pool.escape(datos.tipo_tramite)} OR codigo = ${pool.escape(datos.codigo)})
      `; 

    const [rows] = await pool.query(sqlCheck);

    if (rows.length > 0) {
      // Determinamos cuál es el culpable exacto
      const esCodigo = rows.some(r => r.codigo === datos.codigo);
      const esNombre = rows.some(r => r.tipo_tramite === datos.tipo_tramite);
      
      let mensaje = esCodigo && esNombre 
        ? "El nombre y el código ya existen en otros registros." 
        : esCodigo 
          ? "El código ya está registrado." 
          : "El nombre de tipo de trámite ya existe.";

      return { existe: 1, mensaje };
    }

    // 2. Ejecutar la actualización con NOW() para asegurar la fecha del servidor
    const sql = `
      UPDATE tipo_tramites SET 
        tipo_tramite = ${pool.escape(datos.tipo_tramite)},
        codigo = ${pool.escape(datos.codigo)},
        usuario = ${pool.escape(datos.usuario)},
        updated_at = ${pool.escape(datos.updated_at)}
      WHERE id = ${pool.escape(datos.id)}`;

    const [res] = await pool.query(sql);

    return res.affectedRows > 0 ? await this.listar() : { error: 1 };

  } catch (error) {
    console.error("Error al actualizar tipo de trámite:", error);
    throw error;
  }
};
  /**
   * Eliminación Lógica (Activar/Desactivar)
   * @param {Object} datos - { id, estado, usuario, updated_at }
   */
  eliminarLogico = async (datos) => {
    try {
      const sql = `UPDATE tipo_tramites SET 
                   estado = ${pool.escape(datos.estado)},
                   usuario = ${pool.escape(datos.usuario)},
                   updated_at = ${pool.escape(datos.updated_at)}
                   WHERE id = ${pool.escape(datos.id)}`;

      const [result] = await pool.query(sql);
      return result.affectedRows > 0;
    } catch (error) {
      console.error("Error en cambio de estado:", error);
      throw error;
    }
  };
}