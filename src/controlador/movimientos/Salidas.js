import { Router } from "express";
import { Salidas } from "../../modelo/movimientos/Salidas.js";

const rutas = Router();
const objetoSalida = new Salidas();

/**
 * 1. LISTAR SALIDAS POR TRÁMITE
 */
rutas.post("/listar", async (req, res) => {
  try {
    // Asegúrate de enviar id_tramite desde el front
    const resultado = await objetoSalida.listar(req.body.id);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ ok: false, msg: "Error al listar salidas" });
  }
});




export default rutas;