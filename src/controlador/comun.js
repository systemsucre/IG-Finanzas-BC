import { Router } from "express";
import { Reportes } from "../modelo/reportes.js";

const rutas = Router();

const reportes = new Reportes();

/**
 * 2. LISTAR TRÁMITES (Para el combobox/selección)
 */
rutas.post("/listar-tramites", async (req, res) => {
  // console.log('usuaio erlinda')
  try {
    const resultado = await reportes.tramites(req.body.id_entidadS, req.body.id);  
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

/**
 * 2. LISTAR TRÁMITES (Para el combobox/selección)
 */
rutas.post("/obtener-tramite", async (req, res) => {
  try {
    const resultado = await reportes.ObtenerTramite(req.body.id);
    // console.log(resultado, req.body.id)
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

rutas.post("/ingresos", async (req, res) => {
  try {
    const resultado = await reportes.getDataToPDFINgresos(req.body.id);
    // console.log(resultado, req.body.id)
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

rutas.post("/salidas", async (req, res) => {
  try {
    const resultado = await reportes.getDatatoPdfSalidas(req.body.id);
    // console.log(resultado, req.body.id)
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});



rutas.post("/ingresos-excel", async (req, res) => {
  try {
    const { id, desde, hasta, usuario } = req.body
    if (usuario === 4) return res.json({ msg: 'Error', ok: false });
    const resultado = await reportes.getIngresosExcel(id, desde, hasta);
    // console.log(resultado, req.body.id)
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

rutas.post("/salidas-excel", async (req, res) => {
  try {
    const { id, desde, hasta } = req.body

    const resultado = await reportes.getSalidasExcel(id, desde, hasta);
    // console.log(resultado, req.body.id)
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

/**
 * 2. LISTAR TRÁMITES (Para el combobox/selección)
 */
rutas.post("/reporte-consolidado", async (req, res) => {
  // console.log('usuaio erlinda')
  try {
    const { desde, hasta, estado } = req.body

    const resultado = await reportes.reportaConsolidado(desde, hasta, estado);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

export default rutas;