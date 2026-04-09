import pool from "../bdConfig.js";

export class Tramite {


  /**
   * Obtiene lista simplificada de tipos de trámites activos para selects
   */
  listarTiposActivos = async (entidad) => {
    try {
      const sql = `SELECT id as value, tipo_tramite as label FROM tipo_tramites WHERE estado = 1 and id_entidad = ? ORDER BY tipo_tramite ASC`;
      const [rows] = await pool.query(sql, [entidad]);
      return rows;
    } catch (error) {
      console.error("Error al listar tipos auxiliares:", error);
      throw error;
    }
  };

  listarModendas = async () => {
    try {
      const sql = `SELECT id as value, nombre as label FROM monedas`;
      const [rows] = await pool.query(sql);
      return rows;
    } catch (error) {
      console.error("Error al listar tipos auxiliares:", error);
      throw error;
    }
  };

  /**
   * Registro de un nuevo trámite
   * @param {Object} datos - Incluye id_cliente, codigo, fechas, id_tipo_tramite, costo, etc.
   */
  // Dentro de tu clase Tramites
  insertar = async (datos) => {
    try {
      // 1. Obtener el prefijo del tipo de trámite (ej: 'ACC')
      const [tipo] = await pool.query(
        "SELECT codigo FROM tipo_tramites WHERE id = ? ",
        [datos.id_tipo_tramite]
      );

      if (!tipo || tipo.length === 0) {
        throw new Error("El tipo de trámite seleccionado no existe.");
      }

      const prefijo = tipo[0].codigo; // Ej: "ACC"

      // 2. Buscar el último código que empiece con ese prefijo
      const [ultimo] = await pool.query(
        "SELECT codigo FROM tramites WHERE  codigo LIKE ? ORDER BY created_at DESC LIMIT 1",
        [`${prefijo}-%`]
      );

      let nuevoNumero = 1;
      if (ultimo && ultimo.length > 0) {
        // Separamos por el guion y tomamos la segunda parte
        const partes = ultimo[0].codigo.split('-');
        const ultimoNumero = parseInt(partes[1]);

        if (!isNaN(ultimoNumero)) {
          nuevoNumero = ultimoNumero + 1;
        }
      }

      // 1. Verificamos la existencia y estado del trámite
      let numero = 1; // Valor por defecto
      const [ultRow] = await pool.query(`SELECT MAX(numero) AS maximo FROM tramites where id_entidad = ?`, [datos.id_entidadS]);

      // Si hay registros, el resultado no será null. 
      // Sumamos 1 para el siguiente correlativo.
      if (ultRow.length > 0 && ultRow[0].maximo !== null) {
        numero = ultRow[0].maximo + 1;
      } else {
        numero = 1;
      }

      // 3. Formatear con 6 dígitos: ACC-000001
      const codigoFinal = `${prefijo}-${nuevoNumero.toString().padStart(6, '0')}`;
      // 2. Insertar con UUID generado por MySQL
      const sql = `
      INSERT INTO tramites (
        id,  codigo, numero, fecha_ingreso, fecha_finalizacion, 
        id_tipo_tramite, detalle, costo, otros, estado, 
        usuario, created_at, eliminado, id_entidad, id_moneda
      ) VALUES (UUID(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1, ?,?)
    `;

      const valores = [
        codigoFinal,
        numero,
        datos.fecha_ingreso,
        datos.fecha_finalizacion,
        datos.id_tipo_tramite,
        datos.detalle,
        datos.costo,
        datos.otros,
        datos.estado,
        datos.usuario, // id del usuario que crea
        datos.created_at || new Date(),
        datos.id_entidadS,
        datos.id_moneda
      ];

      const [result] = await pool.query(sql, valores);

      // 3. (Opcional) Obtener el ID recién creado si necesitas devolverlo
      // Como MySQL genera el UUID internamente, result.insertId no servirá (es para autoincrementales)
      return {
        affectedRows: result.affectedRows,
        codigo: codigoFinal,
        status: "success"
      };

    } catch (error) {
      console.error("Error en modelo Tramites:", error);
      throw error;
    }
  };

  /**
   * Actualización de un trámite existente
   */
  actualizar = async (datos) => {
    try {
      let modificarCodigo = false
      const [tipo_dif] = await pool.query(
        "SELECT * FROM tramites WHERE id_tipo_tramite = ? and id = ? ",
        [datos.id_tipo_tramite, datos.id]
      );
      let codigoFinal = null;
      // console.log(tipo_dif.length, ' modificar codigo si/no')

      if (tipo_dif.length === 0) {
        modificarCodigo = true

        const [tipo] = await pool.query(
          "SELECT codigo FROM tipo_tramites WHERE id = ? ",
          [datos.id_tipo_tramite]
        );

        if (!tipo || tipo.length === 0) {
          throw new Error("El tipo de trámite seleccionado no existe.");
        }

        const prefijo = tipo[0].codigo; // Ej: "ACC"

        // 2. Buscar el último código que empiece con ese prefijo
        const [ultimo] = await pool.query(
          "SELECT codigo FROM tramites WHERE  codigo LIKE ? and id_entidad = ? ORDER BY created_at DESC LIMIT 1 ",
          [`${prefijo}-%`, datos.id_entidadS]
        );

        let nuevoNumero = 1;
        if (ultimo && ultimo.length > 0) {
          // Separamos por el guion y tomamos la segunda parte
          const partes = ultimo[0].codigo.split('-');
          const ultimoNumero = parseInt(partes[1]);

          if (!isNaN(ultimoNumero)) {
            nuevoNumero = ultimoNumero + 1;
          }
        }

        // 1. Verificamos la existencia y estado del trámite
        let numero = 1; // Valor por defecto
        const [ultRow] = await pool.query(`SELECT MAX(numero) AS maximo FROM tramites where id_entidad = ?`, [datos.id_entidadS]);

        // Si hay registros, el resultado no será null. 
        // Sumamos 1 para el siguiente correlativo.
        if (ultRow.length > 0 && ultRow[0].maximo !== null) {
          numero = ultRow[0].maximo + 1;
        } else {
          numero = 1;
        }

        // 3. Formatear con 6 dígitos: ACC-000001
        codigoFinal = `${prefijo}-${nuevoNumero.toString().padStart(6, '0')}`;
      }

      const sql = `UPDATE tramites SET 
                  ${modificarCodigo ? `codigo = ${pool.escape(codigoFinal)},` : ``}
                   fecha_ingreso = ${pool.escape(datos.fecha_ingreso)},
                   fecha_finalizacion = ${pool.escape(datos.fecha_finalizacion)},
                   id_tipo_tramite = ${pool.escape(datos.id_tipo_tramite)},
                   detalle = ${pool.escape(datos.detalle)},
                   estado = ${pool.escape(datos.estado)},
                   costo = ${pool.escape(datos.costo)},
                   otros = ${pool.escape(datos.otros)},
                   usuario = ${pool.escape(datos.usuario)},
                   id_moneda = ${pool.escape(datos.id_moneda)},
                   modified_at = ${pool.escape(datos.modified_at)}
                   WHERE id = ${pool.escape(datos.id)}`;

      const [res] = await pool.query(sql);
      // console.log(sql)
      return res.affectedRows > 0 ? { ok: true } : { error: 1 };
    } catch (error) {
      console.error("Error al actualizar trámite:", error);
      throw error;
    }
  };



  /**
   * Eliminar logico
   */
  eliminar = async (datos) => {
    try {
      // Cambiamos DELETE por UPDATE
      // Asumimos que estado = 1 es ACTIVO y estado = 0 es ELIMINADO/INACTIVO
      const sql = `UPDATE tramites SET 
                eliminado = ${pool.escape(datos.estado)}, 
                usuario = ${pool.escape(datos.usuario)}, 
                modified_at = ${pool.escape(datos.fecha_)} 
                WHERE id = ${pool.escape(datos.id)}`;

      const [result] = await pool.query(sql);

      // Retornamos true si se encontró el registro y se modificó
      return result.affectedRows > 0;
    } catch (error) {
      console.error("Error al realizar eliminación lógica del trámite:", error);
      throw error;
    }
  };
}