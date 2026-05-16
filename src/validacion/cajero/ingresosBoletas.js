import { validaciones } from '../headers.js';
import { check } from 'express-validator';



export const guardar = [

  // Fecha en que se percibe el ingreso
  check('fecha')
    .exists()
    .withMessage('La fecha de ingreso es obligatoria')
    .isISO8601()
    .withMessage('Fecha de ingreso inválida (formato ISO 8601)'),

  // ID del Usuario que registra
  check('idTramite')
    .exists()
    .withMessage('El Tramite es obligatorio')
    .isUUID()
    .withMessage('El ID de Tramite debe ser un número'),

  check('idCliente')
    .optional({ nullable: true })
    .exists()
    .withMessage('El cliente es obligatorio')
    .isInt()
    .withMessage('El ID de cliente debe ser un número'),


  (req, res, next) => {
    validaciones(req, res, next);
  },
];
