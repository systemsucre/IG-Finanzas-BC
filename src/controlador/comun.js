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
    const resultado = await reportes.tramites(req.body.id, req.body.id_entidadS);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});


// ENDPOINT: Obtener tipos de trámites para el combobox
rutas.post("/listar-monedas", async (req, res) => {
  try {
    const resultado = await reportes.listarModendas();
    return res.json({
      data: resultado,
      ok: true
    });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al cargar lista de tipos" });
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
    const resultado = await reportes.getDataToIngresoPDF(req.body.id);
    // console.log(resultado, req.body.id)
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

rutas.post("/salidas", async (req, res) => {
  try {
    const resultado = await reportes.getDatatoSalidaPdf(req.body.id);
    // console.log(resultado, req.body.id)
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});



rutas.post("/ingresos-excel", async (req, res) => {
  try {
    const { id, desde, hasta, moneda, srol } = req.body
    console.log(srol)
    if (srol === 4) return res.json({ msg: 'Error', ok: false });
    const resultado = await reportes.getIngresosExcel(desde, hasta, moneda, id);
    // console.log(resultado, req.body.id)
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

rutas.post("/salidas-excel", async (req, res) => {
  try {
    const { id, desde, hasta, moneda } = req.body

    // console.log(req.body, ' datos ')

    const resultado = await reportes.getSalidasExcel(desde, hasta, moneda, id);
    // console.log(resultado, req.body.id)
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

/**
 * 2. LISTAR TRÁMITES (Para el combobox/selección)
 */
rutas.post("/reporte-consolidado", async (req, res) => {
  // console.log('usuaio erlinda')
  try {
    const { desde, hasta, estado, moneda, id_entidadS } = req.body

    const resultado = await reportes.reportaConsolidado(desde, hasta, estado, id_entidadS, moneda);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

rutas.post("/stats-mensuales", async (req, res) => {
  // console.log('usuaio erlinda', )
  try {
    const { id_entidadS, moneda } = req.body
    const monedaFinal = moneda || 1;
    const resultado = await reportes.getStatsMensuales(id_entidadS, monedaFinal);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    // console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

rutas.post("/listar-cajas", async (req, res) => {
  // console.log('usuaio erlinda')
  try {
    const { id_entidadS } = req.body

    const resultado = await reportes.listarCajas(id_entidadS);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});


rutas.post("/listar-cajas", async (req, res) => {
  // console.log('usuaio erlinda')
  try {

    const resultado = await reportes.listarCajas(req.body.id_entidadS);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

rutas.post("/listar-clientes", async (req, res) => {
  // console.log('usuaio erlinda')
  try {

    const resultado = await reportes.listarClientes(req.body.id_entidadS);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

rutas.post("/listar-usuarios", async (req, res) => {
  // console.log('usuaio erlinda')
  try {

    const resultado = await reportes.listarUsuarios(req.body.id_entidadS);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});
rutas.post("/listar-tipos-tramites", async (req, res) => {
  // console.log('usuaio erlinda')
  try {

    const resultado = await reportes.listarTiposTramites(req.body.id_entidadS);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al listar trámites" });
  }
});

rutas.post("/historico-ia", async (req, res) => {
  // console.log('usuaio erlinda')
  try {
    const historico = await reportes.getHistoricoParaIA(req.body.id_entidadS, req.body.moneda);
    // const resultado = await predecirFuturoFinanciero()
    // console.log(resultado, ' resultado Ia')
    return res.json({ data: historico, ok: true });
  } catch (error) {
    console.log(error)
    return res.status(500).json({ ok: false, msg: "Error al procesar datos" });
  }
});

export default rutas;