import { validaciones } from "../headers.js";
import { check } from "express-validator";

export const insertar = [
  // Relación con el Trámite (Obligatorio y UUID)
  check("id_tramite")
    .exists().withMessage("El ID del trámite es requerido")
    .isUUID().withMessage("ID de trámite no válido"),

  // Monto del Honorario
  check("monto")
    .exists().withMessage("El monto es obligatorio")
    .isFloat({ min: 0.10 }).withMessage("El monto debe ser un número positivo")
    .toFloat(),

  // Tipo de Pago (Efectivo, Transferencia, etc.)
  check("tipo_pago")
    .exists().withMessage("El tipo de pago es obligatorio")
    .isIn(['Efectivo', 'Transferencia', 'Depósito', 'Cheque'])
    .withMessage("Tipo de pago no permitido"),

  // Descripción o concepto
  check("descripcion")
    .optional()
    .trim()
    .isLength({ min: 5 }).withMessage("La descripción debe tener al menos 5 caracteres"),

  // Fecha en que se recibe el dinero (YYYY-MM-DD)
  check("fecha_ingreso")
    .exists().withMessage("La fecha de ingreso es obligatoria")
    .isISO8601().withMessage("Formato de fecha inválido"),

  /* NOTA: 'usuario' y 'created_at' NO se validan aquí 
     porque el servidor los inyecta mediante el middleware.
  */

  (req, res, next) => {
    validaciones(req, res, next);
  },
];

export const actualizar = [
  // ID del registro de honorario (Obligatorio)
  check("id")
    .exists().withMessage("El ID del registro es requerido")
    .isUUID().withMessage("ID no válido"),

  check("monto")
    .optional()
    .isFloat({ min: 0.10 }).withMessage("El monto debe ser un número positivo")
    .toFloat(),

  check("tipo_pago")
    .optional()
    .isIn(['Efectivo', 'Transferencia', 'Depósito', 'Cheque'])
    .withMessage("Tipo de pago no permitido"),

  check("descripcion")
    .optional()
    .trim()
    .isLength({ min: 5 }).withMessage("La descripción debe tener mínimo 5 caracteres"),

  check("fecha_ingreso")
    .optional()
    .isISO8601().withMessage("Fecha de ingreso inválida"),

  (req, res, next) => {
    validaciones(req, res, next);
  },
];