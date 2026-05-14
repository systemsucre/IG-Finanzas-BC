import pool from "../bdConfig.js";

export class Cliente {
  
  // 1. LISTAR CLIENTES
  listar = async (entidad) => {
    try {
      const sql = `
        SELECT 
            c.id, 
            c.nombre, 
            c.ap1, 
            c.ap2,
            CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS nombre_completo,
            c.ci, 
            c.celular, 
            c.direccion, 
            c.estado, 
            c.created_at,
            c.modified_at,
            c.usuario,
            sum(s.monto) as total_ingresos
        FROM clientes  c
        inner join ingresos s on c.id = s.id_cliente
        
        where id_entidad = ?

        group by c.id
        ORDER BY id DESC `;

      const [rows] = await pool.query(sql,[entidad]);
      return rows;
    } catch (error) {
      console.error("Error al listar clientes:", error);
      throw error;
    }
  };

  // 2. INSERTAR CLIENTE
  insertar = async (datos) => {
    // Validar si el C.I. ya existe en la tabla clientes
    const sqlCi = `SELECT ci FROM clientes WHERE ci = ? and id_entidad = ?`;
    const [rowsCi] = await pool.query(sqlCi,[datos.ci, datos.id_entidad]);

    if (rowsCi.length > 0) {
      return { error: 3 }; // Error: C.I. ya registrado
    }

    // Insertar nuevo cliente
    // Asegúrate de que 'datos' contenga: nombre, ap1, ap2, ci, celular, direccion, created_at, usuario
    const [result] = await pool.query("INSERT INTO clientes SET ?", datos);

    return { id: result.insertId, ...datos };
  };

  // 3. ACTUALIZAR CLIENTE
  actualizar = async (datos) => {
    // Validar C.I. (Que no lo tenga otro cliente con ID diferente)
    const sqlCi = `SELECT ci FROM clientes WHERE ci = ? AND id != ? AND id_entidad = ?`;
    const [rowsCi] = await pool.query(sqlCi,[datos.ci, datos.id, datos.id_entidad]);

    if (rowsCi.length > 0) return { existe: 3 };

    // Actualización de campos según tu esquema de tabla
    const sql = `UPDATE clientes SET 
                nombre = ${pool.escape(datos.nombre)},
                ap1 = ${pool.escape(datos.ap1)},
                ap2 = ${pool.escape(datos.ap2)},
                ci = ${pool.escape(datos.ci)},
                celular = ${pool.escape(datos.celular)},
                direccion = ${pool.escape(datos.direccion)},
                estado = ${pool.escape(datos.estado)},
                usuario = ${pool.escape(datos.usuario)},
                modified_at = ${pool.escape(datos.fecha_)}
                WHERE id = ${pool.escape(datos.id)}`;

    const [res] = await pool.query(sql);

    if (res.affectedRows > 0) {
      return await this.listar();
    } else {
      return { error: 1 };
    }
  };

  // 4. CAMBIAR ESTADO (Activar/Desactivar)
  // Esta función reemplaza a eliminarLogico y sirve para ambos estados
  cambiarEstado = async (datos) => {
    const sql = `UPDATE clientes SET 
                estado = ${pool.escape(datos.estado)}, 
                usuario = ${pool.escape(datos.usuario)}, 
                modified_at = ${pool.escape(datos.fecha_)} 
                WHERE id = ${pool.escape(datos.id)}`;
                
    const [result] = await pool.query(sql);
    
    // Nota: Aquí no borramos sesión porque los clientes no se loguean
    return result.affectedRows > 0;
  };
}