import { v4 as uuid } from 'uuid';

import pool from '../bdConfig.js';

export class Ingresos {
  /**
   * Crear un nuevo ingreso vinculado a un trámite
   */
  crearIngresoDirecto = async (datos) => {
    // console.log(datos);
    const connection = await pool.getConnection(); // Obtenemos conexión para transacción
    try {
      await connection.beginTransaction();

      const {
        id_tramite,
        id_cliente,
        monto,
        tipo,
        fecha_ingreso,
        detalle,
        usuario,
        created_at,
        numero_referencia,
      } = datos;

      // 1. Obtener correlativo
      const [rows] = await connection.query(
        `SELECT MAX(numero) as maximo FROM ingresos WHERE id_tramite = ?`,
        [id_tramite],
      );
      const numero = (rows[0].maximo || 0) + 1;

      // 2. Insertar Ingreso
      const id_ingreso_nuevo = uuid(); // Generas el UUID aquí para usarlo en ambas tablas
      const sqlIngreso = `
      INSERT INTO ingresos (id, id_tramite, id_cliente, numero, monto, monto_original, tipo, fecha_ingreso, detalle, usuario, created_at, estado, tipo_ingreso, numero_referencia)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

      await connection.query(sqlIngreso, [
        id_ingreso_nuevo,
        id_tramite,
        id_cliente,
        numero,
        monto,
        monto,
        tipo,
        fecha_ingreso,
        detalle,
        usuario,
        created_at,
        2,
        1,
        numero_referencia,
      ]);

      // 3. Insertar en Historial de Pagos
      //   const sqlHistorial = `
      //   INSERT INTO historial_pagos (id, id_ingreso, monto_pagado, fecha_pago, metodo_pago, observacion, usuario_id, numero_referencia, created_at)
      //   VALUES (UUID(), ?, ?, ?, ?, ?, ?, ?, ?)
      // `;

      //   await connection.query(sqlHistorial, [
      //     id_ingreso_nuevo,
      //     monto,
      //     fecha_ingreso,
      //     tipo,
      //     'Pago directo registrado', // Aquí poner null o una observación por defecto
      //     usuario,
      //     numero_referencia,
      //     created_at,
      //   ]);

      await connection.commit();
      return true;
    } catch (error) {
      await connection.rollback();
      console.error('Error al crear ingreso y registrar pago:', error);
      throw error;
    } finally {
      connection.release();
    }
  };

  crearIngresoPendiente = async (datos) => {
    // console.log(datos);
    const connection = await pool.getConnection(); // Obtenemos conexión para transacción
    try {
      await connection.beginTransaction();

      const {
        id_tramite,
        id_cliente,
        monto,
        fecha_ingreso,
        detalle,
        usuario,
        created_at,
      } = datos;

      // 1. Obtener correlativo
      const [rows] = await connection.query(
        `SELECT MAX(numero) as maximo FROM ingresos WHERE id_tramite = ?`,
        [id_tramite],
      );
      const numero = (rows[0].maximo || 0) + 1;

      // 2. Insertar Ingreso
      const id_ingreso_nuevo = uuid(); // Generas el UUID aquí para usarlo en ambas tablas
      const sqlIngreso = `
      INSERT INTO ingresos (id, id_tramite, id_cliente, numero, monto, monto_original,  fecha_vencimiento, detalle, usuario, created_at, estado, tipo_ingreso)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

      await connection.query(sqlIngreso, [
        id_ingreso_nuevo,
        id_tramite,
        id_cliente,
        numero,
        0.0,
        monto,
        fecha_ingreso,
        detalle,
        usuario,
        created_at,
        1,
        2,
      ]);

      await connection.commit();
      return true;
    } catch (error) {
      await connection.rollback();
      console.error('Error al crear ingreso y registrar pago:', error);
      throw error;
    } finally {
      connection.release();
    }
  };

  /**
   * Listar ingresos vinculados a un trámite específico
   */
  listarIngresosDirectos = async (entidad) => {
    try {
      const sql = `
        SELECT 
          i.*, 
          t.codigo AS codigo_tramite, t.detalle as detalle_tramite,
          CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) as cliente_nombre,
          CONCAT(u.nombre, ' ', u.ap1) AS usuario_nombre, u.username, u.id as id_usuario   , m.simbolo
        FROM ingresos i
        inner join clientes c on c.id = i.id_cliente
        INNER JOIN tramites t ON i.id_tramite = t.id
        inner join monedas m on m.id = t.id_moneda
          
        LEFT JOIN usuarios u ON i.usuario = u.id
        where t.id_entidad = ? and (i.estado = 2 or i.estado = 3)
        ORDER BY i.fecha_ingreso DESC
      `;
      const [rows] = await pool.query(sql, [entidad]);
      return rows;
    } catch (error) {
      console.error('Error al listar ingresos por trámite:', error);
      throw error;
    }
  };

  listarIngresosPendientes = async (entidad) => {
    try {
      const sql = `
        SELECT 
          i.*, 
          t.codigo AS codigo_tramite, t.detalle as detalle_tramite,
          CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) as cliente_nombre,
          CONCAT(u.nombre, ' ', u.ap1) AS usuario_nombre, u.username, u.id as id_usuario   , m.simbolo
        FROM ingresos i
        inner join clientes c on c.id = i.id_cliente
        INNER JOIN tramites t ON i.id_tramite = t.id
        inner join monedas m on m.id = t.id_moneda
          
        LEFT JOIN usuarios u ON i.usuario = u.id
        where t.id_entidad = ? and (i.estado = 1 or i.estado = 3 or i.estado = 4 )
        ORDER BY i.fecha_ingreso DESC
      `;
      const [rows] = await pool.query(sql, [entidad]);
      return rows;
    } catch (error) {
      console.error('Error al listar ingresos por trámite:', error);
      throw error;
    }
  };
  /**
   * Obtiene lista simplificada de clientes activos para selects
   */
  listarClientesActivos = async (entidad) => {
    try {
      const sql = `
      SELECT id as value, CONCAT(nombre, ' ', ap1, ' ', IFNULL(ap2, '')) as label 
      FROM clientes 
      WHERE estado = 1 and id_entidad = ${pool.escape(entidad)}
      ORDER BY nombre ASC`;
      const [rows] = await pool.query(sql);

      return rows;
    } catch (error) {
      console.error('Error al listar clientes auxiliares:', error);
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

      // console.log(rows);
      return rows;
    } catch (error) {
      console.error('Error al listar ingresos por trámite:', error);
      throw error;
    }
  };

  /**
   * Actualizar un ingreso (incluyendo posibilidad de reasignar trámite)
   */
  actualizar = async (id, datos) => {
    const connection = await pool.getConnection();
    try {
      const {
        monto,
        id_tramite,
        tipo,
        fecha_ingreso,
        detalle,
        updated_at,
        id_cliente,
        usuario,
        numero_referencia,
      } = datos;

      const sql = `
        SELECT  * FROM ingresos i
          inner join tramites t on t.id = i.id_tramite 
        WHERE t.id = ? and t.estado = 1
      `;
      const [rows] = await pool.query(sql, [id_tramite]);

      // console.log(rows.length, id_tramite);

      if (rows.length === 0) return false;

      await connection.beginTransaction();

      // 1. Actualizar la tabla principal de ingresos
      const sqlIngreso = `
      UPDATE ingresos 
      SET monto = ?,monto_original = ?, tipo = ?, fecha_ingreso = ?, detalle = ?, id_cliente = ?, usuario = ?, updated_at = ?, numero_referencia = ?
      WHERE id = ?
    `;
      await connection.query(sqlIngreso, [
        monto,
        monto,
        tipo,
        fecha_ingreso,
        detalle,
        id_cliente,
        usuario,
        updated_at,
        numero_referencia,
        id,
      ]);

      await connection.commit();
      return true;
    } catch (error) {
      await connection.rollback();
      console.error('Error al actualizar ingreso directo:', error);
      throw error;
    } finally {
      connection.release();
    }
  };

  actualizarIngresoPendiente = async (id, datos) => {
    const connection = await pool.getConnection();
    try {
      const { monto, fecha_ingreso, detalle, updated_at, id_cliente, usuario } =
        datos;

      await connection.beginTransaction();

      // 1. Actualizar la tabla principal de ingresos
      console.log(datos, ' modificando datos ingresos pendientes');
      const sqlIngreso = `
      UPDATE ingresos 
      SET monto_original = ?, fecha_vencimiento = ?,   detalle = ?, id_cliente = ?, usuario = ?, updated_at = ?
      WHERE id = ?
    `;
      await connection.query(sqlIngreso, [
        monto,
        fecha_ingreso,
        detalle,
        id_cliente,
        usuario,
        updated_at,
        id,
      ]);

      await connection.commit();
      return true;
    } catch (error) {
      await connection.rollback();
      console.error('Error al actualizar ingreso directo:', error);
      throw error;
    } finally {
      connection.release();
    }
  };

  completarIngreso = async (datos) => {
    const connection = await pool.getConnection();
    try {
      const {
        id,
        idTramite,
        monto,
        tipo,
        fecha_ingreso,
        usuario,
        updated_at,
        numero_referencia,
        revertir,
      } = datos;

      const sql = `
        SELECT  * FROM ingresos i
          inner join tramites t on t.id = i.id_tramite 
        WHERE t.id = ? and t.estado = 1
      `;
      const [rows] = await pool.query(sql, [idTramite]);

      if (rows.length === 0) return false;

      await connection.beginTransaction();

      if (!revertir) {
        // console.log('revertiendo ruta equivocada');
        // 1. Actualizar la tabla principal de ingresos

        const sqlIngreso = `
            UPDATE ingresos 
            SET monto = ?, tipo = ?, fecha_ingreso = ?, usuario = ?, updated_at = ?, numero_referencia = ?, estado = ?
            WHERE id = ?
          `;
        await connection.query(sqlIngreso, [
          monto,
          tipo,
          fecha_ingreso,
          usuario,
          updated_at,
          numero_referencia,
          2,
          id,
        ]);
      } else {
        // console.log(updated_at, id, ' revertiendo');
        // revertir cambios
        const sqlIngreso = `
            UPDATE ingresos 
            SET monto = ?, tipo = ?, fecha_ingreso = ?,  updated_at = ?, numero_referencia = ?, estado = ?
            WHERE id = ?
          `;
        await connection.query(sqlIngreso, [
          0,
          null,
          null,
          updated_at,
          null,
          1,
          id,
        ]);
      }

      await connection.commit();
      return true;
    } catch (error) {
      await connection.rollback();
      console.error('Error al actualizar ingreso directo:', error);
      throw error;
    } finally {
      connection.release();
    }
  };

  /**
   * Eliminar un ingreso
   */
  eliminar = async (id, id_tramite) => {
    const connection = await pool.getConnection();
    try {
      const sql = `
        SELECT  * FROM ingresos i
          inner join tramites t on t.id = i.id_tramite 
        WHERE t.id = ? and t.estado = 1
      `;
      const [rows] = await pool.query(sql, [id_tramite]);

      if (rows.length === 0) return false;

      await connection.beginTransaction();

      // 1. Primero eliminamos el registro del historial relacionado
      // Si no eliminamos esto primero, la base de datos nos dará error
      // de clave foránea (Foreign Key Constraint).

      // 2. Luego eliminamos el ingreso
      const sqlIngreso = `DELETE FROM ingresos WHERE id = ?`;
      const [result] = await connection.query(sqlIngreso, [id]);

      await connection.commit();
      return result.affectedRows > 0;
    } catch (error) {
      await connection.rollback();
      console.error('Error al eliminar ingreso y su historial:', error);
      throw error;
    } finally {
      connection.release();
    }
  };
}
