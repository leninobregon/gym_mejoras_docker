-- GYM MA DB - Docker Init
-- Estructura de base de datos

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `configuracion` (
  `id` int(11) NOT NULL DEFAULT 1,
  `nombre_gym` varchar(100) DEFAULT 'GYM MA DB',
  `moneda_nombre` varchar(50) DEFAULT 'Córdoba Nicaragüense',
  `moneda_iso` varchar(3) DEFAULT 'NIO',
  `moneda_simbolo` varchar(5) DEFAULT 'C$',
  `tipo_cambio_bcn` decimal(10,4) DEFAULT 36.6243,
  `ultima_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `direccion_gym` text DEFAULT NULL,
  `telefono_gym` varchar(20) DEFAULT NULL,
  `logo_ruta` varchar(255) DEFAULT 'logo_default.png',
  `tema` varchar(20) DEFAULT 'default'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `usuario` varchar(50) NOT NULL UNIQUE,
  `cedula` varchar(20) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `two_factor_pin` varchar(10) DEFAULT NULL,
  `two_factor_enabled` tinyint(1) DEFAULT 0,
  `telefono` varchar(20) DEFAULT NULL,
  `rol` enum('ADMIN','CAJA') NOT NULL DEFAULT 'CAJA',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `planes` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre_plan` varchar(100) NOT NULL,
  `duracion_dias` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT 'ACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `socios` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `cedula` varchar(20) DEFAULT NULL,
  `edad` int(3) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `enfermedad` text DEFAULT NULL,
  `fecha_ingreso` date NOT NULL,
  `emergencia_contacto` varchar(100) DEFAULT NULL,
  `foto_ruta` varchar(255) DEFAULT 'default.png',
  `estado` enum('ACTIVO','INACTIVO','DEUDOR') DEFAULT 'ACTIVO',
  `fecha_vencimiento` date DEFAULT NULL,
  `fecha_renovacion` date DEFAULT NULL,
  `id_plan` int(11) DEFAULT NULL,
  KEY `fk_socio_plan` (`id_plan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `cajas` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_usuario` int(11) NOT NULL,
  `fecha_apertura` datetime DEFAULT current_timestamp(),
  `fecha_cierre` datetime DEFAULT NULL,
  `monto_apertura` decimal(10,2) NOT NULL,
  `monto_apertura_usd` decimal(10,2) DEFAULT 0.00,
  `monto_cierre` decimal(10,2) DEFAULT 0.00,
  `monto_cierre_usd` decimal(10,2) DEFAULT 0.00,
  `monto_esperado` decimal(10,2) DEFAULT 0.00,
  `estado` enum('ABIERTA','CERRADA') DEFAULT 'ABIERTA',
  `tasa_apertura` decimal(10,4) DEFAULT 36.6243,
  `nota` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ventas` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_usuario` int(11) NOT NULL,
  `id_caja` int(11) DEFAULT NULL,
  `id_socio` int(11) DEFAULT NULL,
  `monto_total` decimal(10,2) NOT NULL,
  `tasa_cambio_momento` decimal(10,4) DEFAULT 36.6243,
  `moneda_original` varchar(3) DEFAULT 'NIO',
  `concepto` varchar(255) NOT NULL,
  `cantidad` int(11) DEFAULT 1,
  `tipo_item` enum('PLAN','PRODUCTO') NOT NULL,
  `id_item_referencia` int(11) DEFAULT NULL,
  `cantidad_item` int(11) DEFAULT 1,
  `metodo_pago` enum('EFECTIVO','TRANSFERENCIA') DEFAULT 'EFECTIVO',
  `fecha_venta` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` varchar(20) DEFAULT 'COMPLETADO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `inventario` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `descripcion` varchar(150) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `caja_egresos` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `descripcion` varchar(255) NOT NULL,
  `monto_salida` decimal(10,2) NOT NULL,
  `fecha_egreso` datetime DEFAULT current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  `categoria` varchar(50) DEFAULT 'GENERAL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insertar datos iniciales
INSERT INTO configuracion (id, nombre_gym, moneda_nombre, moneda_iso, moneda_simbolo, tipo_cambio_bcn, direccion_gym, telefono_gym, tema) 
VALUES (1, 'GIMNASIO SPARTANS', 'Córdoba Nicaragüense', 'NIO', 'C$', 36.6243, 'Managua, Nicaragua', '88888888', 'default');

INSERT INTO usuarios (nombre, apellido, usuario, cedula, password, telefono, rol) 
VALUES ('Admin', 'General', 'admin', '001-000000-0000A', '$2y$10$AdGxvloNGYnjjj55Dnpli.edXvnGs5R6OgAjvoOzQ5VdW/91PX7PW', '88888888', 'ADMIN');

INSERT INTO planes (nombre_plan, duracion_dias, precio, estado) 
VALUES ('Mensualidad', 30, 300.00, 'ACTIVO');