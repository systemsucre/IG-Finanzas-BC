import pool from "../bdConfig.js";

export class Usuario {
  // METODOS




  listar = async (entidad, idExcluir = 0) => {
    try {
      const sql = `
        SELECT 
            u.id, 
            u.id_rol, 
            r.rol AS nombre_rol, 
            u.nombre, 
            u.ap1, 
            u.ap2,
            CONCAT(u.nombre, ' ', u.ap1, ' ', IFNULL(u.ap2, '')) AS nombre_completo,
            u.ci, 
            u.celular, 
            u.direccion, 
            u.username,
            u.estado, 
            u.ultimo_acceso,
            u.created_at
        FROM usuarios u
        INNER JOIN roles r ON u.id_rol = r.id
        WHERE u.id != ? and id_entidad =?
        ORDER BY u.id DESC `;

      // Usamos el formato de arreglos de mysql2 para mayor seguridad (Prepared Statements)
      const [rows] = await pool.query(sql, [idExcluir, entidad]);

      return rows;
    } catch (error) {
      console.error("Error al listar usuarios:", error);
      throw error;
    }
  };


  listarRoles = async () => {
    // Usamos 'id as value' para que coincida con lo que espera el Select1
    const sql = `SELECT id as value, rol as label FROM roles ORDER BY rol ASC`;
    const [rows] = await pool.query(sql);


    return rows;
  };


  insertar = async (datos) => {
    // 1. Validar si el C.I. ya existe
    const sqlCi = `SELECT ci FROM usuarios WHERE ci = ${pool.escape(datos.ci)} and id_entidad = ${pool.escape(datos.id_entidad)}`;
    const [rowsCi] = await pool.query(sqlCi);

    if (rowsCi.length > 0) {
      return { error: 3 }; // Error de C.I. duplicado
    }

    // 2. Validar si el Username ya existe
    const sqlUser = `SELECT username FROM usuarios WHERE username = ${pool.escape(datos.username)}`;
    const [rowsUser] = await pool.query(sqlUser);

    if (rowsUser.length > 0) {
      return { error: 4 }; // Error de nombre de usuario duplicado
    }

    // 3. Insertar nuevo usuario
    const [result] = await pool.query("INSERT INTO usuarios SET ?", datos);

    // Opcional: retornar el usuario recién creado o una lista actualizada
    return { id: result.insertId, ...datos };
  };


  actualizar = async (datos) => {
    // 1. Validar Username (Que no lo tenga otro ID)
    const sqlUser = `SELECT username FROM usuarios WHERE username = ${pool.escape(datos.username)} AND id != ${pool.escape(datos.id)}`;
    const [rowsUser] = await pool.query(sqlUser);

    if (rowsUser.length > 0) return { existe: 4 };

    // 2. Validar C.I. (Que no lo tenga otro ID)
    const sqlCi = `SELECT ci FROM usuarios WHERE ci = ${pool.escape(datos.ci)} AND id_entidad = ${pool.escape(datos.id_entidadS)} AND id != ${pool.escape(datos.id)}`;
    const [rowsCi] = await pool.query(sqlCi);

    if (rowsCi.length > 0) return { existe: 3 };

    // 3. Construcción dinámica del UPDATE
    let sql = `UPDATE usuarios SET 
                id_rol = ${pool.escape(datos.id_rol)},
                nombre = ${pool.escape(datos.nombre)},
                ap1 = ${pool.escape(datos.ap1)},
                ap2 = ${pool.escape(datos.ap2)},
                ci = ${pool.escape(datos.ci)},
                celular = ${pool.escape(datos.celular)},
                direccion = ${pool.escape(datos.direccion)},
                username = ${pool.escape(datos.username)},
                estado = ${pool.escape(datos.estado)},
                usuario = ${pool.escape(datos.usuario)},
                updated_at = ${pool.escape(datos.fecha_)}`;

    // Solo incluir password si se envió uno nuevo
    if (datos.password && datos.password.trim() !== "") {
      sql += `, password = ${pool.escape(datos.password)}`;
    }

    sql += ` WHERE id = ${pool.escape(datos.id)}`;

    const [res] = await pool.query(sql);

    if (res.affectedRows > 0) {
      // Opcional: Cerrar sesiones activas si el usuario cambió datos sensibles
      // await pool.query("DELETE FROM sesion WHERE usuario_id = ?", [datos.id]);

      // Retornamos la lista actualizada para que el frontend refresque la tabla
      return await this.listar();
    } else {
      return { error: 1 };
    }
  };

  eliminarLogico = async (datos) => {
    // Simplemente cambiamos el estado a 0
    const sql = `UPDATE usuarios SET  estado = ${pool.escape(datos.estado)} , usuario =${pool.escape(datos.usuario)}, updated_at = ${pool.escape(datos.fecha_)}  WHERE id = ${pool.escape(datos.id)}`;
    const [result] = await pool.query(sql);
    if (result.affectedRows > 0) {
      pool.query(`delete from sesion where idusuario = ${pool.escape(datos.id)}`)
      return true
    } else return false
  };

  // Dentro de tu clase de Usuarios
  cambiarMiContraseña = async ({ pass, pass1, fecha_, usuario }) => {
    // 1. Verificamos si la contraseña actual coincide
    // NOTA: Si usas bcrypt, aquí deberías usar bcrypt.compare
    const sqlExists = `SELECT id FROM usuarios WHERE password = ? AND id = ?`;
    const [result] = await pool.query(sqlExists, [pass, usuario]);

    if (result.length === 0) return false;

    // 2. Actualizamos
    const sqlUpdate = `UPDATE usuarios SET password = ?, updated_at = ? WHERE id = ?`;
    await pool.query(sqlUpdate, [pass1, fecha_, usuario]);

    return true;
  };

  actualizarMiPerfil = async (datos) => {
    const { nombre, ap1, ap2, celular, ci, direccion, fecha_, usuario } = datos;

    // 1. Validar si el CI ya existe en otro usuario
    const sqlCheck = `SELECT id FROM usuarios WHERE ci = ? AND id != ?`;
    const [existe] = await pool.query(sqlCheck, [ci, usuario]);

    if (existe.length > 0) return { existe: 1 };

    // 2. Actualizar datos
    const sqlUpdate = `
        UPDATE usuarios SET 
            nombre = ?, ap1 = ?, ap2 = ?, celular = ?, 
            ci = ?, direccion = ?, updated_at = ? 
        WHERE id = ?`;

    await pool.query(sqlUpdate, [nombre, ap1, ap2, celular, ci, direccion, fecha_, usuario]);

    // 3. Retornar el perfil actualizado
    return await this.miPerfil(usuario);
  };

  miPerfil = async (id) => {
    const sqlUser = `
        SELECT 
            m.id, m.ci, m.nombre, m.ap1, m.ap2, m.direccion, username,
            CONCAT(m.nombre, ' ', m.ap1, ' ', IFNULL(m.ap2, '')) AS nombre_completo, 
             m.ci, m.celular, 
            r.rol as rol
        FROM usuarios m
        LEFT JOIN roles r ON r.id = m.id_rol
        
        WHERE m.id = ?`;

    const [result] = await pool.query(sqlUser, [id]);
    return result;
  };

  miSesiones = async (id) => {
    const sqlUser = `
        SELECT 
             s.id, s.fecha, s.hora,s.navegador, s.so, s.zonaHoraria, s.ip, s.metadata
        FROM usuarios u
        LEFT JOIN sesion s ON u.id = s.idUsuario
        
        WHERE u.id = ?`;

    const [result] = await pool.query(sqlUser, [id]);
    return result;
  };

  eliminarSesion = async (id) => {
    const sqlUser = `
        delete from sesion
        
        WHERE id = ?`;

    const [result] = await pool.query(sqlUser, [id]);
    return result.affectedRows > 0;
  };

}
