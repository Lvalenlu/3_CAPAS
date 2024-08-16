-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-08-2024 a las 06:28:34
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `vintagestore`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_usuarios`
--

CREATE TABLE `auditoria_usuarios` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `cedula` varchar(20) DEFAULT NULL,
  `ciudad` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contrasena` varchar(255) DEFAULT NULL,
  `rol` varchar(50) DEFAULT NULL,
  `fecha_modificacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `tipo_cambio` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auditoria_usuarios`
--

INSERT INTO `auditoria_usuarios` (`id`, `usuario_id`, `nombre`, `cedula`, `ciudad`, `email`, `contrasena`, `rol`, `fecha_modificacion`, `tipo_cambio`) VALUES
(5, 12, 'Juliana', '2147483647', 'Ibague', 'juli@gmail.com', '8465415165*', '2', '2024-08-15 17:17:51', 'D'),
(7, 14, 'Juliana', '2147483647', 'Ibague', 'juli@gmail.com', '12345677*', '2', '2024-08-15 17:23:38', 'I'),
(8, 14, 'Juliana', '2147483647', 'Ibague', 'juli@gmail.com', '12345677*', '2', '2024-08-15 17:23:45', 'D'),
(9, 15, 'Juliana', '2147483647', 'Ibague', 'juli@gmail.com', '12345678*', '1', '2024-08-15 17:24:37', 'I'),
(10, 15, 'Juliana Pineda', '2147483647', 'Bogota', 'julipineda@gmail.com', '12345678*', '2', '2024-08-15 17:25:39', 'U'),
(11, 15, 'Juliana Pineda', '2147483647', 'Bogota', 'julipineda@gmail.com', '12345678*', '2', '2024-08-15 17:25:47', 'D');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devoluciones`
--

CREATE TABLE `devoluciones` (
  `id` int(11) NOT NULL,
  `observacion` varchar(40) NOT NULL,
  `fechaDevolucion` varchar(40) NOT NULL,
  `idOrden` int(11) DEFAULT NULL,
  `idComprador` int(11) DEFAULT NULL,
  `idEstado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `id` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodopago`
--

CREATE TABLE `metodopago` (
  `id` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden`
--

CREATE TABLE `orden` (
  `id` int(11) NOT NULL,
  `fechaventa` date NOT NULL,
  `idProducto` int(11) DEFAULT NULL,
  `idComprador` int(11) DEFAULT NULL,
  `idMetodoPago` int(11) DEFAULT NULL,
  `idEstado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `precio` double NOT NULL,
  `color` varchar(20) NOT NULL,
  `talla` varchar(9) NOT NULL,
  `descripcion` text NOT NULL,
  `idVendedor` int(11) DEFAULT NULL,
  `idCategoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `cedula` int(11) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `contrasena` varchar(30) NOT NULL,
  `rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `cedula`, `ciudad`, `email`, `contrasena`, `rol`) VALUES
(1, 'Andres', 516156146, 'Medellin', 'andres@gmail.com', '123454549328*', 2),
(2, 'Laura Bustos ', 2147483647, 'Bogota', 'lvalenlu02@gmail.com', '12345678*', 1),
(3, 'Luna Perez', 1835467893, 'Bogota', 'vale@gmail.com', 'nuevaaaaa123', 2),
(4, 'Ana Herrera', 535467891, 'Tolima', 'ana@gmail.com', '55121654566*', 1),
(5, 'Luisa Buitrago', 1835467891, 'Cali', 'lu@gmail.com', 'nuevaaa123*', 1),
(6, 'Kevin', 1335467891, 'Medellin', 'kevin@gmail.com', '456923u37131*', 1);

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `before_delete_user` BEFORE DELETE ON `usuario` FOR EACH ROW BEGIN
    INSERT INTO auditoria_usuarios (usuario_id,nombre, cedula, ciudad, email, contrasena, rol, fecha_modificacion, tipo_cambio)
    VALUES (OLD.id, OLD.nombre, OLD.cedula, OLD.ciudad, OLD.email, OLD.contrasena, OLD.rol, NOW(), 'D');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_uid_insert_user` AFTER INSERT ON `usuario` FOR EACH ROW BEGIN
    INSERT INTO auditoria_usuarios (usuario_id,nombre, cedula, ciudad, email, contrasena, rol, fecha_modificacion, tipo_cambio)
    VALUES (NEW.id, NEW.nombre, NEW.cedula, NEW.ciudad, NEW.email, NEW.contrasena, NEW.rol, NOW(), 'I');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_uid_update_user` AFTER UPDATE ON `usuario` FOR EACH ROW BEGIN
   INSERT INTO auditoria_usuarios (usuario_id,nombre, cedula, ciudad, email, contrasena, rol, fecha_modificacion, tipo_cambio)
    VALUES (NEW.id, NEW.nombre, NEW.cedula, NEW.ciudad, NEW.email, NEW.contrasena, NEW.rol, NOW(),'U');
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria_usuarios`
--
ALTER TABLE `auditoria_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `auditoria_usuarios_ibfk_1` (`usuario_id`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idOrden` (`idOrden`),
  ADD KEY `idComprador` (`idComprador`),
  ADD KEY `idEstado` (`idEstado`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `metodopago`
--
ALTER TABLE `metodopago`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `orden`
--
ALTER TABLE `orden`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idProducto` (`idProducto`),
  ADD KEY `idComprador` (`idComprador`),
  ADD KEY `idMetodoPago` (`idMetodoPago`),
  ADD KEY `idEstado` (`idEstado`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idVendedor` (`idVendedor`),
  ADD KEY `idCategoria` (`idCategoria`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditoria_usuarios`
--
ALTER TABLE `auditoria_usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metodopago`
--
ALTER TABLE `metodopago`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `orden`
--
ALTER TABLE `orden`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD CONSTRAINT `devoluciones_ibfk_1` FOREIGN KEY (`idOrden`) REFERENCES `orden` (`id`),
  ADD CONSTRAINT `devoluciones_ibfk_2` FOREIGN KEY (`idComprador`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `devoluciones_ibfk_3` FOREIGN KEY (`idEstado`) REFERENCES `estado` (`id`);

--
-- Filtros para la tabla `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `orden_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `orden_ibfk_2` FOREIGN KEY (`idComprador`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `orden_ibfk_3` FOREIGN KEY (`idMetodoPago`) REFERENCES `metodopago` (`id`),
  ADD CONSTRAINT `orden_ibfk_4` FOREIGN KEY (`idEstado`) REFERENCES `estado` (`id`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`idVendedor`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
