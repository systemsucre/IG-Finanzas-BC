import express from 'express';
import pool from '../modelo/bdConfig.js';
import { KEY } from '../config.js';

import jwt from 'jsonwebtoken';

import { getTime, getDate } from 'util-tiempo';

// MI PERFIL
// OPERATIVO
import miPerfil from '../controlador/miPerfil.js';

// Admiministrador
import usuario from '../controlador/admin/usuario.js';
import clientes from '../controlador/admin/clientes.js';
import tipoTramite from '../controlador/admin/tipoTramites.js';
import Tramite from '../controlador/admin/Tramites.js';

// MOVIMIENTOS
import salidas from '../controlador/movimientos/Salidas.js';
import Ingresos from '../controlador/movimientos/ingresos.js';
import boleta from '../controlador/movimientos/boleta.js';

import honorarios from '../controlador/movimientos/honorarios.js';

//COMUUN
import comuun from '../controlador/comun.js';

// import { createOrder, recivedWebhook } from "../controlador/controller/payment.controller.js";

const rutas = express();

// rutas.get('/modificar', async (req, res) => {
//   console.log('Haciendo correcciones');
//   const sql = `SELECT * FROM salidas  `;
//   const [result] = await pool.query(sql);
//   for (let i of result) {
//     pool.query(
//       `
//       update salidas set usuario_aprueba_id = ?, fecha_aprobacion = ?, usuario_despacha_id  = ?, 	fecha_despacho = ?
//       `,
//       [
//         i.usuario_solicita_id,
//         i.fecha_solicitud,
//         i.usuario_solicita_id,
//         i.fecha_solicitud,
//       ],
//     );
//   }
// });

// +*********************************************************** login ****************************************

rutas.get('/', async (req, res) => {
  try {
    // console.log(req.query.viva)
    const sql = `SELECT 
          u.id,
          u.celular,
          u.nombre, u.ap1,
          e.id as id_entiad,
          e.id as id_entidad, 
          e.nombre_corto as entidad, 
          UPPER(r.rol) as rol,  
          r.id as idrol,
          u.username, e.id_moneda as moneda
          from usuarios u 

          inner join roles r on u.id_rol = r.id
          inner join entidad e on e.id = u.id_entidad 
          inner join monedas m on m.id = e.id_moneda
          where u.username = ${pool.escape(req.query.intel)} and u.password = ${pool.escape(req.query.viva)} and u.estado = true`;
    const [result] = await pool.query(sql);
    // console.log(result, 'iniciio de sesion', req.query.intel, req.query.viva)
    if (result.length === 1) {
      const payload = {
        usuario: result[0].ci,
        name: result[0].nombre,
        servicio: result[0].celular,
        fecha: new Date(),
      };
      const token = jwt.sign(payload, KEY, {
        expiresIn: '3d',
      });

      const idusuario = result[0].id;
      let fecha = getDate({ timeZone: 'America/La_Paz' });
      const datos = {
        idusuario,
        usuario: result[0].username,
        titular: result[0].nombre,
        rol: result[0].idrol,
        id_entidad: result[0].id_entidad,
        entidad: result[0].entidad,
        token,
        fecha:
          fecha.split('/')[2] +
          '-' +
          fecha.split('/')[1] +
          '-' +
          fecha.split('/')[0],
        hora: getTime({ timezone: 'America/La_Paz' }),
      };

      const [sesion] = await pool.query(`INSERT INTO sesion SET ?`, datos);
      // console.log('dentro del bloque', sesion)

      if (sesion.insertId > 0) {
        pool.query(`update usuarios SET ultimo_acceso= ${pool.escape(fecha.split('/')[2] + '-' + fecha.split('/')[1] + '-' + fecha.split('/')[0] + ' ' + getTime({ timezone: 'America/La_Paz' }))} where 
        id= ${pool.escape(idusuario)}
        `);
        return res.json({
          id_: idusuario,
          moneda: result[0].moneda,
          token: token,
          username: result[0].username,
          nombre: result[0].nombre + ' ' + result[0].ap1,
          celular: result[0].celular,
          rol_des: result[0].rol,
          numRol: result[0].idrol,
          entidad: result[0].entidad,
          ok: true,
          msg: 'Acceso correcto',
        });
      } else {
        return res.json({ msg: 'Intente nuevamente ', ok: false });
      }
    } else {
      return res.json({ msg: 'El usuario no existe !', ok: false });
    }
  } catch (error) {
    console.log(error);
    return res.json({ msg: 'El servidor no responde !', ok: false });
  }
});

rutas.post('/logout', (req, res) => {
  try {
    // console.log(req.body, ' eliminar token bd');
    if (req.body.token) {
      const sql = `delete from sesion where token = ${pool.escape(
        req.body.token,
      )} `;
      pool.query(sql);
    }
  } catch (error) {}
});

//VERIFICACION DE LA SESION QUE ESTA ALMACENADA EN LA BD
const verificacion = express();
verificacion.use((req, res, next) => {
  try {
    // 1. Obtenemos la fecha real de Bolivia ignorando el reloj del servidor
    const ahoraBolivia = new Date(
      new Date().toLocaleString('en-US', { timeZone: 'America/La_Paz' }),
    );

    // 2. Extraemos los componentes (esto evita que se adelante un día)
    const anio = ahoraBolivia.getFullYear();
    const mes = String(ahoraBolivia.getMonth() + 1).padStart(2, '0');
    const dia = String(ahoraBolivia.getDate()).padStart(2, '0');

    // 3. Formato final para MariaDB (YYYY-MM-DD)
    const fechaFormateada = `${anio}-${mes}-${dia}`;

    // 4. Formato con hora para tu variable req.body.fecha_
    const horaBolivia = getTime({ timezone: 'America/La_Paz' });
    const formatoCompleto = `${fechaFormateada} ${horaBolivia}`;
    // console.log(formato, ' hora peru')
    const bearerHeader = req.headers['authorization'];

    if (typeof bearerHeader !== 'undefined') {
      const bearetoken = bearerHeader.split(' ')[1];

      jwt.verify(bearetoken, KEY, async (errtoken, authData) => {
        if (errtoken) {
          // console.log('error en la verificacion token alterado: ', bearetoken)
          pool.query('delete from sesion where token = ?', [bearetoken]);
          return res.json({
            ok: false,
            sesion: false,
            msg: 'Su token a expirado, cierre sesion y vuelva a iniciar sesion',
          });
        }

        const sql = `SELECT idusuario, usuario, rol,  titular, id_entidad, entidad, all_permision from sesion s 
                  where token  = ${pool.escape(bearetoken)}`;
        const [result] = await pool.query(sql);

        if (result.length > 0) {
          req.body.id_entidadS = await result[0].id_entidad;
          req.body.entidadS = await result[0].entidad;
          req.body.usuario = await result[0].idusuario;
          req.body.usernameS = await result[0].usuario;
          req.body.srol = await result[0].rol;
          req.body.nombreusuarioS = await result[0].titular;
          req.body.all_permisionS = await result[0].all_permision;
          req.body.fecha_ = formatoCompleto;
          // console.log(req.body, ' antes de pasar la validación'
          next();
        } else {
          console.log(' respuesta false');
          return res.json({
            ok: false,
            sesion: false,
            msg: 'El Servidor no puede identificar su autencidad, cierre sesion y vuelva a intentar VERIFICACION',
          });
        }
      });
    } else {
      return res.json({
        ok: false,
        sesion: false,
        msg: 'El Servidor no puede interpretar su autenticidad',
      });
    }
  } catch (error) {
    console.log(error);
    return res.json({ ok: false, sesion: false, msg: 'Error en el servidor' });
  }
});

const admin = (req, res, next) => {
  if (parseInt(req.body.srol) === 1) {
    // console.log(req.body.numero, 'numero rol')
    next();
  } else
    return res.json({
      ok: false,
      sesion: false,
      msg: 'El Servidor no puede identificar su autencidad, cierre sesion y vuelva a intentar MIDLEWARE ADMIN',
    });
};

const AdminGerenteCajero = (req, res, next) => {
  if (
    parseInt(req.body.srol) === 2 ||
    parseInt(req.body.srol) === 3 ||
    parseInt(req.body.srol) === 1
  ) {
    // console.log(req.body.numero, 'numero rol')
    next();
  } else
    return res.json({
      ok: false,
      sesion: false,
      msg: 'El Servidor no puede identificar su autencidad, cierre sesion y vuelva a intentar MIDLEWARE ADMIN',
    });
};

// ADMINISTRADOR
rutas.use('/usuarios', verificacion, admin, usuario);
rutas.use('/clientes', verificacion, AdminGerenteCajero, clientes);
rutas.use('/tipo-tramites', verificacion, admin, tipoTramite);
rutas.use('/tramites', verificacion, AdminGerenteCajero, Tramite);

// MOVIMIENTOS
rutas.use('/salidas', verificacion, salidas);
rutas.use('/ingresos', verificacion, Ingresos);
rutas.use('/boletas', verificacion, boleta);

rutas.use('/honorarios', verificacion, AdminGerenteCajero, honorarios);

// comuun
rutas.use('/comuun', verificacion, comuun);

rutas.use('/miPerfil', verificacion, miPerfil);

export default rutas;
