import { Router } from "express";
import { BoletaIngresos } from "../../modelo/movimientos/boletasIngresos.js";
import { registrarAuditoria } from '../../modelo/auditoria.js';
import { guardar } from "../../validacion/cajero/ingresosBoletas.js";

const rutas = Router();
const objBoleta = new BoletaIngresos();

rutas.post("/listar", async (req, res) => {
    try {
        const resultado = await objBoleta.listarBoletas(req.body.id_entidadS);
        return res.json({ data: resultado, ok: true });
    } catch (error) {
        console.log(error)
        return res.status(500).json({ ok: false, msg: "Error al listar boletas" });
    }
});


rutas.post("/detalles", async (req, res) => {
    try {
        const resultado = await objBoleta.obtenerItemsPorBoleta(req.body.codigo_boleta);
        return res.json({ data: resultado, ok: true });
    } catch (error) {
        console.log(error)
        return res.status(500).json({ ok: false, msg: "Error al listar boletas" });
    }
});

// ENDPOINT: Obtener clientes para el combobox
rutas.post('/listar-clientes', async (req, res) => {
    try {
        const resultado = await objBoleta.listarClientesActivos(
            req.body.id_entidadS,
        );
        return res.json({
            data: resultado,
            ok: true,
        });
    } catch (error) {
        return res
            .status(500)
            .json({ ok: false, msg: 'Error al cargar lista de clientes' });
    }
});

rutas.post("/crear-masivo", guardar, async (req, res) => {
    try {
        // El front debe enviar datosAuditoriaExtra: { usuarioId: 1, srol: 2 }
        const { items, datosAuditoriaExtra, fecha, idTramite,idCliente, usuario, srol, fecha_ } = req.body;
        // console.log(datosAuditoriaExtra)

        if (!datosAuditoriaExtra || !srol) {
            return res.status(400).json({ ok: false, msg: "Faltan datos de rol del usuario" });
        }

        const resultado = await objBoleta.crearBoletaMasiva(items, { fecha, idTramite,idCliente, usuario, srol, fecha_ });

        if (resultado.ok) {
            registrarAuditoria(req, {
                usuario_id: usuario,
                accion: "CREACION DE BOLETA - " + resultado.codigo_boleta,
                tabla: "salidas",
                detalle: { items },
                datosAuditoriaExtra,
                fecha: fecha_
            });
            return res.json({ msg: resultado.msg + ' - BOLETA: ' + resultado.codigo_boleta, ok: true });
        } else return res.json({ msg: 'error en la transaccion', ok: false });

    } catch (error) {
        console.error(error);
        return res.status(500).json({ ok: false, msg: "Error en el servidor" });
    }
});

rutas.post("/actualizar-masivo/", guardar, async (req, res) => {
    try {
        const { codigo_boleta, items, fecha, idTramite,idCliente, usuario, srol, fecha_, datosAuditoriaExtra } = req.body;
        if (!items || items.length === 0) {
            return res.status(400).json({ ok: false, msg: "La lista de ítems está vacía" });
        }

        const resultado = await objBoleta.actualizarBoletaMasiva(codigo_boleta, items, {fecha, idTramite,idCliente, usuario, srol, fecha_ });
        if (resultado.ok) {
            registrarAuditoria(req, {
                usuario_id: usuario,
                accion: "MODIFICACION DE BOLETA - " + codigo_boleta,
                tabla: "salidas",
                detalle: { items },
                datosAuditoriaExtra,
                fecha: fecha_
            });
            return res.json({ ok: true, msg: resultado.msg });
        } else return res.json({ msg: 'error en la transaccion', ok: false });

    } catch (error) {
        console.error(error);
        return res.status(500).json({ ok: false, msg: "Error al actualizar la boleta" });
    }
});

const gestionarEstado = (accion) => async (req, res) => {
    try {
        // console.log(req.body)
        const { codigo, datosAuditoriaExtra, usuario, fecha_, srol } = req.body;
        const resultado = await objBoleta.cambiarEstado(codigo, accion, datosAuditoriaExtra, usuario, fecha_, srol);
        if (resultado) {
            registrarAuditoria(req, {
                usuario_id: usuario,
                accion: accion + " - " + codigo,
                tabla: "salidas",
                detalle: { codigo, },
                datosAuditoriaExtra,
                fecha: fecha_
            });
            return res.json({ ok: true, msg: 'Transaccion realizada correctamente' });
        } else return res.json({ msg: 'caja actualmente esta fuera de operación', ok: false });
    } catch (error) {
        console.log(error)
        return res.status(500).json({ ok: false, msg: `Error al ${accion}` });
    }
};

rutas.post("/aprobar", gestionarEstado('aprobar'));
rutas.post("/aprobar-despachar", gestionarEstado('aprobardespachar'));
rutas.post("/rechazar", gestionarEstado('rechazar'));
rutas.post("/despachar", gestionarEstado('despachar'));
rutas.post("/eliminar", gestionarEstado('eliminar'));
rutas.post("/edicion", gestionarEstado('edicion'));

export default rutas;