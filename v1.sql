-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-aguilar.alwaysdata.net
-- Generation Time: Mar 02, 2026 at 01:16 AM
-- Server version: 10.11.15-MariaDB
-- PHP Version: 8.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aguilar_ig-finanzas`
--

-- --------------------------------------------------------

--
-- Table structure for table `auditorias`
--

CREATE TABLE `auditorias` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tabla` varchar(100) NOT NULL,
  `accion` varchar(50) NOT NULL,
  `detalle` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`detalle`)),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `fecha` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auditorias`
--

INSERT INTO `auditorias` (`id`, `usuario_id`, `tabla`, `accion`, `detalle`, `metadata`, `fecha`) VALUES
(1, 1, 'tramites', 'UPDATE', '{\"id\":\"2\",\"id_cliente\":1,\"codigo\":\"ADM-00000003\",\"fecha_ingreso\":\"2026-02-14\",\"fecha_finalizacion\":\"2026-02-28\",\"id_tipo_tramite\":2,\"detalle\":\"LALALA\",\"costo\":3000,\"otros\":\"\",\"estado\":1,\"usuario\":1,\"modified_at\":\"2026-02-15 09:15:44\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\"}', '2026-02-15 13:15:47'),
(2, 1, 'tramites', 'UPDATE', '{\"id\":\"2\",\"id_cliente\":1,\"codigo\":\"ADM-00000003\",\"fecha_ingreso\":\"2026-02-14\",\"fecha_finalizacion\":\"2026-02-28\",\"id_tipo_tramite\":2,\"detalle\":\"LALALA\",\"costo\":3000,\"otros\":\"\",\"estado\":1,\"usuario\":1,\"modified_at\":\"2026-02-15 09:32:50\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"N/A\"}', '2026-02-15 13:32:52'),
(3, 1, 'tramites', 'UPDATE', '{\"id\":\"2\",\"id_cliente\":1,\"codigo\":\"ADM-00000003\",\"fecha_ingreso\":\"2026-02-14\",\"fecha_finalizacion\":\"2026-02-28\",\"id_tipo_tramite\":2,\"detalle\":\"LALALA\",\"costo\":3000,\"otros\":\"\",\"estado\":1,\"usuario\":1,\"modified_at\":\"2026-02-15 09:45:15\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":12,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 13:45:34'),
(4, 1, 'tramites', 'UPDATE', '{\"id\":\"2\",\"id_cliente\":1,\"codigo\":\"ADM-00000003\",\"fecha_ingreso\":\"2026-02-14\",\"fecha_finalizacion\":\"2026-02-28\",\"id_tipo_tramite\":2,\"detalle\":\"LALALA\",\"costo\":3000,\"otros\":\"\",\"estado\":1,\"usuario\":1,\"modified_at\":\"2026-02-15 09:48:10\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":14,\"vistas_previas_detalle\":{},\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 13:48:13'),
(5, 1, 'tramites', 'Trámite marcado: En Curso', '{\"id\":2,\"estado\":1,\"usuario\":1,\"modified_at\":\"2026-02-15 10:05:10\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/cambiar-estado\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":15,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 14:05:21'),
(6, 1, 'tramites', 'Trámite marcado: Paralizado', '{\"id\":2,\"estado\":0,\"usuario\":1,\"modified_at\":\"2026-02-15 10:23:08\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/cambiar-estado\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":16,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 14:23:11'),
(7, 1, 'tramites', 'Trámite marcado: En Curso', '{\"id\":2,\"estado\":1,\"usuario\":1,\"modified_at\":\"2026-02-15 10:23:21\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/cambiar-estado\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":16,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 14:23:23'),
(8, 1, 'tramites', 'Tramite eliminado', '{\"id\":2,\"estado\":0,\"usuario\":1,\"fecha_\":\"2026-02-15 10:23:25\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":16,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 14:23:27'),
(9, 1, 'tramites', 'Tramite activado', '{\"id\":2,\"estado\":1,\"usuario\":1,\"fecha_\":\"2026-02-15 10:23:33\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":16,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 14:23:36'),
(10, 1, 'tramites', 'Trámite marcado: Paralizado', '{\"id\":2,\"estado\":0,\"usuario\":1,\"modified_at\":\"2026-02-15 10:27:28\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/cambiar-estado\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":17,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 14:27:31'),
(11, 1, 'tramites', 'Tramite eliminado', '{\"id\":2,\"estado\":0,\"usuario\":1,\"fecha_\":\"2026-02-15 11:04:09\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":23,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 15:04:16'),
(12, 1, 'tramites', 'Tramite activado', '{\"id\":2,\"estado\":1,\"usuario\":1,\"fecha_\":\"2026-02-15 11:07:12\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":23,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 15:07:19'),
(13, 1, 'tramites', 'Tramite eliminado', '{\"id\":2,\"estado\":0,\"usuario\":1,\"fecha_\":\"2026-02-15 11:07:44\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":23,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 15:07:50'),
(14, 1, 'tramites', 'Tramite activado', '{\"id\":2,\"estado\":1,\"usuario\":1,\"fecha_\":\"2026-02-15 11:29:27\"}', '{\"navegador\":\"Chrome\",\"version\":\"144.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":23,\"user_timezone\":\"America/La_Paz\"}', '2026-02-15 15:29:32'),
(15, 1, 'tramites', 'Trámite marcado: Paralizado', '{\"id\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"estado\":0,\"usuario\":1,\"modified_at\":\"2026-02-18 11:14:55\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/cambiar-estado\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":37,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 10:14:55'),
(16, 1, 'tramites', 'Tramite eliminado', '{\"id\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"estado\":0,\"usuario\":1,\"fecha_\":\"2026-02-18 11:15:00\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":37,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 10:15:00'),
(17, 1, 'tramites', 'Tramite activado', '{\"id\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"estado\":1,\"usuario\":1,\"fecha_\":\"2026-02-18 11:15:09\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":37,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 10:15:09'),
(18, 1, 'tramites', 'Trámite marcado: En Curso', '{\"id\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"estado\":1,\"usuario\":1,\"modified_at\":\"2026-02-18 11:15:14\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/cambiar-estado\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":37,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 10:15:14'),
(19, 1, 'tramites', 'UPDATE', '{\"id\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"id_cliente\":1,\"codigo\":\"JUD-00000001\",\"fecha_ingreso\":\"2026-02-19\",\"fecha_finalizacion\":\"2026-03-04\",\"id_tipo_tramite\":1,\"detalle\":\"JUDICIAL MODIFICADO\",\"costo\":5656,\"otros\":\"\",\"estado\":1,\"usuario\":1,\"modified_at\":\"2026-02-18 11:15:24\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":37,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 10:15:24'),
(20, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":3000,\"detalle\":\"PARA GASTOS DE CANCELACION A LA  ALCALDIA\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-18\",\"created_at\":\"2026-02-18 12:29:27\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:29:27'),
(21, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":3000,\"detalle\":\"PARA GASTOS DE CANCELACION A LA  ALCALDIA\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-18\",\"created_at\":\"2026-02-18 12:30:43\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:30:43'),
(22, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":3000,\"detalle\":\"PARA GASTOS DE CANCELACION A LA  ALCALDIA\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-18\",\"created_at\":\"2026-02-18 12:32:40\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:32:40'),
(23, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":34,\"detalle\":\"4DFDSSF\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-27\",\"created_at\":\"2026-02-18 12:42:32\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:42:32'),
(24, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":34,\"detalle\":\"4DFDSSF\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-27\",\"created_at\":\"2026-02-18 12:44:42\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:44:42'),
(25, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":34,\"detalle\":\"4DFDSSF\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-27\",\"created_at\":\"2026-02-18 12:45:38\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:45:38'),
(26, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":34,\"detalle\":\"4DFDSSF\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-27\",\"created_at\":\"2026-02-18 12:46:55\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:46:55'),
(27, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":34,\"detalle\":\"4DFDSSF\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-27\",\"created_at\":\"2026-02-18 12:47:24\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:47:24'),
(28, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":34,\"detalle\":\"4DFDSSF\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-27\",\"created_at\":\"2026-02-18 12:48:07\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:48:07'),
(29, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":34,\"detalle\":\"4DFDSSF\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-27\",\"created_at\":\"2026-02-18 12:49:26\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:49:26'),
(30, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":522,\"detalle\":\"CDCASC\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-27\",\"created_at\":\"2026-02-18 12:54:25\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 11:54:25'),
(31, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":2323,\"detalle\":\"FDFSDFSD\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-28\",\"created_at\":\"2026-02-18 13:00:28\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:00:28'),
(32, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":2323,\"detalle\":\"FDFSDFSD\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-28\",\"created_at\":\"2026-02-18 13:04:17\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:04:17'),
(33, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":2323,\"detalle\":\"FDFSDFSD\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-28\",\"created_at\":\"2026-02-18 13:04:40\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:04:40'),
(34, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":434,\"detalle\":\"3443R43R\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-28\",\"created_at\":\"2026-02-18 13:05:43\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:05:43'),
(35, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":6522,\"detalle\":\"XSASASCASC\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-03-08\",\"created_at\":\"2026-02-18 13:08:44\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:08:44'),
(36, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\",\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":6522,\"detalle\":\"XSASASCASC\",\"fecha_solicitud\":\"2026-03-08\",\"modified_at\":\"2026-02-18 13:43:44\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:43:44'),
(37, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\",\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":6522,\"detalle\":\"MODIFICADO\",\"fecha_solicitud\":\"2026-03-08\",\"modified_at\":\"2026-02-18 13:43:54\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:43:54'),
(38, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\",\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":6522,\"detalle\":\"MODIFICADO\",\"fecha_solicitud\":\"2026-03-31\",\"modified_at\":\"2026-02-18 13:44:06\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:44:06'),
(39, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\",\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":6522,\"detalle\":\"MODIFICADO\",\"fecha_solicitud\":\"2026-03-31\",\"modified_at\":\"2026-02-18 13:44:46\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:44:46'),
(40, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\",\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":6522,\"detalle\":\"MODIFICADO\",\"fecha_solicitud\":\"2026-04-01\",\"modified_at\":\"2026-02-18 13:50:45\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:50:45'),
(41, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\",\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":7000,\"detalle\":\"MODIFICADO\",\"fecha_solicitud\":\"2026-04-01\",\"modified_at\":\"2026-02-18 13:52:47\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 12:52:47'),
(42, 5, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":1000,\"detalle\":\"PARA COPIAS\",\"usuario_solicita_id\":5,\"fecha_solicitud\":\"2026-02-18\",\"created_at\":\"2026-02-18 14:18:02\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1536x864\",\"vistas_previas\":2,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 13:18:02'),
(43, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\",\"monto\":7000,\"detalle\":\"MODIFICADO MOI\",\"fecha_solicitud\":\"2026-04-01\",\"modified_at\":\"2026-02-18 14:52:56\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 13:52:56'),
(44, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\",\"monto\":3000,\"detalle\":\"MODIFICADO MOI\",\"fecha_solicitud\":\"2026-04-01\",\"updated_at\":\"2026-02-18 17:36:55\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":47,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 16:36:55'),
(45, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":20,\"detalle\":\"DSDSD\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-18\",\"created_at\":\"2026-02-18 17:37:51\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":47,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 16:37:51'),
(46, 6, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"165ba9d6-0d12-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 16:40:55'),
(47, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":200,\"detalle\":\"CDSCSD\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-17\",\"created_at\":\"2026-02-18 17:45:47\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 16:45:47'),
(48, 6, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"320d5e2e-0d13-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-18 16:52:09'),
(49, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":19,\"user_timezone\":\"America/La_Paz\"}', '2026-02-19 05:48:09'),
(50, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"2c6f2060-0cf6-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 11:31:15'),
(51, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 11:37:05'),
(52, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"2c6f2060-0cf6-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 11:43:55'),
(53, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 11:54:37'),
(54, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 11:56:43'),
(55, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"2c6f2060-0cf6-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 11:59:09'),
(56, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 12:02:35'),
(57, 7, 'salidas', 'RECHAZAR SALIDA', '{\"id\":\"7e1dafd2-0cec-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/rechazar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1452x921\",\"vistas_previas\":9,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 14:25:03'),
(58, 7, 'salidas', 'RECHAZAR SALIDA', '{\"id\":\"2c6f2060-0cf6-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/rechazar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1452x921\",\"vistas_previas\":9,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 14:26:33'),
(59, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":20,\"detalle\":\"FFFFDDDD\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-20\",\"created_at\":\"2026-02-20 16:12:42\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":11,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 15:12:42'),
(60, 5, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"78a08af8-0cdc-11f1-ac12-5254009cb4a4\",\"monto\":30,\"detalle\":\"ULTIMO DATO\",\"usuario_solicita_id\":5,\"fecha_solicitud\":\"2026-02-20\",\"created_at\":\"2026-02-20 18:05:36\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1536x864\",\"vistas_previas\":6,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 17:05:36'),
(61, 5, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"c7c3c4bf-0ea8-11f1-ac12-5254009cb4a4\",\"monto\":50,\"detalle\":\"ENVIO ENCOMIENDA\",\"usuario_solicita_id\":5,\"fecha_solicitud\":\"2026-02-20\",\"created_at\":\"2026-02-20 18:11:10\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1536x864\",\"vistas_previas\":10,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 17:11:10'),
(62, 5, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"c7c3c4bf-0ea8-11f1-ac12-5254009cb4a4\",\"monto\":10,\"detalle\":\"FOTOCOPIAS\",\"usuario_solicita_id\":5,\"fecha_solicitud\":\"2026-02-20\",\"created_at\":\"2026-02-20 18:12:49\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1536x864\",\"vistas_previas\":13,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 17:12:49'),
(63, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"c7c3c4bf-0ea8-11f1-ac12-5254009cb4a4\",\"monto\":20,\"detalle\":\"PAGAR TAXI\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-20\",\"created_at\":\"2026-02-20 18:18:42\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1680x1050\",\"vistas_previas\":4,\"user_timezone\":\"America/La_Paz\"}', '2026-02-20 17:18:42'),
(64, 8, 'salidas', 'DESPACHAR SALIDA', '{\"id\":\"2c6f2060-0cf6-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-cajero/despachar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":35,\"user_timezone\":\"America/La_Paz\"}', '2026-02-21 18:22:38'),
(65, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"c7c3c4bf-0ea8-11f1-ac12-5254009cb4a4\",\"monto\":2323,\"detalle\":\"DDADSD\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-21 02:10:25\",\"created_at\":\"2026-02-22 02:10:25\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 01:10:25'),
(66, 6, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"31370cf7-0fb5-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 01:10:31'),
(67, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"20ae621e-0eaa-11f1-ac12-5254009cb4a4\",\"monto\":20,\"detalle\":\"PAGAR TAXI\",\"fecha_solicitud\":\"2026-02-20 09:18:27\",\"updated_at\":\"2026-02-22 09:18:27\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"594x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 08:18:27'),
(68, 7, 'salidas', 'RECHAZAR SALIDA', '{\"id\":\"20ae621e-0eaa-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/rechazar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"594x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 08:22:11'),
(69, 7, 'salidas', 'RECHAZAR SALIDA', '{\"id\":\"20ae621e-0eaa-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/rechazar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 08:30:33'),
(70, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"20ae621e-0eaa-11f1-ac12-5254009cb4a4\",\"monto\":20,\"detalle\":\"PAGAR TAXI\",\"fecha_solicitud\":\"2026-02-20 09:31:48\",\"updated_at\":\"2026-02-22 09:31:48\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"594x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 08:31:48'),
(71, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"20ae621e-0eaa-11f1-ac12-5254009cb4a4\",\"monto\":200,\"detalle\":\"PAGAR TAXI\",\"fecha_solicitud\":\"2026-02-20 09:32:00\",\"updated_at\":\"2026-02-22 09:32:00\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"594x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 08:32:00'),
(72, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"20ae621e-0eaa-11f1-ac12-5254009cb4a4\",\"monto\":200,\"detalle\":\"PAGAR TAXI\",\"fecha_solicitud\":\"2026-02-20 09:39:38\",\"updated_at\":\"2026-02-22 09:39:38\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"594x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 08:39:38'),
(73, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"40b63697-0ff8-11f1-ac12-5254009cb4a4\",\"monto\":200,\"detalle\":\"PAGO SEGIP\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-22 10:12:37\",\"created_at\":\"2026-02-22 10:12:37\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.172.103\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"https://krsucre.netlify.app/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":3,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 09:12:37'),
(74, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"8acdf58d-0ff8-11f1-ac12-5254009cb4a4\",\"monto\":210,\"detalle\":\"PAGO SEGIP\",\"fecha_solicitud\":\"2026-02-22 10:13:15\",\"updated_at\":\"2026-02-22 10:13:15\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.172.103\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"https://krsucre.netlify.app/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":3,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 09:13:15'),
(75, 1, 'tramites', 'UPDATE', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"id_cliente\":3,\"codigo\":\"ADM-00000002\",\"fecha_ingreso\":\"2026-02-01\",\"fecha_finalizacion\":\"2026-03-31\",\"id_tipo_tramite\":2,\"detalle\":\"APROVACION DE LINEA DE NIVELES\",\"costo\":\"3500\",\"otros\":\"\",\"estado\":1,\"usuario\":1,\"modified_at\":\"2026-02-22 11:33:24\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.172.103\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"https://krsucre.netlify.app/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":32,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 10:33:24'),
(76, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":100,\"detalle\":\"ENVIO DE ENCOMIENDA\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-22 11:41:28\",\"created_at\":\"2026-02-22 11:41:28\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.172.103\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"https://krsucre.netlify.app/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":32,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 10:41:28'),
(77, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"f477923e-1004-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.172.103\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"https://krsucre.netlify.app/\",\"idioma\":\"es-ES\",\"resolucion\":\"1536x864\",\"vistas_previas\":2,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 10:45:25'),
(78, 8, 'salidas', 'DESPACHAR SALIDA', '{\"id\":\"f477923e-1004-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.172.103\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/salidas-cajero/despachar\",\"metodo\":\"POST\",\"origen\":\"https://krsucre.netlify.app/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":32,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 10:52:39');
INSERT INTO `auditorias` (`id`, `usuario_id`, `tabla`, `accion`, `detalle`, `metadata`, `fecha`) VALUES
(79, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1000,\"detalle\":\"PRIMER PAGO\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:14:43'),
(80, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1500,\"detalle\":\"SEGUNDO PAGO\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:17:01'),
(81, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":500,\"detalle\":\"TERCER PAGO\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:24:06'),
(82, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":500,\"detalle\":\"CUARTO PAGO\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:25:29'),
(83, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1000,\"detalle\":\"PRIMERO PAGO\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:50:54'),
(84, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1000,\"detalle\":\"PRIMERO PAGO\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:51:16'),
(85, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1000,\"detalle\":\"PRIMERO PAGO\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:54:25'),
(86, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1000,\"detalle\":\"PRIMERO PAGO\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:57:54'),
(87, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1000,\"detalle\":\"PRIMERO PAGO\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:58:00'),
(88, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1000,\"detalle\":\"PRIMERO PAGO\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:58:25'),
(89, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":100,\"detalle\":\"DCCASCSA\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:58:40'),
(90, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":100,\"detalle\":\"DCCASCSA\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:59:28'),
(91, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":100,\"detalle\":\"DCCASCSA\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 17:59:55'),
(92, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":50,\"detalle\":\"DSVDS\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 18:00:08'),
(93, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1000,\"detalle\":\"PRIMERO PAGO\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 18:10:50'),
(94, 8, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"38237114-1022-11f1-ac12-5254009cb4a4\",\"monto\":1000}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 18:56:49'),
(95, 8, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"38237114-1022-11f1-ac12-5254009cb4a4\",\"monto\":1000}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 19:08:01'),
(96, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":500,\"tipo\":\"EFECTIVO\",\"detalle\":\"SEGUNDO PAGO\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 23:19:17'),
(97, 8, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"4e738b4e-104d-11f1-ac12-5254009cb4a4\",\"monto\":500,\"tipo\":\"EFECTIVO\",\"fecha_ingreso\":\"2026-02-22\",\"detalle\":\"SEGUNDO PAGO\",\"updated_at\":\"2026-02-23T01:00:22.109Z\",\"usuario\":8}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 00:00:22'),
(98, 8, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"4e738b4e-104d-11f1-ac12-5254009cb4a4\",\"monto\":500,\"tipo\":\"EFECTIVO\",\"fecha_ingreso\":\"2026-02-22\",\"detalle\":\"SEGUNDO PAGO TERC\",\"updated_at\":\"2026-02-23T01:00:42.020Z\",\"usuario\":8}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 00:00:42'),
(99, 8, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"4e738b4e-104d-11f1-ac12-5254009cb4a4\",\"monto\":500,\"tipo\":\"TRANFERENCIA\",\"fecha_ingreso\":\"2026-02-22\",\"detalle\":\"SEGUNDO PAGO TERC\",\"updated_at\":\"2026-02-23T01:01:00.077Z\",\"usuario\":8}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 00:01:00'),
(100, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":2000,\"tipo\":\"TRANFERENCIA\",\"detalle\":\"PRIMER PAGO\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 00:55:57'),
(101, 8, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"cf99b11a-105a-11f1-ac12-5254009cb4a4\",\"monto\":2000,\"tipo\":\"TRANFERENCIA\",\"fecha_ingreso\":\"2026-02-22\",\"detalle\":\"PRIMER PAGO EDIT\",\"updated_at\":\"2026-02-23T01:56:07.807Z\",\"usuario\":8}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 00:56:07'),
(102, 8, 'salidas', 'DESPACHAR SALIDA', '{\"id\":\"f477923e-1004-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-cajero/despachar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 22:09:20'),
(103, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":500,\"tipo\":\"EFECTIVO\",\"detalle\":\"PAGUITO\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 02:22:42'),
(104, 8, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"eed1fbc7-1066-11f1-ac12-5254009cb4a4\",\"monto\":500,\"tipo\":\"EFECTIVO\",\"fecha_ingreso\":\"2026-03-01\",\"detalle\":\"PAGUITO EDIT\",\"updated_at\":\"2026-02-23T03:24:23.657Z\",\"usuario\":8}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 02:24:23'),
(105, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"f477923e-1004-11f1-ac12-5254009cb4a4\",\"monto\":100,\"detalle\":\"ENVIO DE ENCOMIENDA MODIFICA\",\"fecha_solicitud\":\"2026-02-22 00:29:20\",\"updated_at\":\"2026-02-23 00:29:20\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 23:29:20'),
(106, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":200,\"detalle\":\"GASTO 2\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-20 00:30:10\",\"created_at\":\"2026-02-23 00:30:10\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 23:30:10'),
(107, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"5b060fc6-1070-11f1-ac12-5254009cb4a4\",\"monto\":200,\"detalle\":\"GASTO 2 MODIFICA\",\"fecha_solicitud\":\"2026-02-20 00:30:35\",\"updated_at\":\"2026-02-23 00:30:35\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"412x915\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 23:30:35'),
(108, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"5b060fc6-1070-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1159x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 23:47:20'),
(109, 7, 'salidas', 'RECHAZAR SALIDA', '{\"id\":\"f477923e-1004-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/rechazar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1159x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-22 23:47:25'),
(110, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":500,\"detalle\":\"ENVIO DE ENCOMIENDAS\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-23 18:31:14\",\"created_at\":\"2026-02-23 18:31:14\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1159x921\",\"vistas_previas\":10,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 17:31:14'),
(111, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"616cb6f3-1107-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":13,\"user_timezone\":\"America/La_Paz\"}', '2026-02-24 18:27:41'),
(112, 8, 'salidas', 'DESPACHAR SALIDA', '{\"id\":\"616cb6f3-1107-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-cajero/despachar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1536x864\",\"vistas_previas\":2,\"user_timezone\":\"America/La_Paz\"}', '2026-02-24 18:30:15'),
(113, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1000,\"tipo\":\"TRANFERENCIA\",\"detalle\":\"PRIMER PAGO\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1536x864\",\"vistas_previas\":5,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 22:48:10'),
(114, 8, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":1400,\"tipo\":\"TRANFERENCIA\",\"detalle\":\"SEGUNDO PAGO\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1536x864\",\"vistas_previas\":5,\"user_timezone\":\"America/La_Paz\"}', '2026-02-23 22:48:45'),
(115, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"616cb6f3-1107-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":14,\"user_timezone\":\"America/La_Paz\"}', '2026-02-24 19:31:53'),
(116, 7, 'salidas', 'HABILITAR EDICION SALIDA', '{\"id\":\"616cb6f3-1107-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/habilitar-edicion\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":14,\"user_timezone\":\"America/La_Paz\"}', '2026-02-24 19:32:10'),
(117, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"616cb6f3-1107-11f1-ac12-5254009cb4a4\",\"monto\":500,\"detalle\":\"ENVIO DE ENCOMIENDAS\",\"fecha_solicitud\":\"2026-02-23 20:32:20\",\"updated_at\":\"2026-02-24 20:32:20\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1680x1050\",\"vistas_previas\":18,\"user_timezone\":\"America/La_Paz\"}', '2026-02-24 19:32:20'),
(118, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"616cb6f3-1107-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":14,\"user_timezone\":\"America/La_Paz\"}', '2026-02-24 19:32:31'),
(119, 7, 'salidas', 'HABILITAR EDICION SALIDA', '{\"id\":\"616cb6f3-1107-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/habilitar-edicion\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":14,\"user_timezone\":\"America/La_Paz\"}', '2026-02-24 19:35:12'),
(120, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"616cb6f3-1107-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1184x918\",\"vistas_previas\":4,\"user_timezone\":\"America/La_Paz\"}', '2026-02-25 09:37:51'),
(121, 8, 'salidas', 'DESPACHAR SALIDA', '{\"id\":\"616cb6f3-1107-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas-cajero/despachar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1410x921\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-02-25 09:42:49'),
(122, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"monto\":309,\"detalle\":\"TARGETAS PARA EL TELEFRONO\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-26 15:53:52\",\"created_at\":\"2026-02-25 15:53:52\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.146.21\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es-ES\",\"resolucion\":\"1680x1050\",\"vistas_previas\":17,\"user_timezone\":\"America/La_Paz\"}', '2026-02-25 14:53:52'),
(123, 7, 'salidas', 'APROBAR SALIDA', '{\"id\":\"b5f10eff-1283-11f1-a199-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.146.21\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/salidas-gerente/aprobar\",\"metodo\":\"POST\",\"origen\":\"https://krsucre.netlify.app/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":3,\"user_timezone\":\"America/La_Paz\"}', '2026-02-25 14:54:18'),
(124, 8, 'salidas', 'DESPACHAR SALIDA', '{\"id\":\"b5f10eff-1283-11f1-a199-5254009cb4a4\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"186.41.146.21\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/salidas-cajero/despachar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1119x921\",\"vistas_previas\":12,\"user_timezone\":\"America/La_Paz\"}', '2026-02-25 14:54:44'),
(125, 8, 'salidas', 'DESPACHAR SALIDA', '{\"id\":\"616cb6f3-1107-11f1-ac12-5254009cb4a4\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"186.41.146.21\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/salidas-cajero/despachar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1119x921\",\"vistas_previas\":13,\"user_timezone\":\"America/La_Paz\"}', '2026-02-25 14:56:18'),
(126, 8, 'tramites', 'Trámite marcado: Paralizado', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"estado\":0,\"usuario\":8,\"modified_at\":\"2026-02-28 13:15:20\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/cambiar-estado\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1380x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 12:15:20'),
(127, 8, 'tramites', 'UPDATE', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"id_cliente\":3,\"codigo\":\"ADM-00000002\",\"fecha_ingreso\":\"2026-02-01\",\"fecha_finalizacion\":\"2026-03-31\",\"id_tipo_tramite\":2,\"detalle\":\"APROVACION DE LINEA DE NIVELES\",\"costo\":3500,\"otros\":\"\",\"estado\":2,\"usuario\":8,\"modified_at\":\"2026-02-28 13:57:31\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1380x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 12:57:31'),
(128, 8, 'tramites', 'UPDATE', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"id_cliente\":3,\"codigo\":\"ADM-00000002\",\"fecha_ingreso\":\"2026-02-01\",\"fecha_finalizacion\":\"2026-03-31\",\"id_tipo_tramite\":2,\"detalle\":\"APROVACION DE LINEA DE NIVELES\",\"costo\":3500,\"otros\":\"\",\"estado\":2,\"usuario\":8,\"modified_at\":\"2026-02-28 13:59:28\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1380x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 12:59:28'),
(129, 8, 'tramites', 'UPDATE', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"id_cliente\":3,\"codigo\":\"ADM-00000002\",\"fecha_ingreso\":\"2026-02-01\",\"fecha_finalizacion\":\"2026-03-31\",\"id_tipo_tramite\":2,\"detalle\":\"APROVACION DE LINEA DE NIVELES\",\"costo\":3500,\"otros\":\"\",\"estado\":2,\"usuario\":8,\"modified_at\":\"2026-02-28 14:01:45\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1380x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 13:01:45'),
(130, 8, 'tramites', 'UPDATE', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"id_cliente\":3,\"codigo\":\"ADM-00000002\",\"fecha_ingreso\":\"2026-02-01\",\"fecha_finalizacion\":\"2026-03-31\",\"id_tipo_tramite\":2,\"detalle\":\"APROVACION DE LINEA DE NIVELES\",\"costo\":3500,\"otros\":\"\",\"estado\":3,\"usuario\":8,\"modified_at\":\"2026-02-28 14:03:32\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1380x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 13:03:32'),
(131, 8, 'tramites', 'UPDATE', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"id_cliente\":3,\"codigo\":\"ADM-00000002\",\"fecha_ingreso\":\"2026-02-01\",\"fecha_finalizacion\":\"2026-03-31\",\"id_tipo_tramite\":2,\"detalle\":\"APROVACION DE LINEA DE NIVELES\",\"costo\":3500,\"otros\":\"\",\"estado\":3,\"usuario\":8,\"modified_at\":\"2026-02-28 14:12:56\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1380x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 13:12:56'),
(132, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"40b63697-0ff8-11f1-ac12-5254009cb4a4\",\"monto\":300,\"detalle\":\"GASTO EJEPLO\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-28 17:07:09\",\"created_at\":\"2026-02-28 17:07:09\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 16:07:09'),
(133, 1, 'tramites', 'UPDATE', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"id_cliente\":3,\"codigo\":\"ADM-00000002\",\"fecha_ingreso\":\"2026-02-01\",\"fecha_finalizacion\":\"2026-03-31\",\"id_tipo_tramite\":2,\"detalle\":\"APROVACION DE LINEA DE NIVELES\",\"costo\":3500,\"otros\":\"\",\"estado\":3,\"usuario\":1,\"modified_at\":\"2026-03-01 20:42:16\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 19:42:16'),
(134, 1, 'tramites', 'UPDATE', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"id_cliente\":3,\"codigo\":\"ADM-00000002\",\"fecha_ingreso\":\"2026-02-01\",\"fecha_finalizacion\":\"2026-03-31\",\"id_tipo_tramite\":2,\"detalle\":\"APROVACION DE LINEA DE NIVELES\",\"costo\":3500,\"otros\":\"\",\"estado\":3,\"usuario\":1,\"modified_at\":\"2026-03-01 20:44:19\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 19:44:19'),
(135, 1, 'tramites', 'UPDATE', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"id_cliente\":3,\"codigo\":\"ADM-00000002\",\"fecha_ingreso\":\"2026-02-01\",\"fecha_finalizacion\":\"2026-03-31\",\"id_tipo_tramite\":2,\"detalle\":\"APROVACION DE LINEA DE NIVELES\",\"costo\":3500,\"otros\":\"\",\"estado\":3,\"usuario\":1,\"modified_at\":\"2026-03-01 20:44:36\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 19:44:36'),
(136, 1, 'tramites', 'UPDATE', '{\"id\":\"b9d76a0d-1003-11f1-ac12-5254009cb4a4\",\"id_cliente\":3,\"codigo\":\"ADM-00000002\",\"fecha_ingreso\":\"2026-02-01\",\"fecha_finalizacion\":\"2026-03-31\",\"id_tipo_tramite\":2,\"detalle\":\"APROVACION DE LINEA DE NIVELES\",\"costo\":3500,\"otros\":\"\",\"estado\":3,\"usuario\":1,\"modified_at\":\"2026-03-01 20:44:54\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 19:44:54'),
(137, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"40b63697-0ff8-11f1-ac12-5254009cb4a4\",\"monto\":200,\"detalle\":\"EWEWE\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-28 22:54:50\",\"created_at\":\"2026-03-01 22:54:50\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 21:54:50'),
(138, 6, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"04d1baa3-151a-11f1-a199-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 22:03:29'),
(139, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"40b63697-0ff8-11f1-ac12-5254009cb4a4\",\"monto\":3233,\"detalle\":\"DDASD\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-28 23:04:38\",\"created_at\":\"2026-03-01 23:04:38\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 22:04:38'),
(140, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"63b5ef54-151b-11f1-a199-5254009cb4a4\",\"monto\":3233,\"detalle\":\"DDASD\",\"fecha_solicitud\":\"2026-03-01 23:07:27\",\"updated_at\":\"2026-03-01 23:07:27\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 22:07:27'),
(141, 6, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"63b5ef54-151b-11f1-a199-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 22:07:52'),
(142, 6, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"40b63697-0ff8-11f1-ac12-5254009cb4a4\",\"monto\":4234234,\"detalle\":\"RFDFDSFDSF\",\"usuario_solicita_id\":6,\"fecha_solicitud\":\"2026-02-28 23:09:12\",\"created_at\":\"2026-03-01 23:09:12\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 22:09:12'),
(143, 6, 'salidas', 'UPDATE SALIDA', '{\"id\":\"06bc81fe-151c-11f1-a199-5254009cb4a4\",\"monto\":4234234,\"detalle\":\"MODIFICADO\",\"fecha_solicitud\":\"2026-03-01 23:09:26\",\"updated_at\":\"2026-03-01 23:09:26\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 22:09:26'),
(144, 8, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"40b63697-0ff8-11f1-ac12-5254009cb4a4\",\"monto\":3423,\"detalle\":\"DSFDSFDSF\",\"usuario_solicita_id\":8,\"fecha_solicitud\":\"2026-02-28 23:29:23\",\"created_at\":\"2026-03-01 23:29:23\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 22:29:23'),
(145, 8, 'tramites', 'UPDATE', '{\"id\":\"6e52d38c-151f-11f1-a199-5254009cb4a4\",\"id_cliente\":3,\"fecha_ingreso\":\"2026-02-28\",\"fecha_finalizacion\":\"2026-02-28\",\"id_tipo_tramite\":2,\"detalle\":\"PRUEBA DEL CAJERO MODIFICADO\",\"costo\":3000,\"otros\":\"\",\"estado\":1,\"usuario\":8,\"id_entidadS\":1,\"modified_at\":\"2026-03-01 23:36:15\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-03-01 22:36:15'),
(146, 7, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"6e52d38c-151f-11f1-a199-5254009cb4a4\",\"monto\":3233,\"detalle\":\"WQWWW\",\"usuario_solicita_id\":7,\"fecha_solicitud\":\"2026-03-15 00:06:31\",\"created_at\":\"2026-03-01 00:06:31\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:06:31'),
(147, 7, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"6e52d38c-151f-11f1-a199-5254009cb4a4\",\"monto\":32333,\"detalle\":\"WQWWWS\",\"usuario_solicita_id\":7,\"fecha_solicitud\":\"2026-03-15 00:07:33\",\"created_at\":\"2026-03-01 00:07:33\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:07:33'),
(148, 7, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"6e52d38c-151f-11f1-a199-5254009cb4a4\",\"monto\":32333,\"detalle\":\"WQWWWS\",\"usuario_solicita_id\":7,\"fecha_solicitud\":\"2026-03-15 00:08:47\",\"created_at\":\"2026-03-01 00:08:47\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:08:47'),
(149, 7, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"6e52d38c-151f-11f1-a199-5254009cb4a4\",\"monto\":32333,\"detalle\":\"WQWWWS\",\"usuario_solicita_id\":7,\"fecha_solicitud\":\"2026-03-15 00:09:35\",\"created_at\":\"2026-03-01 00:09:35\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:09:35'),
(150, 7, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"6e52d38c-151f-11f1-a199-5254009cb4a4\",\"monto\":32333,\"detalle\":\"WQWWWS\",\"usuario_solicita_id\":7,\"fecha_solicitud\":\"2026-03-15 00:10:19\",\"created_at\":\"2026-03-01 00:10:19\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:10:19'),
(151, 7, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"6e52d38c-151f-11f1-a199-5254009cb4a4\",\"monto\":4234,\"detalle\":\"QSQWSW\",\"usuario_solicita_id\":7,\"fecha_solicitud\":\"2026-03-08 00:10:51\",\"created_at\":\"2026-03-01 00:10:51\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1455x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:10:51'),
(152, 7, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"a38cc8ab-1524-11f1-a199-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1455x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:11:00'),
(153, 7, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"9010b318-1524-11f1-a199-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1455x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:11:03'),
(154, 7, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"762c4681-1524-11f1-a199-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1455x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:11:06'),
(155, 7, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"59bca8f0-1524-11f1-a199-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1455x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:11:11');
INSERT INTO `auditorias` (`id`, `usuario_id`, `tabla`, `accion`, `detalle`, `metadata`, `fecha`) VALUES
(156, 7, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"084e2070-1524-11f1-a199-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1455x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:11:15'),
(157, 7, 'salidas', 'ELIMINAR SALIDA', '{\"id\":\"2da24f83-1524-11f1-a199-5254009cb4a4\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/eliminar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1455x921\",\"vistas_previas\":50,\"user_timezone\":\"America/La_Paz\"}', '2026-02-28 23:11:19');

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `ap1` text NOT NULL,
  `ap2` text DEFAULT NULL,
  `ci` text NOT NULL,
  `celular` text NOT NULL,
  `direccion` text NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL,
  `modified_at` datetime DEFAULT NULL,
  `usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `ap1`, `ap2`, `ci`, `celular`, `direccion`, `estado`, `created_at`, `modified_at`, `usuario`) VALUES
(3, 'KAROLINA', 'RIVAS', 'PUMA', '5656885', '75265889', 'CALLE OMNTERREY 45', 1, '2026-02-22 10:09:29', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `entidad`
--

CREATE TABLE `entidad` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `nombre_corto` varchar(12) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `all_permision` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `entidad`
--

INSERT INTO `entidad` (`id`, `nombre`, `nombre_corto`, `estado`, `fecha_inicio`, `fecha_fin`, `all_permision`) VALUES
(1, 'MAURITO', 'MAURITO', 1, '2026-02-01', '2027-02-28', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ingresos`
--

CREATE TABLE `ingresos` (
  `id` varchar(37) NOT NULL,
  `id_tramite` varchar(37) NOT NULL,
  `numero` int(11) NOT NULL,
  `monto` decimal(10,0) NOT NULL,
  `tipo` text NOT NULL,
  `fecha_ingreso` datetime NOT NULL,
  `detalle` text NOT NULL,
  `usuario` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `rol` text NOT NULL,
  `numero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `rol`, `numero`) VALUES
(1, 'ADMIN', 1),
(2, 'GERENTE', 2),
(3, 'CAJERO', 3),
(4, 'AUXILIAR', 4);

-- --------------------------------------------------------

--
-- Table structure for table `salidas`
--

CREATE TABLE `salidas` (
  `id` varchar(36) NOT NULL,
  `numero` int(11) NOT NULL,
  `id_tramite` varchar(36) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 3 COMMENT '1=Solicitado, 2=Aprobado, 3=Despachado, 4=Rechazado',
  `monto` decimal(12,2) NOT NULL,
  `detalle` text NOT NULL,
  `usuario_solicita_id` int(11) NOT NULL,
  `fecha_solicitud` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario_aprueba_id` int(11) DEFAULT NULL,
  `fecha_aprobacion` datetime DEFAULT NULL,
  `usuario_despacha_id` int(11) DEFAULT NULL,
  `fecha_despacho` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salidas`
--

INSERT INTO `salidas` (`id`, `numero`, `id_tramite`, `estado`, `monto`, `detalle`, `usuario_solicita_id`, `fecha_solicitud`, `usuario_aprueba_id`, `fecha_aprobacion`, `usuario_despacha_id`, `fecha_despacho`, `created_at`, `updated_at`) VALUES
('06bc81fe-151c-11f1-a199-5254009cb4a4', 1, '40b63697-0ff8-11f1-ac12-5254009cb4a4', 3, 4234234.00, 'MODIFICADO', 6, '2026-03-01 23:09:26', NULL, NULL, NULL, NULL, '2026-02-28 23:09:12', '2026-03-01 23:09:26'),
('d8946b33-151e-11f1-a199-5254009cb4a4', 2, '40b63697-0ff8-11f1-ac12-5254009cb4a4', 3, 3423.00, 'DSFDSFDSF', 8, '2026-02-28 23:29:23', NULL, NULL, NULL, NULL, '2026-02-28 23:29:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sesion`
--

CREATE TABLE `sesion` (
  `id` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `usuario` text NOT NULL,
  `titular` text NOT NULL,
  `rol` int(11) NOT NULL,
  `token` longtext NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `entidad` text NOT NULL,
  `all_permision` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sesion`
--

INSERT INTO `sesion` (`id`, `idusuario`, `usuario`, `titular`, `rol`, `token`, `fecha`, `hora`, `id_entidad`, `entidad`, `all_permision`) VALUES
(141, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjNUMjI6MzA6NDIuNjgxWiIsImlhdCI6MTc3MTg4NTg0MiwiZXhwIjoxNzcyMTQ1MDQyfQ.OwSllfutV_3fbEd7tt1hT0IA51ugHV914nLo5aPcJUQ', '2026-02-23', '18:30:42', 0, '', 0),
(142, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTIzVDIyOjU2OjEwLjkxMloiLCJpYXQiOjE3NzE4ODczNzAsImV4cCI6MTc3MjE0NjU3MH0.eGgTzoimKjZj8ahU68L74N5fumwUwDkjSmsVr8dj_gg', '2026-02-23', '18:56:10', 0, '', 0),
(143, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDItMjNUMjM6Mjg6MzAuNjYxWiIsImlhdCI6MTc3MTg4OTMxMCwiZXhwIjoxNzcyMTQ4NTEwfQ.mzI6NdPZvP6qABJc0ZFhAYaG3bd460ftDNCedcWcmgw', '2026-02-24', '19:28:30', 0, '', 0),
(144, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjNUMjM6NTU6MjcuMDMxWiIsImlhdCI6MTc3MTg5MDkyNywiZXhwIjoxNzcyMTUwMTI3fQ.B9JRoP1ET-K33SrcQoBJgFT5JmNh_GvpEUIrsbMZ3Go', '2026-02-24', '19:55:27', 0, '', 0),
(145, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI0VDAwOjU4OjQ3Ljk2OVoiLCJpYXQiOjE3NzE4OTQ3MjcsImV4cCI6MTc3MjE1MzkyN30.Qsweu0pwCH6V3jYSOhbsN_ZGG5tKH2yCE7zppejpmqY', '2026-02-24', '20:58:47', 0, '', 0),
(146, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI0VDAwOjU4OjU2LjEzMVoiLCJpYXQiOjE3NzE4OTQ3MzYsImV4cCI6MTc3MjE1MzkzNn0.hokUCujhKdS3W69kfdFfUnt2CMIyMUbzlaBoDVQYjYY', '2026-02-24', '20:58:56', 0, '', 0),
(147, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI0VDAwOjU5OjA1LjY1NloiLCJpYXQiOjE3NzE4OTQ3NDUsImV4cCI6MTc3MjE1Mzk0NX0.Gh7hNAVBqsTaoCVPRt9UYzGBdgOiW2_lbf6Ud-Us-w4', '2026-02-24', '20:59:05', 0, '', 0),
(148, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjRUMDA6NTk6MDkuMzQxWiIsImlhdCI6MTc3MTg5NDc0OSwiZXhwIjoxNzcyMTUzOTQ5fQ.yyLKxW5aodHL-RyusuGMdAr8f-Maq2W3N9Hw4Tz0xT4', '2026-02-24', '20:59:09', 0, '', 0),
(149, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI0VDAwOjU5OjM3LjM5OVoiLCJpYXQiOjE3NzE4OTQ3NzcsImV4cCI6MTc3MjE1Mzk3N30.BGIGMxHeP3ap5T--6r0h9M77WUsqyWGJGx3r5iyn7VQ', '2026-02-24', '20:59:37', 0, '', 0),
(151, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjRUMDE6MTI6MzAuOTYyWiIsImlhdCI6MTc3MTg5NTU1MCwiZXhwIjoxNzcyMTU0NzUwfQ.KEpCeifhr_zLo4qA_86LHvsYpdSKKI1vgpnfzy2ATKQ', '2026-02-24', '21:12:30', 0, '', 0),
(152, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI0VDAxOjEyOjQwLjE4MFoiLCJpYXQiOjE3NzE4OTU1NjAsImV4cCI6MTc3MjE1NDc2MH0.7gG4kKG23BnN8SeQ1gXCfrZ9Jm4DKA7HsLkR819PiEs', '2026-02-24', '21:12:40', 0, '', 0),
(153, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI0VDAxOjEzOjQ1LjMwOFoiLCJpYXQiOjE3NzE4OTU2MjUsImV4cCI6MTc3MjE1NDgyNX0.7HaGmSgHKOzeCRTQTSXdqYRejaTfkn4NaHuwAEtj5fE', '2026-02-24', '21:13:45', 0, '', 0),
(154, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjRUMDE6MTY6MDQuOTg0WiIsImlhdCI6MTc3MTg5NTc2NCwiZXhwIjoxNzcyMTU0OTY0fQ.4g7tkAl15lS9ozRUG25XFfur_qXdYgZlOzSZX8Tcm7w', '2026-02-24', '21:16:04', 0, '', 0),
(155, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjRUMDE6MTY6MTQuNDA1WiIsImlhdCI6MTc3MTg5NTc3NCwiZXhwIjoxNzcyMTU0OTc0fQ.RxnlX8lCw5GfgPDhVGpv-PwixzFandCQZh0va2Nat08', '2026-02-24', '21:16:14', 0, '', 0),
(156, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI0VDAxOjE2OjU5Ljc3MFoiLCJpYXQiOjE3NzE4OTU4MTksImV4cCI6MTc3MjE1NTAxOX0.tvXbG2dC7wMN62-5os_oU02kHvRD8qBC0gpvUuWbOwg', '2026-02-24', '21:16:59', 0, '', 0),
(157, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI0VDAxOjE3OjIzLjk0MFoiLCJpYXQiOjE3NzE4OTU4NDMsImV4cCI6MTc3MjE1NTA0M30.7i1hTvk59vd-hYeXx2hKO7jDNNzdosoDYIhu-7HVQ1A', '2026-02-24', '21:17:23', 0, '', 0),
(158, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjRUMDE6MTc6NTQuNDU3WiIsImlhdCI6MTc3MTg5NTg3NCwiZXhwIjoxNzcyMTU1MDc0fQ.UCvEbBWXcNQCn7mu2UF-nJPwd6TYgKBvU8VOOYd5c-4', '2026-02-24', '21:17:54', 0, '', 0),
(159, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDItMjRUMDE6MTg6MjguNjYwWiIsImlhdCI6MTc3MTg5NTkwOCwiZXhwIjoxNzcyMTU1MTA4fQ.Tk4QAUwGr_jTa5ZB1rIG3ArCxr7Ig1EZcv7OEMMqr2o', '2026-02-24', '21:18:28', 0, '', 0),
(160, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI0VDAxOjIyOjM1LjE0NFoiLCJpYXQiOjE3NzE4OTYxNTUsImV4cCI6MTc3MjE1NTM1NX0.HsbBP1rO4nWCdhEiynCN6sKPjdHA9EFtcVmIa3axuJk', '2026-02-24', '21:22:35', 0, '', 0),
(161, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI0VDAxOjI3OjQxLjQzNloiLCJpYXQiOjE3NzE4OTY0NjEsImV4cCI6MTc3MjE1NTY2MX0.hoJ51k5ha86KoVbKNpOsP7KtB-vYPFZu41zX3zM-QUU', '2026-02-24', '21:27:41', 0, '', 0),
(162, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDItMjRUMDI6MTM6MDcuMDgxWiIsImlhdCI6MTc3MTg5OTE4NywiZXhwIjoxNzcyMTU4Mzg3fQ.SaFkIzNRmnAW8ty60VefSTY1fohG_F6qU0fY8ogyBog', '2026-02-24', '22:13:07', 0, '', 0),
(163, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDItMjVUMTI6NDg6NDAuMzkzWiIsImlhdCI6MTc3MjAyMzcyMCwiZXhwIjoxNzcyMjgyOTIwfQ.8fKjEJmRZNky7GLnr_DrKZ2HzUPs_B7hfFyB3wwswac', '2026-02-25', '08:48:40', 0, '', 0),
(164, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI1VDE0OjM3OjQzLjAzMVoiLCJpYXQiOjE3NzIwMzAyNjMsImV4cCI6MTc3MjI4OTQ2M30.pwibO8xXERFmL_Yelb0rg1TIyHWuc5pN1EOXfYpzSzk', '2026-02-25', '10:37:43', 0, '', 0),
(165, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjVUMTU6MTQ6MzQuODUxWiIsImlhdCI6MTc3MjAzMjQ3NCwiZXhwIjoxNzcyMjkxNjc0fQ.Is9YenhTUStZczmZ9mwFnQPsLf6nN-Y2o3xPyNrBTmM', '2026-02-25', '11:14:34', 0, '', 0),
(166, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI1VDE2OjIxOjU5Ljg5N1oiLCJpYXQiOjE3NzIwMzY1MTksImV4cCI6MTc3MjI5NTcxOX0.muyyxUE5DHlf4IKfQEMCK_CQqrT5H9pJE6S3AAgLCOQ', '2026-02-25', '12:21:59', 0, '', 0),
(167, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI1VDE2OjI5OjQ0LjMwNFoiLCJpYXQiOjE3NzIwMzY5ODQsImV4cCI6MTc3MjI5NjE4NH0.h2ccPFFNG6rN1lQ181wGlm5nXWVKWjnN71clOadigRQ', '2026-02-25', '12:29:44', 0, '', 0),
(168, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI1VDE2OjMwOjQ3LjE3NFoiLCJpYXQiOjE3NzIwMzcwNDcsImV4cCI6MTc3MjI5NjI0N30.xB-taHMU1tRcd77HctEiczK9guFJ1g3EB-R9wNG8T9s', '2026-02-25', '12:30:47', 0, '', 0),
(169, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDItMjVUMTg6MTc6MjUuNjk4WiIsImlhdCI6MTc3MjA0MzQ0NSwiZXhwIjoxNzcyMzAyNjQ1fQ.dDS0pdW0UPX2TF3zvKcr9dHjsQaLhhzcosDN9ANd-aY', '2026-02-25', '14:17:25', 0, '', 0),
(170, 7, 'jhovanna', 'JHOVANNA', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSkhPVkFOTkEiLCJzZXJ2aWNpbyI6Ijc4NzUxMTEwIiwiZmVjaGEiOiIyMDI2LTAyLTI1VDE4OjE4OjU1LjQzOFoiLCJpYXQiOjE3NzIwNDM1MzUsImV4cCI6MTc3MjMwMjczNX0.K-VUvZL8o6C0cFYQwnoyo3e3d_DEC5-5egZoBto1FCI', '2026-02-25', '14:18:55', 0, '', 0),
(172, 7, 'ramires', 'RAMIRES', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiUkFNSVJFUyIsInNlcnZpY2lvIjoiNzg3NTExMTAiLCJmZWNoYSI6IjIwMjYtMDItMjZUMDI6MDM6NDEuNTExWiIsImlhdCI6MTc3MjA3MTQyMSwiZXhwIjoxNzcyMzMwNjIxfQ.un94QsI7RvfyqdANty4Ovz6Yy3csngAQHAcmMKMtr78', '2026-02-26', '22:03:41', 0, '', 0),
(173, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDItMjhUMTI6MDE6MTguNDgwWiIsImlhdCI6MTc3MjI4MDA3OCwiZXhwIjoxNzcyNTM5Mjc4fQ.vNyp_XG_XZin7FLqPwUeTWfemUdpFsRr5OXAkk34mUo', '2026-02-28', '08:01:18', 0, '', 0),
(174, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDItMjhUMTI6MDE6MjAuMDE1WiIsImlhdCI6MTc3MjI4MDA4MCwiZXhwIjoxNzcyNTM5MjgwfQ.hTDfOQBbtwQu-qQZQISlCrUwK3A1s5brXlAGoRtMGNM', '2026-02-28', '08:01:20', 0, '', 0),
(175, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDItMjhUMTY6NTM6MTEuNjY0WiIsImlhdCI6MTc3MjI5NzU5MSwiZXhwIjoxNzcyNTU2NzkxfQ.u9VyKaoRoOV_-YR6qFMzSQw-SfUJHa3f_F6ITd1Iu2o', '2026-02-28', '12:53:11', 0, '', 0),
(176, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjhUMTc6NTc6MzcuNzM4WiIsImlhdCI6MTc3MjMwMTQ1NywiZXhwIjoxNzcyNTYwNjU3fQ.VaG3Mwmj5VbeolSQPakH38HIkKnzSzAgCUlOmbCd5mw', '2026-02-28', '13:57:37', 0, '', 0),
(177, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDItMjhUMTc6NTk6MjMuMzc0WiIsImlhdCI6MTc3MjMwMTU2MywiZXhwIjoxNzcyNTYwNzYzfQ.2TPHglS-zGh8UR5GFZ9M8zcNvmpSDayVC00QxmHA6rk', '2026-02-28', '13:59:23', 0, '', 0),
(178, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjhUMTk6MDI6MDguMDE1WiIsImlhdCI6MTc3MjMwNTMyOCwiZXhwIjoxNzcyNTY0NTI4fQ._tT0yJz7e9Y9896CuT0PwHFDyYiAYsxDd-dk2GzrFgM', '2026-02-28', '15:02:08', 0, '', 0),
(179, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDItMjhUMTk6MDY6NTMuODAyWiIsImlhdCI6MTc3MjMwNTYxMywiZXhwIjoxNzcyNTY0ODEzfQ.ilEMTErCIUgPlqRO8oLYsiVYYsbZme33vkFFtiJKexE', '2026-02-28', '15:06:53', 0, '', 0),
(180, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDItMjhUMTk6MjA6NTIuODU3WiIsImlhdCI6MTc3MjMwNjQ1MiwiZXhwIjoxNzcyNTY1NjUyfQ.fCSKiwpmnuggL7MeAWOcnyHiI36GghzfD3UWoLJJFN0', '2026-02-28', '15:20:52', 0, '', 0),
(181, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDItMjhUMjA6NDE6MjQuODk3WiIsImlhdCI6MTc3MjMxMTI4NCwiZXhwIjoxNzcyNTcwNDg0fQ.Xjyb-tVcFWtqZMCulOKW_JZno2Fq0KUnmx6JvFBMKsc', '2026-02-28', '16:41:24', 0, '', 0),
(182, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDItMjhUMjA6NTU6MjAuMjkzWiIsImlhdCI6MTc3MjMxMjEyMCwiZXhwIjoxNzcyNTcxMzIwfQ.MSXAb0DsJGm5gy2RaDu_3Ndx_MO0rrsRfmdShk54EPQ', '2026-02-28', '16:55:20', 0, '', 0),
(183, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjhUMjA6NTc6NDcuNDQyWiIsImlhdCI6MTc3MjMxMjI2NywiZXhwIjoxNzcyNTcxNDY3fQ.waaEqt_WtEwQrWqOSk8G01289Eqwn1pkD6dSXA8lcrU', '2026-02-28', '16:57:47', 0, '', 0),
(184, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDItMjhUMjE6MDY6NTEuNDAxWiIsImlhdCI6MTc3MjMxMjgxMSwiZXhwIjoxNzcyNTcyMDExfQ.QU_YmQ6xOx_xRP7xZ16a3lI8Q8tAWvXIaKzKrIKE9fI', '2026-02-28', '17:06:51', 0, '', 0),
(185, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDItMjhUMjE6MTA6MDQuODUyWiIsImlhdCI6MTc3MjMxMzAwNCwiZXhwIjoxNzcyNTcyMjA0fQ.cYL3ffuozy6JrINGhV2EQYofza37xPxg7m4mqnN08ws', '2026-02-28', '17:10:04', 0, '', 0),
(186, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDItMjhUMjE6Mzc6NDQuMzY2WiIsImlhdCI6MTc3MjMxNDY2NCwiZXhwIjoxNzcyNTczODY0fQ.6mhIAC4oLbXvxnM4Vu9gstJfoPSYcpCO04VPfdpMUBI', '2026-02-28', '17:37:44', 0, '', 0),
(190, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDA6NDc6MDguMjU2WiIsImlhdCI6MTc3MjMyNjAyOCwiZXhwIjoxNzcyNTg1MjI4fQ.JzV2cvYoTjP3idyCf54XLiTCxzA0e1cklPkUFZ6NNrI', '2026-03-01', '20:47:08', 1, 'MAURITO', 0),
(196, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDA6NTI6MDIuOTc1WiIsImlhdCI6MTc3MjMyNjMyMiwiZXhwIjoxNzcyNTg1NTIyfQ.8IF4tESBb8TxCNk49x0xtCBZCnof1eZmPMnfM272cEo', '2026-03-01', '20:52:03', 1, 'MAURITO', 0),
(197, 6, 'erlinda', 'ERLINDA', 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRVJMSU5EQSIsInNlcnZpY2lvIjoiNzg2NTU0NDQiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDI6NDU6MzMuMDMyWiIsImlhdCI6MTc3MjMzMzEzMywiZXhwIjoxNzcyNTkyMzMzfQ.10fKS1WqEXRtwbxbKWddiZRpyKfMepC8GZXLBUjaAAk', '2026-03-01', '22:45:33', 1, 'MAURITO', 0),
(199, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDM6MjE6MDAuNjczWiIsImlhdCI6MTc3MjMzNTI2MCwiZXhwIjoxNzcyNTk0NDYwfQ.aNqpHHMRAO9q3W5qwgyKc-pazbnzXpcXPW6-E9IA02Q', '2026-03-01', '23:21:00', 1, 'MAURITO', 0),
(200, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDM6Mjg6MzUuMTQ0WiIsImlhdCI6MTc3MjMzNTcxNSwiZXhwIjoxNzcyNTk0OTE1fQ.a4nIDk0oI0yWdr0vYvGWPCDsfoGd7jlBPvdL_kkyiww', '2026-03-01', '23:28:35', 1, 'MAURITO', 0),
(201, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDM6MzA6NTYuNzY5WiIsImlhdCI6MTc3MjMzNTg1NiwiZXhwIjoxNzcyNTk1MDU2fQ.LfI4XrNvbQ0F0qR6eOLAKiNCZ0UxI3IUeewzQRUy8tc', '2026-03-01', '23:30:56', 1, 'MAURITO', 0),
(202, 8, 'alfredo', 'ALDREDO', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQUxEUkVETyIsInNlcnZpY2lvIjoiNzI4NzkxNTkiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDM6MzI6MzQuMzU5WiIsImlhdCI6MTc3MjMzNTk1NCwiZXhwIjoxNzcyNTk1MTU0fQ.Pqhs-7jXdyvA-gvRea9EA8S8XwGzSyqTHs1H-alZHMI', '2026-03-01', '23:32:34', 1, 'MAURITO', 0),
(203, 7, 'ramires', 'RAMIRES', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiUkFNSVJFUyIsInNlcnZpY2lvIjoiNzg3NTExMTAiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDM6Mzc6NDguNzQ5WiIsImlhdCI6MTc3MjMzNjI2OCwiZXhwIjoxNzcyNTk1NDY4fQ.3Fn5GnVZaR4BMwT2ZnOoaloCDwJBk_NLORSStYfyc-c', '2026-03-01', '23:37:48', 1, 'MAURITO', 0),
(204, 7, 'ramires', 'RAMIRES', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiUkFNSVJFUyIsInNlcnZpY2lvIjoiNzg3NTExMTAiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDM6NTQ6NTcuMTg4WiIsImlhdCI6MTc3MjMzNzI5NywiZXhwIjoxNzcyNTk2NDk3fQ.gAzR7vDgkhyMWp24mxO-VcPUU9eM7OE1S5IOpbJ-Qk8', '2026-03-01', '23:54:57', 1, 'MAURITO', 0),
(205, 7, 'ramires', 'RAMIRES', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiUkFNSVJFUyIsInNlcnZpY2lvIjoiNzg3NTExMTAiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDQ6MDU6MDUuMjAwWiIsImlhdCI6MTc3MjMzNzkwNSwiZXhwIjoxNzcyNTk3MTA1fQ.ZJUkVM6eXKNLy2L0Z-VoiHjOKAVHaDDY_ttvmGrdInU', '2026-03-01', '00:05:05', 1, 'MAURITO', 0),
(206, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDFUMDQ6MTM6NDAuOTE3WiIsImlhdCI6MTc3MjMzODQyMCwiZXhwIjoxNzcyNTk3NjIwfQ.3DTuCTfpek9PX8U8_ndVssSiePcu9V-S_IdXdQgq0iQ', '2026-03-01', '00:13:40', 1, 'MAURITO', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tipo_tramites`
--

CREATE TABLE `tipo_tramites` (
  `id` int(11) NOT NULL,
  `tipo_tramite` text NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `codigo` varchar(5) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tipo_tramites`
--

INSERT INTO `tipo_tramites` (`id`, `tipo_tramite`, `estado`, `codigo`, `id_entidad`, `usuario`, `created_at`, `updated_at`) VALUES
(1, 'JUDICIALES', 1, 'JUD', 1, 1, '2026-02-14 09:49:14', '2026-03-01 21:11:15'),
(2, 'ADMINISTRATIVOS', 1, 'ADM', 1, 1, '2026-02-14 09:50:04', '2026-03-01 21:10:54'),
(3, 'CAJA CHICA', 1, 'CCH', 1, 1, '2026-02-14 09:50:27', '2026-03-01 22:34:44'),
(5, 'CAJA CHICAS', 1, 'CCHS', 1, 1, '2026-03-01 22:32:48', '2026-03-01 00:14:04');

-- --------------------------------------------------------

--
-- Table structure for table `tramites`
--

CREATE TABLE `tramites` (
  `id` varchar(36) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `codigo` text NOT NULL,
  `fecha_ingreso` datetime NOT NULL,
  `fecha_finalizacion` datetime NOT NULL,
  `id_tipo_tramite` int(11) NOT NULL,
  `detalle` text NOT NULL,
  `costo` float NOT NULL,
  `otros` text NOT NULL,
  `estado` tinyint(4) NOT NULL COMMENT '1:en curso; 0: paralizado',
  `eliminado` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1:activo, 0:eliminado',
  `usuario` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `modified_at` datetime DEFAULT NULL,
  `id_entidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tramites`
--

INSERT INTO `tramites` (`id`, `id_cliente`, `codigo`, `fecha_ingreso`, `fecha_finalizacion`, `id_tipo_tramite`, `detalle`, `costo`, `otros`, `estado`, `eliminado`, `usuario`, `created_at`, `modified_at`, `id_entidad`) VALUES
('40b63697-0ff8-11f1-ac12-5254009cb4a4', 3, 'ADM-00000001', '2026-02-22 00:00:00', '2026-03-22 00:00:00', 2, 'ACTUALIZACION DE NOMBRE SEGIP', 5000, '', 1, 1, 1, '2026-02-22 10:10:33', NULL, 1),
('6e52d38c-151f-11f1-a199-5254009cb4a4', 3, 'ADM-000002', '2026-02-28 00:00:00', '2026-02-28 00:00:00', 2, 'PRUEBA DEL CAJERO MODIFICADO', 3000, '', 1, 1, 8, '2026-03-01 04:33:36', '2026-03-01 23:36:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ap1` varchar(100) NOT NULL,
  `ap2` varchar(100) DEFAULT NULL,
  `ci` text NOT NULL,
  `celular` varchar(20) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `estado` tinyint(1) DEFAULT 1,
  `usuario` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `ultimo_acceso` datetime DEFAULT NULL,
  `id_entidad` int(11) DEFAULT NULL,
  `all_permision` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `id_rol`, `nombre`, `ap1`, `ap2`, `ci`, `celular`, `direccion`, `username`, `password`, `estado`, `usuario`, `created_at`, `updated_at`, `ultimo_acceso`, `id_entidad`, `all_permision`) VALUES
(1, 1, 'farkman', 'farknan', NULL, '13616192', '71166513', 'juan', 'juan', '81dc9bdb52d04dc20036dbd8313ed055', 1, NULL, '2026-02-13 11:44:10', '2026-02-13 11:44:10', '2026-03-01 00:13:41', 1, 1),
(5, 4, 'ROLANDO', 'ORELLANA', '', '5568538', '78788596', 'CALLE LOS 123', 'rolando', '81dc9bdb52d04dc20036dbd8313ed055', 1, NULL, '2026-02-15 16:37:19', '2026-02-15 16:37:19', '2026-02-18 14:17:17', 1, 1),
(6, 4, 'ERLINDA', 'PANIAGUA', '', '433434', '78655444', 'CALLE LOS 123', 'erlinda', '81dc9bdb52d04dc20036dbd8313ed055', 1, NULL, '2026-02-15 16:38:43', '2026-02-15 16:38:43', '2026-03-01 22:45:33', 1, 1),
(7, 2, 'RAMIRES', 'RAMIRES', '', '5454577', '78751110', 'UYUNI 343', 'ramires', '81dc9bdb52d04dc20036dbd8313ed055', 1, NULL, '2026-02-18 22:12:02', '2026-02-18 22:12:02', '2026-03-01 00:05:05', 1, 1),
(8, 3, 'ALDREDO', 'FLORES', '', '8568468', '72879159', 'CLL. UYUNI N676', 'alfredo', '81dc9bdb52d04dc20036dbd8313ed055', 1, NULL, '2026-02-20 23:08:18', '2026-02-20 23:08:18', '2026-03-01 23:32:34', 1, 1),
(9, 1, 'PRUEBA', 'FLORES', 'OROPEZA', '85684682', '72879159', 'CLL. UYUNI N676', 'alfredo1', '81dc9bdb52d04dc20036dbd8313ed055', 1, 1, '2026-03-01 02:43:50', '2026-02-28 23:13:48', NULL, 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auditorias`
--
ALTER TABLE `auditorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `accion` (`accion`),
  ADD KEY `fecha` (`fecha`);

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `entidad`
--
ALTER TABLE `entidad`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingresos`
--
ALTER TABLE `ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tramite` (`id_tramite`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero` (`numero`);

--
-- Indexes for table `salidas`
--
ALTER TABLE `salidas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tramite` (`id_tramite`),
  ADD KEY `idx_usuario_solicita` (`usuario_solicita_id`),
  ADD KEY `idx_usuario_aprueba` (`usuario_aprueba_id`),
  ADD KEY `idx_usuario_despacha` (`usuario_despacha_id`);

--
-- Indexes for table `sesion`
--
ALTER TABLE `sesion`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipo_tramites`
--
ALTER TABLE `tipo_tramites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tramites`
--
ALTER TABLE `tramites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_tipo_tramite` (`id_tipo_tramite`),
  ADD KEY `fk_entidad_tramites` (`id_entidad`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `fk_entidad` (`id_entidad`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auditorias`
--
ALTER TABLE `auditorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `entidad`
--
ALTER TABLE `entidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sesion`
--
ALTER TABLE `sesion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=207;

--
-- AUTO_INCREMENT for table `tipo_tramites`
--
ALTER TABLE `tipo_tramites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ingresos`
--
ALTER TABLE `ingresos`
  ADD CONSTRAINT `ingresos_ibfk_2` FOREIGN KEY (`id_tramite`) REFERENCES `tramites` (`id`);

--
-- Constraints for table `salidas`
--
ALTER TABLE `salidas`
  ADD CONSTRAINT `salidas_ibfk_1` FOREIGN KEY (`id_tramite`) REFERENCES `tramites` (`id`),
  ADD CONSTRAINT `salidas_ibfk_2` FOREIGN KEY (`usuario_solicita_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `salidas_ibfk_3` FOREIGN KEY (`usuario_aprueba_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `salidas_ibfk_4` FOREIGN KEY (`usuario_despacha_id`) REFERENCES `usuarios` (`id`);

--
-- Constraints for table `tramites`
--
ALTER TABLE `tramites`
  ADD CONSTRAINT `fk_entidad_tramites` FOREIGN KEY (`id_entidad`) REFERENCES `entidad` (`id`),
  ADD CONSTRAINT `tramites_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `tramites_ibfk_2` FOREIGN KEY (`id_tipo_tramite`) REFERENCES `tipo_tramites` (`id`);

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_entidad` FOREIGN KEY (`id_entidad`) REFERENCES `entidad` (`id`),
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
