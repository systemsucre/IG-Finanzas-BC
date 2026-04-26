import { Router } from 'express';
import { registrarAuditoria } from '../../modelo/auditoria.js';
import { Ingresos } from '../../modelo/movimientos/ingresos.js'; // Asegúrate de la ruta correcta
import {
  insertar,
  actualizar,
  completar,
} from '../../validacion/cajero/ingresos.js';

const rutas = Router();
const objetoIngreso = new Ingresos();

/**
 * 1. LISTAR INGRESOS POR TRÁMITE
 */
rutas.post('/listar-ingresos-directos', async (req, res) => {
  try {
    // console.log(req.body.id_tramite)
    const resultado = await objetoIngreso.listarIngresosDirectos(
      req.body.id_entidadS,
    );
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ ok: false, msg: 'Error al listar ingresos del trámite' });
  }
  w;
});
rutas.post('/listar-ingresos-pendientes', async (req, res) => {
  try {
    // console.log(req.body.id_tramite)
    const resultado = await objetoIngreso.listarIngresosPendientes(
      req.body.id_entidadS,
    );
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ ok: false, msg: 'Error al listar ingresos del trámite' });
  }
  w;
});

/**
 * 2. LISTAR INGRESOS POR TRÁMITE
 */
rutas.post('/obtener', async (req, res) => {
  try {
    const { id } = req.body;
    const resultado = await objetoIngreso.obtener(id);
    return res.json({ data: resultado, ok: true });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ ok: false, msg: 'Error al listar ingresos del trámite' });
  }
});

// ENDPOINT: Obtener clientes para el combobox
rutas.post('/listar-clientes', async (req, res) => {
  try {
    const resultado = await objetoIngreso.listarClientesActivos(
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

/**
 * 4. CREAR INGRESO
 */
rutas.post('/crear-ingreso-directo', insertar, async (req, res) => {
  try {
    const {
      id_tramite,
      id_cliente,
      srol,
      monto,
      tipo,
      fecha_ingreso,
      detalle,
      usuario,
      fecha_,
      numero_referencia,
      datosAuditoriaExtra,
      tipo_ingreso,
      estado,
    } = req.body;

    // console.log(req.body);

    if (srol !== 3) return;
    const resultado = await objetoIngreso.crearIngresoDirecto({
      id_tramite,
      monto,
      id_cliente,
      tipo,
      fecha_ingreso,
      detalle,
      usuario,
      created_at: fecha_,
      numero_referencia,
      tipo_ingreso,
      estado,
    });

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: 'CREAR INGRESO',
        tabla: 'ingresos',
        detalle: { id_tramite, monto, tipo, detalle },
        datosAuditoriaExtra,
        fecha: fecha_,
      });
      return res.json({ ok: true, msg: 'Ingreso registrado correctamente' });
    }

    return res.json({ ok: false, msg: 'No se pudo registrar el ingreso' });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

rutas.post('/crear-ingreso-pendiente', insertar, async (req, res) => {
  try {
    const {
      id_tramite,
      id_cliente,
      srol,
      monto,
      tipo,
      fecha_ingreso,
      detalle,
      usuario,
      fecha_,
      datosAuditoriaExtra,
    } = req.body;

    // console.log(req.body);

    if (srol !== 3) return;
    const resultado = await objetoIngreso.crearIngresoPendiente({
      id_tramite,
      monto,
      id_cliente,
      tipo,
      fecha_ingreso,
      detalle,
      usuario,
      created_at: fecha_,
    });

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: 'CREAR INGRESO PENDIENTE',
        tabla: 'ingresos',
        detalle: { id_tramite, monto, tipo, detalle },
        datosAuditoriaExtra,
        fecha: fecha_,
      });
      return res.json({ ok: true, msg: 'Ingreso registrado correctamente' });
    }

    return res.json({ ok: false, msg: 'No se pudo registrar el ingreso' });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

rutas.post('/completar-ingreso', completar, async (req, res) => {
  try {
    const {
      id,
      idTramite,
      srol,
      monto,
      tipo,
      fecha_ingreso,
      usuario,
      fecha_,
      datosAuditoriaExtra,
      numero_referencia,
    } = req.body;

    // console.log(req.body, ' datos revertir');

    if (srol !== 3) return;
    const resultado = await objetoIngreso.completarIngreso({
      id,
      idTramite,
      monto,
      tipo,
      fecha_ingreso,
      usuario,
      updated_at: fecha_,
      numero_referencia,
    });

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: 'COMPLETAR PAGO PENDIENTE',
        tabla: 'ingresos',
        detalle: { idTramite, monto, tipo },
        datosAuditoriaExtra,
        fecha: fecha_,
      });
      return res.json({ ok: true, msg: 'Ingreso registrado correctamente' });
    }

    return res.json({
      ok: false,
      msg: 'No se pudo registrar el ingreso. El trámite no esta en curso',
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

rutas.post('/revertir-ingreso', async (req, res) => {
  try {
    const {
      id,
      idTramite,
      srol,
      usuario,
      fecha_,
      datosAuditoriaExtra,
      revertir,
    } = req.body;

    console.log(req.body, ' datos revertir');

    if (srol !== 3) return;
    const resultado = await objetoIngreso.completarIngreso({
      id,
      idTramite,
      usuario,
      updated_at: fecha_,
      revertir,
    });

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: 'REVERTIR CAMBIO',
        tabla: 'ingresos',
        detalle: { idTramite },
        datosAuditoriaExtra,
        fecha: fecha_,
      });
      return res.json({ ok: true, msg: 'Ingreso registrado correctamente' });
    }

    return res.json({
      ok: false,
      msg: 'No se pudo registrar el ingreso. El trámite no esta en curso',
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

/**
 * 5. ACTUALIZAR INGRESO
 */
rutas.post('/actualizar-ingreso-directo', actualizar, async (req, res) => {
  try {
    const {
      id,
      monto,
      id_cliente,
      id_tramite,
      srol,
      tipo,
      fecha_ingreso,
      detalle,
      updated_at,
      usuario,
      numero_referencia,
      datosAuditoriaExtra,
    } = req.body;
    if (srol !== 3) return;

    // console.log(id, ' id ingreso controlador')
    const resultado = await objetoIngreso.actualizar(id, {
      monto,
      tipo,
      id_tramite,
      id_cliente,
      fecha_ingreso,
      detalle,
      updated_at,
      numero_referencia,
      usuario,
    });

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: 'ACTUALIZAR INGRESO',
        tabla: 'ingresos',
        detalle: {
          id,
          monto,
          tipo,
          fecha_ingreso,
          detalle,
          updated_at,
          usuario,
        },
        datosAuditoriaExtra,
        fecha: updated_at,
      });
      return res.json({ ok: true, msg: 'Ingreso actualizado correctamente' });
    }

    return res.json({ ok: false, msg: 'No se pudo actualizar el ingreso' });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

rutas.post('/actualizar-ingreso-pendiente', actualizar, async (req, res) => {
  try {
    const {
      id,
      monto,
      id_tramite,
      id_cliente,
      srol,
      fecha_ingreso,
      detalle,
      updated_at,
      usuario,
      datosAuditoriaExtra,
    } = req.body;
    if (srol !== 3) return;

    // console.log(id, ' id ingreso controlador')
    const resultado = await objetoIngreso.actualizarIngresoPendiente(id, {
      monto,
      id_cliente,
      id_tramite,
      fecha_ingreso,
      detalle,
      updated_at,
      usuario,
    });

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: 'ACTUALIZAR INGRESO PENDIENTE',
        tabla: 'ingresos',
        detalle: {
          id,
          monto,
          fecha_ingreso,
          detalle,
          updated_at,
          usuario,
        },
        datosAuditoriaExtra,
        fecha: updated_at,
      });
      return res.json({
        ok: true,
        msg: 'Ingreso pendiente actualizado correctamente',
      });
    }

    return res.json({
      ok: false,
      msg: 'No se pudo actualizar el ingreso, tramite no disponible',
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ ok: false, msg: error.message });
  }
});
/**
 * 6. ELIMINAR INGRESO
 */
rutas.post('/eliminar-ingreso-directo', async (req, res) => {
  try {
    const {
      id,
      usuario,
      id_tramite,
      srol,
      monto,
      tipo,
      detalle,
      fecha,
      fecha_,
      datosAuditoriaExtra,
    } = req.body;
    if (srol === 4) return;
    const resultado = await objetoIngreso.eliminar(id, id_tramite);

    if (resultado) {
      registrarAuditoria(req, {
        usuario_id: usuario,
        accion: 'ELIMINAR INGRESO',
        tabla: 'ingresos',
        detalle: { id, monto, tipo, detalle, fecha },
        datosAuditoriaExtra,
        fecha: fecha_,
      });
      return res.json({ ok: true, msg: 'Ingreso eliminado correctamente' });
    }

    return res.json({
      ok: false,
      msg: 'No se pudo eliminar el ingreso, El Tramite no esta en curso',
    });
  } catch (error) {
    return res.status(500).json({ ok: false, msg: error.message });
  }
});

export default rutas;
