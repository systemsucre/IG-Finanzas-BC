import { Router } from "express"
import { Usuario } from "../modelo/admin/usuario.js"
import { actualizarMiPerfil, cambiarMiContraseña } from '../validacion/admin/usuario.js'
import { registrarAuditoria } from "../modelo/auditoria.js"

//const modelo from "../modelo/usuario.js"
// desde esta plantilla se importa las funcionalidades de los controladores de los modulos


const rutas = Router()
const usuarios = new Usuario()


rutas.post("/ver", async (req, res) => {
    // console.log(req.body.usuario, 'mi perfil')
    try {
        const resultado = await usuarios.miPerfil(req.body.usuario)
        return res.json({ ok: true, data: resultado })
    } catch (error) {
        console.log(error)
        return res.json({ error: 500, msg: error.sqlMessage });
    }
})

rutas.post("/cambiarMiContrasena", cambiarMiContraseña, async (req, res) => {
    try {
        const { pass, pass1, fecha_, usuario, datosAuditoriaExtra } = req.body;
        const actualizado = await usuarios.cambiarMiContraseña({ pass, pass1, fecha_, usuario });

        if (!actualizado) {
            return res.json({ ok: false, msg: 'Contraseña actual incorrecta' });
        }

        registrarAuditoria(req, {
            usuario_id: req.body.usuario, // El ID que viene del frontend
            accion: 'UPDATE MY PASSWORD',
            tabla: 'usuarios',
            detalle: req.body, // Datos que se enviaron
            datosAuditoriaExtra, fecha: fecha_
        });

        return res.json({ ok: true, msg: 'La contraseña se ha cambiado correctamente' });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ ok: false, msg: error.sqlMessage || 'Error interno' });
    }
});

rutas.post("/actualizarMiPerfil", actualizarMiPerfil, async (req, res) => {
    try {
        const { datosAuditoriaExtra } = req.body
        const result = await usuarios.actualizarMiPerfil(req.body);

        if (result.existe === 1) {
            return res.json({ ok: false, msg: 'Este CI/Correo ya está registrado por otro usuario' });
        }
        registrarAuditoria(req, {
            usuario_id: req.body.usuario, // El ID que viene del frontend
            accion: 'UPDATE MY PROFILE',
            tabla: 'usuarios',
            detalle: req.body, // Datos que se enviaron
            datosAuditoriaExtra, fecha: req.body.fecha_
        });
        return res.json({
            ok: true,
            data: result[0], // miPerfil devuelve un array, enviamos el primer objeto
            msg: 'Su perfil se ha actualizado correctamente'
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ ok: false, msg: error.sqlMessage || 'Error interno' });
    }
});



export default rutas;