import pool from '../bdConfig.js';

import { Tramite } from '../admin/Tramite.js';
const tramite1 = new Tramite();
export class Salidas {
  /**
   * Listar salidas de un trámite específico
        LEFT JOIN clientes c ON t.id_cliente = c.id
        CONCAT(c.nombre, ' ', c.ap1, ' ', IFNULL(c.ap2, '')) AS cliente -- Opcional: quién la creó

   * 
   */
  listar = async (id_tramite) => {
    console.log(id_tramite, ' listar boletas');
    try {
      const sql = `
        SELECT s.*, t.codigo AS codigo_tramite, concat(u.nombre ,' ', u.ap1) as usuario_nombre, m.simbolo

        FROM salidas s
        INNER JOIN tramites t ON s.id_tramite = t.id
                inner join monedas m on m.id = t.id_moneda

        inner join usuarios u on u.id = s.usuario_solicita_id   

        WHERE s.id_tramite = ? 
        ORDER BY s.numero DESC
      `;
      const [rows] = await pool.query(sql, [id_tramite]);
      // console.log(rows)
      return rows;
    } catch (error) {
      console.error('Error al listar salidas:', error);
      throw error;
    }
  };
}
