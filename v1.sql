-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-aguilar.alwaysdata.net
-- Generation Time: Mar 03, 2026 at 03:26 AM
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
(158, 11, 'tramites', 'UPDATE', '{\"id\":\"a726a1de-15d6-11f1-a199-5254009cb4a4\",\"id_cliente\":5,\"fecha_ingreso\":\"2026-03-01\",\"fecha_finalizacion\":\"2026-05-31\",\"id_tipo_tramite\":5,\"detalle\":\"CAJA FAU\",\"costo\":1000000,\"otros\":\"TRABAJOS COSECHA DE FRAMBUESA, DESPASTE Y OTROS\",\"estado\":1,\"usuario\":11,\"id_entidadS\":1,\"modified_at\":\"2026-03-02 21:27:41\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"https://igfinanzas.netlify.app/\",\"idioma\":\"es-ES\",\"resolucion\":\"393x873\",\"vistas_previas\":2,\"user_timezone\":\"America/Santiago\"}', '2026-03-02 20:27:41'),
(159, 11, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"ef0670cd-15d6-11f1-a199-5254009cb4a4\",\"monto\":40000,\"tipo\":\"EFECTIVO\",\"detalle\":\"PAGO DE COSECHA DE FRAMBUESA 45 KILOS X 13 CAJAS,\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"https://igfinanzas.netlify.app/\",\"idioma\":\"es-ES\",\"resolucion\":\"393x873\",\"vistas_previas\":2,\"user_timezone\":\"America/Santiago\"}', '2026-03-02 00:37:26'),
(160, 10, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"a726a1de-15d6-11f1-a199-5254009cb4a4\",\"monto\":40000,\"tipo\":\"EFECTIVO\",\"detalle\":\"COSECHA DE FRAMBUESA DE 43.40 REJILLAS 14\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"https://igfinanzas.netlify.app/\",\"idioma\":\"es-ES\",\"resolucion\":\"393x873\",\"vistas_previas\":1,\"user_timezone\":\"America/Santiago\"}', '2026-03-02 00:40:26'),
(161, 10, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"a726a1de-15d6-11f1-a199-5254009cb4a4\",\"monto\":2500,\"detalle\":\"COMPRA DE 1 LITRO DE ACEITE\",\"usuario_solicita_id\":10,\"fecha_solicitud\":\"2026-03-01 21:44:10\",\"created_at\":\"2026-03-02 21:44:10\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"https://igfinanzas.netlify.app/\",\"idioma\":\"es-ES\",\"resolucion\":\"393x873\",\"vistas_previas\":1,\"user_timezone\":\"America/Santiago\"}', '2026-03-02 20:44:10'),
(162, 1, 'tramites', 'Caja eliminado', '{\"id\":\"ef0670cd-15d6-11f1-a199-5254009cb4a4\",\"estado\":0,\"usuario\":1,\"fecha_\":\"2026-03-02 21:50:39\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"https://igfinanzas.netlify.app/\",\"idioma\":\"es-ES\",\"resolucion\":\"393x873\",\"vistas_previas\":2,\"user_timezone\":\"America/Santiago\"}', '2026-03-02 20:50:39'),
(163, 1, 'tramites', 'Caja eliminado', '{\"id\":\"a726a1de-15d6-11f1-a199-5254009cb4a4\",\"estado\":0,\"usuario\":1,\"fecha_\":\"2026-03-02 21:50:46\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"https://igfinanzas.netlify.app/\",\"idioma\":\"es-ES\",\"resolucion\":\"393x873\",\"vistas_previas\":2,\"user_timezone\":\"America/Santiago\"}', '2026-03-02 20:50:46'),
(164, 1, 'tramites', 'Caja eliminado', '{\"id\":\"ef0670cd-15d6-11f1-a199-5254009cb4a4\",\"estado\":0,\"usuario\":1,\"fecha_\":\"2026-03-02 21:57:04\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 20:57:04'),
(165, 11, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"5f135ef6-15d8-11f1-a199-5254009cb4a4\",\"monto\":60000,\"tipo\":\"EFECTIVO\",\"fecha_ingreso\":\"2026-02-28\",\"detalle\":\"INGRESO ANTERIOR\",\"updated_at\":\"2026-03-02T02:04:37.685Z\",\"usuario\":11}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"https://igfinanzas.netlify.app/\",\"idioma\":\"es-ES\",\"resolucion\":\"393x873\",\"vistas_previas\":38,\"user_timezone\":\"America/Santiago\"}', '2026-03-02 01:04:37'),
(166, 10, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"c9987622-15d8-11f1-a199-5254009cb4a4\",\"monto\":444650,\"tipo\":\"EFECTIVO\",\"fecha_ingreso\":\"2026-02-28\",\"detalle\":\"INGRESO ANTERIOR\",\"updated_at\":\"2026-03-02T02:08:27.386Z\",\"usuario\":10}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 0.0.0\",\"dispositivo\":\"Generic Smartphone\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"https://igfinanzas.netlify.app/\",\"idioma\":\"es-ES\",\"resolucion\":\"393x873\",\"vistas_previas\":1,\"user_timezone\":\"America/Santiago\"}', '2026-03-02 01:08:27'),
(167, 1, 'tramites', 'UPDATE', '{\"id\":\"ef0670cd-15d6-11f1-a199-5254009cb4a4\",\"id_cliente\":6,\"fecha_ingreso\":\"2026-03-01\",\"fecha_finalizacion\":\"2026-05-31\",\"id_tipo_tramite\":5,\"detalle\":\"CAJA GUSTAVO\",\"costo\":1000000,\"otros\":\"\",\"estado\":1,\"usuario\":1,\"id_entidadS\":1,\"modified_at\":\"2026-03-02 22:23:44\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 21:23:44'),
(168, 1, 'tramites', 'UPDATE', '{\"id\":\"a726a1de-15d6-11f1-a199-5254009cb4a4\",\"id_cliente\":6,\"fecha_ingreso\":\"2026-03-01\",\"fecha_finalizacion\":\"2026-05-31\",\"id_tipo_tramite\":5,\"detalle\":\"CAJA FAU\",\"costo\":1000000,\"otros\":\"TRABAJOS COSECHA DE FRAMBUESA, DESPASTE Y OTROS\",\"estado\":1,\"usuario\":1,\"id_entidadS\":1,\"modified_at\":\"2026-03-02 22:23:54\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"186.41.154.205\",\"pais\":\"CL\",\"ciudad\":\"\",\"timezone\":\"America/Santiago\",\"coords\":[-33.439,-70.6432],\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":7,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 21:23:54'),
(169, 11, 'tramites', 'Caja eliminado', '{\"id\":\"a726a1de-15d6-11f1-a199-5254009cb4a4\",\"estado\":0,\"usuario\":11,\"fecha_\":\"2026-03-02 22:28:54\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":19,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 21:28:54'),
(170, 11, 'tramites', 'Caja activado', '{\"id\":\"a726a1de-15d6-11f1-a199-5254009cb4a4\",\"estado\":1,\"usuario\":11,\"fecha_\":\"2026-03-02 22:30:16\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":24,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 21:30:16'),
(171, 11, 'tramites', 'Caja eliminado', '{\"id\":\"ef0670cd-15d6-11f1-a199-5254009cb4a4\",\"estado\":0,\"usuario\":11,\"fecha_\":\"2026-03-02 22:31:57\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":24,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 21:31:57'),
(172, 11, 'tramites', 'UPDATE', '{\"id\":\"a726a1de-15d6-11f1-a199-5254009cb4a4\",\"fecha_ingreso\":\"2026-03-01\",\"fecha_finalizacion\":\"2026-05-31\",\"id_tipo_tramite\":5,\"detalle\":\"CAJA FAU\",\"costo\":1000000,\"otros\":\"TRABAJOS COSECHA DE FRAMBUESA, DESPASTE Y OTROS\",\"estado\":1,\"usuario\":11,\"id_entidadS\":1,\"modified_at\":\"2026-03-02 09:21:30\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"630x921\",\"vistas_previas\":9,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 08:21:30'),
(173, 11, 'tramites', 'Caja eliminado', '{\"id\":\"128e32a1-163b-11f1-a199-5254009cb4a4\",\"estado\":0,\"usuario\":11,\"fecha_\":\"2026-03-02 09:24:59\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"630x921\",\"vistas_previas\":9,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 08:24:59'),
(174, 11, 'tramites', 'Caja activado', '{\"id\":\"128e32a1-163b-11f1-a199-5254009cb4a4\",\"estado\":1,\"usuario\":11,\"fecha_\":\"2026-03-02 09:25:11\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"630x921\",\"vistas_previas\":9,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 08:25:11'),
(175, 11, 'tramites', 'Caja activado', '{\"id\":\"ef0670cd-15d6-11f1-a199-5254009cb4a4\",\"estado\":1,\"usuario\":11,\"fecha_\":\"2026-03-02 09:25:20\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/tramites/eliminar-logica\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"630x921\",\"vistas_previas\":9,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 08:25:20'),
(176, 11, 'ingresos', 'CREAR INGRESO', '{\"id_tramite\":\"128e32a1-163b-11f1-a199-5254009cb4a4\",\"monto\":50000,\"tipo\":\"EFECTIVO\",\"detalle\":\"PAGODE COSECHA\"}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"630x921\",\"vistas_previas\":20,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 12:34:05'),
(177, 11, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"7d0fa8ac-163c-11f1-a199-5254009cb4a4\",\"monto\":50000,\"tipo\":\"EFECTIVO\",\"fecha_ingreso\":\"2026-03-01\",\"detalle\":\"PAGODE COSECHA\",\"updated_at\":\"2026-03-02T13:34:36.730Z\",\"usuario\":11}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"630x921\",\"vistas_previas\":22,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 12:34:36'),
(178, 11, 'ingresos', 'ACTUALIZAR INGRESO', '{\"id\":\"7d0fa8ac-163c-11f1-a199-5254009cb4a4\",\"monto\":50000,\"tipo\":\"EFECTIVO\",\"fecha_ingreso\":\"2026-03-01\",\"detalle\":\"PAGODE COSECHAFFFF\",\"updated_at\":\"2026-03-02T13:34:45.318Z\",\"usuario\":11}', '{\"navegador\":\"Chrome Mobile\",\"version\":\"145.0.0\",\"os\":\"Android 6.0.0\",\"dispositivo\":\"Nexus 5\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/ingresos-cajero/actualizar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"630x921\",\"vistas_previas\":22,\"user_timezone\":\"America/La_Paz\"}', '2026-03-02 12:34:45'),
(179, 11, 'salidas', 'CREAR SALIDA', '{\"id_tramite\":\"128e32a1-163b-11f1-a199-5254009cb4a4\",\"monto\":700,\"detalle\":\"SALIDA, EJEMPLO\",\"usuario_solicita_id\":11,\"fecha_solicitud\":\"2026-03-02 22:11:04\",\"created_at\":\"2026-03-03 22:11:04\",\"nuevo_estado\":1}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/crear\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":16,\"user_timezone\":\"America/La_Paz\"}', '2026-03-03 21:11:04'),
(180, 11, 'salidas', 'UPDATE SALIDA', '{\"id\":\"3e5bf843-16a6-11f1-a199-5254009cb4a4\",\"monto\":70000,\"detalle\":\"SALIDA, EJEMPLO\",\"fecha_solicitud\":\"2026-03-03 22:11:24\",\"updated_at\":\"2026-03-03 22:11:24\"}', '{\"navegador\":\"Chrome\",\"version\":\"145.0.0\",\"os\":\"Windows 10.0.0\",\"dispositivo\":\"Other\",\"ip\":\"127.0.0.1\",\"pais\":\"Desconocido\",\"ciudad\":\"Desconocido\",\"timezone\":\"UTC\",\"coords\":null,\"url_peticion\":\"/salidas/editar\",\"metodo\":\"POST\",\"origen\":\"http://localhost:5173/\",\"idioma\":\"es\",\"resolucion\":\"1536x864\",\"vistas_previas\":16,\"user_timezone\":\"America/La_Paz\"}', '2026-03-03 21:11:24');

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
(4, 'WILDO ', 'SAZO', '', '13616192014', '56961714183', 'EL CARMEN S/N', 1, '2026-03-02 21:22:43', NULL, 11),
(5, 'JUAN', 'SAZO', '', '13616192013', '56984846274', 'EL CARMEN S/N', 1, '2026-03-02 21:23:20', NULL, 11),
(6, 'VARIOS', 'VARIOS', '', '0000000', '00000000', 'EMPLEADOR S/D', 1, '2026-03-02 22:23:09', NULL, 1);

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
  `updated_at` datetime DEFAULT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingresos`
--

INSERT INTO `ingresos` (`id`, `id_tramite`, `numero`, `monto`, `tipo`, `fecha_ingreso`, `detalle`, `usuario`, `created_at`, `updated_at`, `id_cliente`) VALUES
('5f135ef6-15d8-11f1-a199-5254009cb4a4', 'ef0670cd-15d6-11f1-a199-5254009cb4a4', 1, 60000, 'EFECTIVO', '2026-02-28 00:00:00', 'INGRESO ANTERIOR', 11, '2026-03-02 01:37:26', '2026-03-02 02:04:37', 4),
('7d0fa8ac-163c-11f1-a199-5254009cb4a4', '128e32a1-163b-11f1-a199-5254009cb4a4', 1, 50000, 'EFECTIVO', '2026-03-01 00:00:00', 'PAGODE COSECHAFFFF', 11, '2026-03-02 13:34:05', '2026-03-02 13:34:45', 5),
('c9987622-15d8-11f1-a199-5254009cb4a4', 'a726a1de-15d6-11f1-a199-5254009cb4a4', 1, 444650, 'EFECTIVO', '2026-02-28 00:00:00', 'INGRESO ANTERIOR', 10, '2026-03-02 01:40:26', '2026-03-02 02:08:27', 4);

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
('3e5bf843-16a6-11f1-a199-5254009cb4a4', 1, '128e32a1-163b-11f1-a199-5254009cb4a4', 3, 70000.00, 'SALIDA, EJEMPLO', 11, '2026-03-03 22:11:24', NULL, NULL, NULL, NULL, '2026-03-02 22:11:04', '2026-03-03 22:11:24'),
('4f19a062-15d9-11f1-a199-5254009cb4a4', 1, 'a726a1de-15d6-11f1-a199-5254009cb4a4', 3, 2500.00, 'COMPRA DE 1 LITRO DE ACEITE', 10, '2026-03-01 21:44:10', NULL, NULL, NULL, NULL, '2026-03-01 21:44:10', NULL);

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
(209, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDJUMDE6MTQ6MzMuMjA1WiIsImlhdCI6MTc3MjQxNDA3MywiZXhwIjoxNzcyNjczMjczfQ.Zsq-Mjr0DCUWWoNCbGCxWi-ckT3hViwV9dNl-kgtMAA', '2026-03-02', '21:14:33', 1, 'MAURITO', 0),
(210, 10, 'fanny', 'FANNY', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRkFOTlkiLCJzZXJ2aWNpbyI6IjY3NjI3MTg0IiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAxOjE4OjU4LjA3NVoiLCJpYXQiOjE3NzI0MTQzMzgsImV4cCI6MTc3MjY3MzUzOH0.p-0AYyHqrfD8IRdc8OU4sxhd-nEiJWLOt0BlK-uVlpw', '2026-03-02', '21:18:58', 1, 'MAURITO', 0),
(211, 11, 'gustavo', 'GUSTAVO ', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAxOjE5OjIxLjI0N1oiLCJpYXQiOjE3NzI0MTQzNjEsImV4cCI6MTc3MjY3MzU2MX0.FsVsIgdPqgrG2sI1RBjugYQFFMjWeSBro-wDMaHD7uI', '2026-03-02', '21:19:21', 1, 'MAURITO', 0),
(212, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDJUMDE6MjA6MTEuNjU1WiIsImlhdCI6MTc3MjQxNDQxMSwiZXhwIjoxNzcyNjczNjExfQ.m2EejZXKPBKICE7GMcL5YycDiTLLLjd-N3MSrTaKk_k', '2026-03-02', '21:20:11', 1, 'MAURITO', 0),
(213, 11, 'gustavo', 'GUSTAVO ', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAxOjIxOjE2LjE4M1oiLCJpYXQiOjE3NzI0MTQ0NzYsImV4cCI6MTc3MjY3MzY3Nn0.5oeIpZosI0x173HD2tlwbY0i7n_QgLhli7X7UgyXK74', '2026-03-02', '21:21:16', 1, 'MAURITO', 0),
(214, 11, 'gustavo', 'GUSTAVO ', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAxOjI4OjA0LjkxM1oiLCJpYXQiOjE3NzI0MTQ4ODQsImV4cCI6MTc3MjY3NDA4NH0.IWB74SwYD5HOpcVgf5hJ-sob4_CLLxzXs47219iANdM', '2026-03-02', '21:28:04', 1, 'MAURITO', 0),
(215, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDJUMDE6MzM6MzIuNTI1WiIsImlhdCI6MTc3MjQxNTIxMiwiZXhwIjoxNzcyNjc0NDEyfQ.FGgMZSG2wwXspbt4d2mby5ZNTqrpXW_EBv3XqF7zuGk', '2026-03-02', '21:33:32', 1, 'MAURITO', 0),
(216, 11, 'gustavo', 'GUSTAVO ', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAxOjM0OjE4LjQ3NVoiLCJpYXQiOjE3NzI0MTUyNTgsImV4cCI6MTc3MjY3NDQ1OH0.lya2oFwmsDpVc_EFXe0JCZQ3cKHFri4lNtSANoUckoU', '2026-03-02', '21:34:18', 1, 'MAURITO', 0),
(217, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDJUMDE6NDk6NDYuNzMwWiIsImlhdCI6MTc3MjQxNjE4NiwiZXhwIjoxNzcyNjc1Mzg2fQ.nHoBLMmSw3QZnnz3z1t4WsIBy1QBWc0sq8d390m5wbI', '2026-03-02', '21:49:46', 1, 'MAURITO', 0),
(218, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDJUMDE6NTQ6MDEuNzE5WiIsImlhdCI6MTc3MjQxNjQ0MSwiZXhwIjoxNzcyNjc1NjQxfQ.76OWWRxZQ4MDRye41_mwlI_Zl9vfY6KZj-l09IcoAnU', '2026-03-02', '21:54:01', 1, 'MAURITO', 0),
(219, 11, 'gustavo', 'GUSTAVO ', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAyOjAyOjE0LjEwOFoiLCJpYXQiOjE3NzI0MTY5MzQsImV4cCI6MTc3MjY3NjEzNH0.3RQ9cSFXQlG8R3B4Gw_NRrZPYDOay1oW-6uNXHnJ3sc', '2026-03-02', '22:02:14', 1, 'MAURITO', 0),
(220, 11, 'gustavo', 'GUSTAVO ', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAyOjExOjQ0LjYzOVoiLCJpYXQiOjE3NzI0MTc1MDQsImV4cCI6MTc3MjY3NjcwNH0.19kXAJiMz8iv0tsxeLhUEx0lnQXZwcU24brq7FjOXEA', '2026-03-02', '22:11:44', 1, 'MAURITO', 0),
(221, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDJUMDI6MTI6MzcuMDM1WiIsImlhdCI6MTc3MjQxNzU1NywiZXhwIjoxNzcyNjc2NzU3fQ.tmX3YUc2tR0wmaSubvmXG045n45at8eEMUg1veCXGmw', '2026-03-02', '22:12:37', 1, 'MAURITO', 0),
(222, 11, 'gustavo', 'GUSTAVO ', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAyOjE3OjMxLjMwOVoiLCJpYXQiOjE3NzI0MTc4NTEsImV4cCI6MTc3MjY3NzA1MX0.ZpTdYiS9sJBBPUaZinpseorKsrr6Lx3aJC1VcqLRSF0', '2026-03-02', '22:17:31', 1, 'MAURITO', 0),
(223, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDJUMDI6MTg6MzQuMDE4WiIsImlhdCI6MTc3MjQxNzkxNCwiZXhwIjoxNzcyNjc3MTE0fQ.fjsSAd2_frzuw6XgxmLzpJl03pzsVlvmTAndqgX7wd4', '2026-03-02', '22:18:34', 1, 'MAURITO', 0),
(224, 11, 'gustavo', 'GUSTAVO ', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAyOjI2OjU5LjI3NFoiLCJpYXQiOjE3NzI0MTg0MTksImV4cCI6MTc3MjY3NzYxOX0.sthZKl0jA0xb88_N6zJB6gMjBwKEjskffWK7QbQEx-k', '2026-03-02', '22:26:59', 1, 'MAURITO', 0),
(225, 10, 'fanny', 'FANNY', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRkFOTlkiLCJzZXJ2aWNpbyI6IjY3NjI3MTg0IiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAyOjI3OjI4Ljk3NloiLCJpYXQiOjE3NzI0MTg0NDgsImV4cCI6MTc3MjY3NzY0OH0.1-zviRvyRwW_3vfskurY1ufrBsbF0R1lww-uRN8srfk', '2026-03-02', '22:27:28', 1, 'MAURITO', 0),
(226, 11, 'gustavo', 'GUSTAVO ', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAyOjI4OjAzLjQxNloiLCJpYXQiOjE3NzI0MTg0ODMsImV4cCI6MTc3MjY3NzY4M30.OWBiYKLiacx2EQgwPtZEMp8Ais047_f4wRRzwXTZhhA', '2026-03-02', '22:28:03', 1, 'MAURITO', 0),
(227, 11, 'gustavo', 'GUSTAVO ', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDAyOjI4OjA0LjIzNFoiLCJpYXQiOjE3NzI0MTg0ODQsImV4cCI6MTc3MjY3NzY4NH0.qWmvw8jlWboq65IbZhmxEzDLP8U-MLyIhouEBzJdgLY', '2026-03-02', '22:28:04', 1, 'MAURITO', 0),
(228, 11, 'gustavo', 'GUSTAVO ', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDEzOjI2OjE5LjMwM1oiLCJpYXQiOjE3NzI0NTc5NzksImV4cCI6MTc3MjcxNzE3OX0.h33moWuHAy_M1hqX3r2DD2RaP5eWTHY7_hEXFWmS_TE', '2026-03-02', '09:26:19', 1, 'MAURITO', 0),
(229, 1, 'juan', 'farkman', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZmFya21hbiIsInNlcnZpY2lvIjoiNzExNjY1MTMiLCJmZWNoYSI6IjIwMjYtMDMtMDJUMTM6Mjk6NTEuODM1WiIsImlhdCI6MTc3MjQ1ODE5MSwiZXhwIjoxNzcyNzE3MzkxfQ.2yHpEN9i7uRcEcfeBsnE_OmaVGwgn6gOvgsLKfRp8uw', '2026-03-02', '09:29:51', 1, 'MAURITO', 0),
(230, 11, 'gustavo', 'GUSTAVO ', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiR1VTVEFWTyAiLCJzZXJ2aWNpbyI6IjcxMTY2NTEzIiwiZmVjaGEiOiIyMDI2LTAzLTAyVDEzOjMwOjI1LjE5OVoiLCJpYXQiOjE3NzI0NTgyMjUsImV4cCI6MTc3MjcxNzQyNX0.VTnK_3wAbwPa-i0QdmW5vyl1dW6yJ3ZSXi6jnMu-Wao', '2026-03-02', '09:30:25', 1, 'MAURITO', 0);

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
(5, 'TRABAJOS CHILE', 1, 'TRBCL', 1, 1, '2026-03-01 22:32:48', '2026-03-02 21:21:04');

-- --------------------------------------------------------

--
-- Table structure for table `tramites`
--

CREATE TABLE `tramites` (
  `id` varchar(36) NOT NULL,
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

INSERT INTO `tramites` (`id`, `codigo`, `fecha_ingreso`, `fecha_finalizacion`, `id_tipo_tramite`, `detalle`, `costo`, `otros`, `estado`, `eliminado`, `usuario`, `created_at`, `modified_at`, `id_entidad`) VALUES
('128e32a1-163b-11f1-a199-5254009cb4a4', 'TRBCL-000003', '2026-03-01 00:00:00', '2026-03-29 00:00:00', 5, 'CAJA PRUEBA', 1000000, '', 1, 1, 11, '2026-03-02 14:23:59', '2026-03-02 09:25:11', 1),
('a726a1de-15d6-11f1-a199-5254009cb4a4', 'TRBCL-000001', '2026-03-01 00:00:00', '2026-05-31 00:00:00', 5, 'CAJA FAU', 1000000, 'TRABAJOS COSECHA DE FRAMBUESA, DESPASTE Y OTROS', 1, 1, 11, '2026-03-02 02:25:09', '2026-03-02 09:21:30', 1),
('ef0670cd-15d6-11f1-a199-5254009cb4a4', 'TRBCL-000002', '2026-03-01 00:00:00', '2026-05-31 00:00:00', 5, 'CAJA GUSTAVO', 1000000, '', 1, 1, 11, '2026-03-02 02:27:10', '2026-03-02 09:25:20', 1);

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
(1, 1, 'farkman', 'farknan', NULL, '13616192', '71166513', 'juan', 'juan', '81dc9bdb52d04dc20036dbd8313ed055', 1, NULL, '2026-02-13 11:44:10', '2026-02-13 11:44:10', '2026-03-02 09:29:52', 1, 1),
(10, 3, 'FANNY', 'MORALES', 'PUMA', '12612322', '67627184', 'EL CARMEN S/N', 'fanny', '25d55ad283aa400af464c76d713c07ad', 1, NULL, '2026-03-02 01:16:33', '2026-03-02 01:16:33', '2026-03-02 22:27:29', 1, 1),
(11, 3, 'GUSTAVO ', 'AGUILAR ', 'TORRES', '13616192-1G', '71166513', 'EL CARMEN POB LAS ROSAS ', 'gustavo', '3c6dd1f8f4f4da81a08e75db3f4ba0e9', 1, 1, '2026-03-02 01:18:14', '2026-03-02 08:30:07', '2026-03-02 09:30:25', 1, 1);

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
  ADD KEY `id_tramite` (`id_tramite`),
  ADD KEY `fk_cliente00` (`id_cliente`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `entidad`
--
ALTER TABLE `entidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sesion`
--
ALTER TABLE `sesion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=231;

--
-- AUTO_INCREMENT for table `tipo_tramites`
--
ALTER TABLE `tipo_tramites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ingresos`
--
ALTER TABLE `ingresos`
  ADD CONSTRAINT `fk_cliente00` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`),
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
