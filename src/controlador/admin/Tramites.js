import { Router } from "express";
import { registrarAuditoria } from '../../modelo/auditoria.js';
import { Tramite } from "../../modelo/admin/Tramite.js";
import { insertar, actualizar } from "../../validacion/admin/tramites.js"; // Importamos las validaciones 

const rutas = Router();
const objetoTramite = new Tramite();



// ENDPOINT: Obtener tipos de trámites para el combobox
rutas.post("/listar-tipo-tramites", async (req, res) => {
  try {
    const resultado = await objetoTramite.listarTiposActivos();
    return res.json({
      data: resultado,
      ok: true
    });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al cargar lista de tipos" });
  }
});
  

// ENDPOINT: Obtener tipos de trámites para el combobox
rutas.post("/obtener", async (req, res) => {
  try {
    const resultado = await objetoTramite.ObtenerTramite(req.body.id);
    return res.json({
      data: resultado,
      ok: true
    });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al cargar lista de tipos" });
  }
});


// 1. LISTAR TRÁMITES (Con Joins a Clientes y Tipos)
rutas.post("/listar", async (req, res) => {
  try {
    const resultado = await objetoTramite.listar();
    return res.json({
      data: resultado,
      ok: true
    });
  } catch (error) {
    console.error("Error en ruta listar trámites:", error);
    return res.status(500).json({
      ok: false,
      msg: "Error al obtener la lista de trámites"
    });
  }
});

// 2. CREAR TRÁMITE
rutas.post("/crear", insertar, async (req, res) => {
  try {
    const {
       fecha_ingreso, fecha_finalizacion,
      id_tipo_tramite, detalle, costo, otros, usuario, fecha_, id_entidadS
    } = req.body;

    const datos = {
      fecha_ingreso,
      fecha_finalizacion,
      id_tipo_tramite,
      detalle,
      costo,
      otros: otros || '',
      estado: 1, // 1: En curso
      usuario,
      id_entidadS,
      created_at: fecha_ // Fecha enviada desde el frontend
    };

    const resultado = await objetoTramite.insertar(datos);

    if (resultado.existe === 1) {
      return res.json({ ok: false, msg: "El código de caja ya se encuentra registrado" });
    }

    return res.json({
      data: resultado,
      ok: true,
      msg: "Caja aperturado correctamente",
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      ok: false,  
      msg: error.sqlMessage || "Error interno al crear trámite"
    });
  }
});

// 3. EDITAR TRÁMITE
rutas.post("/editar", actualizar, async (req, res) => {
  try {
    const {
      id,   fecha_ingreso, fecha_finalizacion,
      id_tipo_tramite, detalle, costo, otros, estado, usuario, fecha_, datosAuditoriaExtra, id_entidadS
    } = req.body;


    const datos = {
      id,   fecha_ingreso, fecha_finalizacion,
      id_tipo_tramite, detalle, costo, otros, estado,
      usuario,id_entidadS,
      modified_at: fecha_
    };



    const resultado = await objetoTramite.actualizar(datos);

    if (resultado.error === 1)
      return res.json({ ok: false, msg: "No se encontraron cambios o la caja no existe" });

    // --- GUARDAR EN AUDITORÍA ---
    // Aquí usamos la info que capturamos arriba
    registrarAuditoria(req, {
      usuario_id: req.body.usuario, // El ID que viene del frontend
      accion: 'UPDATE',
      tabla: 'tramites',
      detalle: datos, // Datos que se enviaron
      datosAuditoriaExtra, fecha: fecha_
    });

    return res.json({
      data: resultado,
      ok: true,
      msg: "Información del caja actualizada",
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ ok: false, msg: error.sqlMessage });
  }
});



// 5. ELIMINAR TRÁMITE (Físico)
rutas.post("/eliminar-logica", async (req, res) => {
  try {
    const { id, estado, usuario, fecha_, datosAuditoriaExtra } = req.body;

    const datos = { id, estado: estado == 1 ? 1 : 0, usuario, fecha_ };
    const resultado = await objetoTramite.eliminar(datos);

    if (resultado) {
      const msg = (estado == 1) ? "caja activado" : "caja eliminado";

      // --- GUARDAR EN AUDITORÍA ---
      // Aquí usamos la info que capturamos arriba
      registrarAuditoria(req, {
        usuario_id: req.body.usuario, // El ID que viene del frontend
        accion: (estado == 1) ? "Caja activado" : "Caja eliminado",
        tabla: 'tramites',
        detalle: datos, // Datos que se enviaron
        datosAuditoriaExtra, fecha: fecha_
      });
      return res.json({ ok: true, msg });
    } else {
      return res.json({ ok: false, msg: "No se pudo cambiar el estado de caja" });
    }
  } catch (error) {
    return res.json({ error: 500, msg: error.sqlMessage });
  }
});

export default rutas;