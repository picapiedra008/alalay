-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3310
-- Tiempo de generación: 18-05-2024 a las 02:56:25
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
-- Base de datos: `campus_alalay`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `idCarrito` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `IDCURSO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `CODCATEGORIA` int(11) NOT NULL,
  `NOMCATEGORIA` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`CODCATEGORIA`, `NOMCATEGORIA`) VALUES
(1, 'Tecnología e Informática\r\n'),
(2, 'Negocios y Emprendimiento\r\n'),
(4, 'Ciencias y Matemáticas\r\n');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido`
--

CREATE TABLE `contenido` (
  `codContenido` int(11) NOT NULL,
  `videoC` varchar(100) DEFAULT NULL,
  `archivo` varchar(100) DEFAULT NULL,
  `descripcion` varchar(1000) DEFAULT NULL,
  `codUnidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `IDCURSO` int(11) NOT NULL,
  `CODCATEGORIA` int(11) DEFAULT NULL,
  `CODNIVEL` int(11) DEFAULT NULL,
  `NOMCURSO` varchar(100) NOT NULL,
  `CARGAHORARIAC` varchar(50) NOT NULL,
  `COSTOC` varchar(50) NOT NULL,
  `DESCRIPCIONC` varchar(1000) NOT NULL,
  `PORTADAC` varchar(200) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`IDCURSO`, `CODCATEGORIA`, `CODNIVEL`, `NOMCURSO`, `CARGAHORARIAC`, `COSTOC`, `DESCRIPCIONC`, `PORTADAC`, `id`) VALUES
(62, 2, 1, 'programacion', '34', '25', 'asdfasdfasdfasdfasdf', '/static/archivos/algoritmo.jpeg', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `contrasena` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`id`, `nombre`, `correo`, `foto`, `contrasena`) VALUES
(1, 'jhonny', 'jhonnyrojasflo@gmail.com', 'static', NULL),
(2, 'JHONNY ROJAS FLORES', '202108055@est.umss.edu', 'https://lh3.googleusercontent.com/a/ACg8ocLryBACgC2VpfAvgjOZhUB5EFwHDlUq9Iv3HCrbAVFyrFRrX44=s96-c', NULL),
(3, 'jhonny', 'rojasjhonny732@gmail.com', '', 'asdf234ERER');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel`
--

CREATE TABLE `nivel` (
  `CODNIVEL` int(11) NOT NULL,
  `NOMNIVEL` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `nivel`
--

INSERT INTO `nivel` (`CODNIVEL`, `NOMNIVEL`) VALUES
(1, 'INTERMEDIO\r\n\r\n'),
(2, 'AVANZADO'),
(3, 'BASICO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_docentes`
--

CREATE TABLE `registro_docentes` (
  `id` int(11) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `correo_electronico` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `especialidad` varchar(255) NOT NULL,
  `nacionalidad` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `curiculum` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `registro_docentes`
--

INSERT INTO `registro_docentes` (`id`, `nombre_completo`, `correo_electronico`, `contrasena`, `especialidad`, `nacionalidad`, `foto`, `descripcion`, `curiculum`) VALUES
(2, 'Juan Perez ', 'jhonnyrojasflu6@gmail.com', '123adER@', 'estudiante', 'peru', '/static/archivos/juan%20perez.jpeg', 'asdfasdfasdfasdfasdfasdfasdf', '/static/archivos/descarga%20(2).pdf'),
(3, 'Raul Katari', '202108055@est.umss.edu', 'asdfER23@', 'calculo', 'bolivia', '/static/archivos/juan%20perez.jpeg', 'asdfasdfasdf', '/static/archivos/II_Administracion%20(1).pdf'),
(4, 'Rodrigo Mamani', 'mamani@gmail.com', 'asdfETR2345@', 'ingeniero', 'bolivia', '/static/archivos/juan%20perez.jpeg', 'asdfasdf', '/static/archivos/Reporte%20Venta.pdf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad`
--

CREATE TABLE `unidad` (
  `codUnidad` int(11) NOT NULL,
  `nombreU` varchar(100) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `IDCURSO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`idCarrito`),
  ADD KEY `id` (`id`),
  ADD KEY `IDCURSO` (`IDCURSO`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`CODCATEGORIA`);

--
-- Indices de la tabla `contenido`
--
ALTER TABLE `contenido`
  ADD PRIMARY KEY (`codContenido`),
  ADD KEY `codUnidad` (`codUnidad`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`IDCURSO`),
  ADD KEY `FK_CUENTA` (`CODCATEGORIA`),
  ADD KEY `FK_TIENE` (`CODNIVEL`),
  ADD KEY `FK_curso_registro_docentes` (`id`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `nivel`
--
ALTER TABLE `nivel`
  ADD PRIMARY KEY (`CODNIVEL`);

--
-- Indices de la tabla `registro_docentes`
--
ALTER TABLE `registro_docentes`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `unidad`
--
ALTER TABLE `unidad`
  ADD PRIMARY KEY (`codUnidad`),
  ADD KEY `IDCURSO` (`IDCURSO`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `idCarrito` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `CODCATEGORIA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `contenido`
--
ALTER TABLE `contenido`
  MODIFY `codContenido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `IDCURSO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `nivel`
--
ALTER TABLE `nivel`
  MODIFY `CODNIVEL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `registro_docentes`
--
ALTER TABLE `registro_docentes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `unidad`
--
ALTER TABLE `unidad`
  MODIFY `codUnidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`id`) REFERENCES `estudiante` (`id`),
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`IDCURSO`) REFERENCES `curso` (`IDCURSO`);

--
-- Filtros para la tabla `contenido`
--
ALTER TABLE `contenido`
  ADD CONSTRAINT `contenido_ibfk_1` FOREIGN KEY (`codUnidad`) REFERENCES `unidad` (`codUnidad`);

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `FK_CUENTA` FOREIGN KEY (`CODCATEGORIA`) REFERENCES `categoria` (`CODCATEGORIA`),
  ADD CONSTRAINT `FK_TIENE` FOREIGN KEY (`CODNIVEL`) REFERENCES `nivel` (`CODNIVEL`),
  ADD CONSTRAINT `FK_curso_registro_docentes` FOREIGN KEY (`id`) REFERENCES `registro_docentes` (`id`);

--
-- Filtros para la tabla `unidad`
--
ALTER TABLE `unidad`
  ADD CONSTRAINT `unidad_ibfk_1` FOREIGN KEY (`IDCURSO`) REFERENCES `curso` (`IDCURSO`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
