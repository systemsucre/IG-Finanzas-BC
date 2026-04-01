import { Router } from "express";
import { Cliente } from "../../modelo/admin/clientes.js"; // Importamos el nuevo modelo
import {
  insertar,
  actualizar,
} from "../../validacion/admin/cliente.js"; // Asegúrate de que estas validaciones existan
import { registrarAuditoria } from "../../modelo/auditoria.js";

const rutas = Router();
const clientes = new Cliente();

// 1. LISTAR CLIENTES
rutas.post("/listar", async (req, res) => {

  try {
    const resultado = await clientes.listar(req.body.id_entidadS);

    return res.json({
      data: resultado,
      ok: true
    });

  } catch (error) {
    console.error("Error en ruta listar clientes:", error);
    return res.status(500).json({
      msg: "Error al obtener la lista de clientes",
      ok: false,
      error: error.message
    });
  }
});

// 2. CREAR CLIENTE
rutas.post("/crear", insertar, async (req, res) => {
  try {
    const {
      nombre, ap1, ap2, ci, celular, direccion, usuario, fecha_, id_entidadS
    } = req.body;

    // Mapeamos a la estructura de la tabla 'clientes'
    const datos = {
      nombre,
      ap1,
      ap2,
      ci,
      celular,
      direccion,
      usuario, // ID del usuario que registra
      created_at: fecha_, // Fecha de creación
      estado: 1, // Activo por defecto,
      id_entidad: id_entidadS
    };

    const resultado = await clientes.insertar(datos);

    if (resultado.error === 3) {
      return res.json({ ok: false, msg: "Este C.I. ya se encuentra registrado" });
    }

    return res.json({
      data: resultado,
      ok: true,
      msg: "Cliente registrado correctamente",
    });

  } catch (error) {
    console.log(error);
    return res.status(500).json({ ok: false, msg: error.sqlMessage || "Error en el servidor" });
  }
});

// 3. EDITAR CLIENTE
rutas.post("/editar", actualizar, async (req, res) => {
  try {
    const {
      id, nombre, ap1, ap2, ci, celular, direccion, estado, usuario, fecha_, id_entidadS, datosAuditoriaExtra
    } = req.body;

    const datos = {
      id, nombre, ap1, ap2, ci, celular, direccion, estado, usuario, fecha_, id_entidad: id_entidadS
    };

    const resultado = await clientes.actualizar(datos);

    if (resultado.existe === 3)
      return res.json({ ok: false, msg: "El C.I. ya está registrado por otro cliente" });

    if (resultado.error === 1)
      return res.json({ ok: false, msg: "No se realizaron cambios o el cliente no existe" });


    // --- GUARDAR EN AUDITORÍA ---
    // Aquí usamos la info que capturamos arriba
    registrarAuditoria(req, {
      usuario_id: usuario, // El ID que viene del frontend
      accion: 'UPDATE',
      tabla: 'CLIENTES',
      detalle: datos, // Datos que se enviaron
      datosAuditoriaExtra, fecha: fecha_
    });
    return res.json({
      data: resultado,
      ok: true,
      msg: "Datos del cliente actualizados correctamente",
    });

  } catch (error) {
    console.log(error);
    return res.json({ error: 500, msg: error.sqlMessage });
  }
});

// 4. CAMBIAR ESTADO (ACTIVAR/DESACTIVAR)
rutas.post("/cambiar-estado", async (req, res) => {
  try {
    const { id, estado, usuario, fecha_, datosAuditoriaExtra } = req.body;

    const datos = { id, estado: estado == 1 ? 1 : 0, usuario, fecha_ };
    const resultado = await clientes.cambiarEstado(datos);

    if (resultado) {
      const msg = (estado == 1) ? "Cliente activado" : "Cliente desactivado";
      // --- GUARDAR EN AUDITORÍA ---
      // Aquí usamos la info que capturamos arriba
      registrarAuditoria(req, {
        usuario_id: usuario, // El ID que viene del frontend
        accion: 'UPDATE estado',
        tabla: 'CLIENTES',
        detalle: datos, // Datos que se enviaron
        datosAuditoriaExtra, fecha: fecha_
      });
      return res.json({ ok: true, msg });
    } else {
      return res.json({ ok: false, msg: "No se pudo cambiar el estado del cliente" });
    }
  } catch (error) {
    return res.json({ error: 500, msg: error.sqlMessage });
  }
});

export default rutas;