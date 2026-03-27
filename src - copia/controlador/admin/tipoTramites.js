import { Router } from "express";
import { TipoTramite } from "../../modelo/admin/tipoTramite.js";
import { check } from "express-validator";
import { validaciones } from "../../validacion/headers.js"; // middleware de validación

const rutas = Router();
const tramites = new TipoTramite();

// --- VALIDACIONES INTERNAS  ---
const validarTramite = [
  check("tipo_tramite")
    .notEmpty().withMessage("El nombre del trámite es obligatorio")
    .isLength({ min: 3 }).withMessage("El nombre es muy corto"),
  check("codigo")
    .notEmpty().withMessage("El nombre del trámite es obligatorio")
    .isLength({ min: 3, max: 5 }).withMessage("El nombre es muy corto 0 muy extendido"),
  (req, res, next) => { validaciones(req, res, next); }
];

// 1. LISTAR TRÁMITES
rutas.post("/listar", async (req, res) => {
  try {
    const resultado = await tramites.listar(req.body.id_entidadS);
    return res.json({
      data: resultado,
      ok: true
    });
  } catch (error) {
    console.error("Error en ruta listar trámites:", error);
    return res.status(500).json({ ok: false, msg: "Error al obtener trámites" });
  }
});

// 2. CREAR TRAMITE
rutas.post("/crear", validarTramite, async (req, res) => {
  try {
    const { tipo_tramite, usuario, fecha_, codigo, id_entidadS } = req.body;

    const datos = {
      tipo_tramite, codigo,
      usuario,
      created_at: fecha_,id_entidad:id_entidadS,
      estado: 1 // Activo por defecto
    };

    const resultado = await tramites.insertar(datos);

    if (resultado.existe === 1) {
      return res.json({ ok: false, msg: "Esta categoria de caja ya existe" });
    }

    return res.json({
      data: resultado,
      ok: true,
      msg: "Categoria de caja registrado correctamente",
    });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.sqlMessage || "Error en el servidor" });
  }
});

// 3. EDITAR TRAMITE
rutas.post("/editar", validarTramite, async (req, res) => {
  try {
    const { id, tipo_tramite, usuario, fecha_, codigo, id_entidadS} = req.body;

    const datos = {
      id,
      tipo_tramite, codigo,
      usuario,
      id_entidadS,
      updated_at: fecha_
    };

    const resultado = await tramites.actualizar(datos);

    if (resultado.existe === 1)
      return res.json({ ok: false, msg: "Ya existe otra categoria de caja con ese nombre" });

    if (resultado.error === 1)
      return res.json({ ok: false, msg: "No se pudo actualizar el tipo de caja" });

    return res.json({
      data: resultado,
      ok: true,
      msg: "Categoria de caja actualizado correctamente",
    });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.sqlMessage });
  }
});

// 4. CAMBIAR ESTADO (ELIMINACIÓN LÓGICA)
rutas.post("/cambiar-estado", async (req, res) => {
  try {
    const { id, estado, usuario, fecha_ } = req.body;

    const datos = {
      id,
      estado: (estado == 1) ? 1 : 0,
      usuario,
      updated_at: fecha_
    };

    const resultado = await tramites.eliminarLogico(datos);

    if (resultado) {
      const msg = (estado == 1) ? "Categoria de caja activado" : "Categoria de caja desactivado";
      return res.json({ ok: true, msg });
    } else {
      return res.json({ ok: false, msg: "No se pudo cambiar el estado" });
    }
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.sqlMessage });
  }
});

export default rutas;