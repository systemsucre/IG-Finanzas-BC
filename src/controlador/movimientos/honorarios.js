import { Router } from "express";
import { registrarAuditoria } from '../../modelo/auditoria.js';
import { Honorarios } from "../../modelo/movimientos/honorarios.js";
import { insertar, actualizar } from "../../validacion/cajero/honoracion.js";

const rutas = Router();
const objetoHonorario = new Honorarios();

/**
 * 1. LISTAR HONORARIOS POR TRÁMITE
 */
rutas.post("/listar-honorarios", async (req, res) => {
  try {
    const resultado = await objetoHonorario.listarHonorarios();
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ ok: false, msg: "Error al listar honorarios" });
  }
});

// reportes
rutas.post("/listar-honorarios-reportes", async (req, res) => {
  try {
    const {desde, hasta}=req.body
    const resultado = await objetoHonorario.listarHonorariosReporte({desde, hasta});
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ ok: false, msg: "Error al listar honorarios" });
  }
});

/**
 * 2. OBTENER UN HONORARIO ESPECÍFICO
 */
rutas.post("/obtener", async (req, res) => {
  try {
    const { id } = req.body;
    const resultado = await objetoHonorario.obtener(id);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al obtener el registro" });
  }
});

/**
 * 3. CREAR HONORARIO
 */
rutas.post("/crear", insertar, async (req, res) => {
  try {
    // Extraemos 'usuario' y 'fecha_' que vienen del MIDDLEWARE de verificación
    const { 
      id_tramite, monto, tipo_pago, descripcion, fecha_ingreso, 
      usuario, fecha_, srol, datosAuditoriaExtra 
    } = req.body;

    // Bloqueo para rol Auxiliar (si srol 4 es auxiliar)
    if (parseInt(srol) === 4) {
      return res.status(403).json({ ok: false, msg: "No tiene permisos para realizar esta acción" });
    }

    const resultado = await objetoHonorario.crear({
      id_tramite, monto, tipo_pago, descripcion, fecha_ingreso, 
      usuario, // Este es el ID del usuario logueado
      created_at: fecha_ // Fecha del servidor
    });

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: "CREAR HONORARIO",
        tabla: "honorarios",
        detalle: { id_tramite, monto, tipo_pago, descripcion },
        datosAuditoriaExtra,
        fecha: fecha_
      });
      return res.json({ ok: true, msg: "Honorario registrado correctamente" });
    }

    return res.json({ ok: false, msg: "No se pudo registrar el honorario" });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

/**
 * 4. ACTUALIZAR HONORARIO
 */
rutas.post("/actualizar", actualizar, async (req, res) => {
  try {
    const { 
      id, monto, tipo_pago, descripcion, fecha_ingreso, 
      usuario, fecha_, srol, datosAuditoriaExtra 
    } = req.body;

    if (parseInt(srol) === 4) return res.status(403).json({ ok: false });

    const resultado = await objetoHonorario.actualizar(id, {
      monto, tipo_pago, descripcion, fecha_ingreso, 
      usuario,
      updated_at: fecha_
    });

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: "ACTUALIZAR HONORARIO",
        tabla: "honorarios",
        detalle: { id, monto, tipo_pago, descripcion },
        datosAuditoriaExtra,
        fecha: fecha_
      });
      return res.json({ ok: true, msg: "Honorario actualizado correctamente" });
    }

    return res.json({ ok: false, msg: "No se pudo actualizar el honorario" });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

/**
 * 5. ELIMINAR HONORARIO (BORRADO LÓGICO)
 */
rutas.post("/eliminar", async (req, res) => {
  try {
    const { id, data, usuario, fecha_, srol, datosAuditoriaExtra } = req.body;
    
    if (parseInt(srol) === 4) return res.status(403).json({ ok: false });

    const resultado = await objetoHonorario.eliminar(id);

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: "ELIMINAR HONORARIO",
        tabla: "honorarios",
        detalle: data,
        datosAuditoriaExtra,
        fecha: fecha_ 
      });
      return res.json({ ok: true, msg: "Honorario eliminado correctamente" });
    }

    return res.json({ ok: false, msg: "No se pudo eliminar el registro" });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

export default rutas;