import { Router } from "express";
import { registrarAuditoria } from '../../modelo/auditoria.js';
import { Ingresos } from "../../modelo/cajero/ingresos.js"; // Asegúrate de la ruta correcta
import { insertar, actualizar } from "../../validacion/cajero/ingresos.js";

const rutas = Router();
const objetoIngreso = new Ingresos();


/**
 * 1. LISTAR INGRESOS POR TRÁMITE
 */
rutas.post("/listar-por-tramites", async (req, res) => {
  try {
    // console.log(req.body.id_tramite)
    const { id_tramite } = req.body;
    const resultado = await objetoIngreso.listarPorTramite(id_tramite);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ ok: false, msg: "Error al listar ingresos del trámite" });
  }
});

// ENDPOINT: Obtener clientes para el combobox
rutas.post("/listar-clientes", async (req, res) => {
  try {
    const resultado = await objetoIngreso.listarClientesActivos();
    return res.json({
      data: resultado,
      ok: true
    });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al cargar lista de clientes" });
  }
});



/**
 * 2. LISTAR INGRESOS POR TRÁMITE
 */
rutas.post("/obtener", async (req, res) => {
  try {
    const { id } = req.body;
    const resultado = await objetoIngreso.obtener(id);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ ok: false, msg: "Error al listar ingresos del trámite" });
  }
});


/**
 * 4. CREAR INGRESO
 */
rutas.post("/crear", insertar, async (req, res) => {
  try {
    const { id_tramite, id_cliente, srol, monto, tipo, fecha_ingreso, detalle, usuario, created_at, datosAuditoriaExtra } = req.body;

    if (srol !== 3) return
    const resultado = await objetoIngreso.crear({
      id_tramite, monto, id_cliente, tipo, fecha_ingreso, detalle, usuario, created_at,
    });

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: "CREAR INGRESO",
        tabla: "ingresos",
        detalle: { id_tramite, monto, tipo, detalle },
        datosAuditoriaExtra,
        fecha: created_at
      });
      return res.json({ ok: true, msg: "Ingreso registrado correctamente" });
    }

    return res.json({ ok: false, msg: "No se pudo registrar el ingreso" });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

/**
 * 5. ACTUALIZAR INGRESO
 */
rutas.post("/actualizar", actualizar, async (req, res) => {
  try {
    const { id, monto, id_cliente, srol, tipo, fecha_ingreso, detalle, updated_at, usuario, datosAuditoriaExtra } = req.body;
    if (srol !== 3) return

    // console.log(id, ' id ingreso controlador')
    const resultado = await objetoIngreso.actualizar(id, {
      monto, tipo, id_cliente, fecha_ingreso, detalle, updated_at, usuario,
    });

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: "ACTUALIZAR INGRESO",
        tabla: "ingresos",
        detalle: { id, monto, tipo, fecha_ingreso, detalle, updated_at, usuario, },
        datosAuditoriaExtra,
        fecha: updated_at
      });
      return res.json({ ok: true, msg: "Ingreso actualizado correctamente" });
    }

    return res.json({ ok: false, msg: "No se pudo actualizar el ingreso" });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

/**
 * 6. ELIMINAR INGRESO
 */
rutas.post("/eliminar", async (req, res) => {
  try {
    const { id, usuario, srol, monto, tipo, detalle, fecha, fecha_, datosAuditoriaExtra } = req.body;
    if (srol !== 3) return

    const resultado = await objetoIngreso.eliminar(id);

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: "ELIMINAR INGRESO",
        tabla: "ingresos",
        detalle: { id, monto, tipo, detalle, fecha, },
        datosAuditoriaExtra,
        fecha: fecha_
      });
      return res.json({ ok: true, msg: "Ingreso eliminado correctamente" });
    }

    return res.json({ ok: false, msg: "No se pudo eliminar el ingreso" });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

export default rutas;