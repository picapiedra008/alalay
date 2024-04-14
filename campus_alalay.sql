-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3310
-- Tiempo de generación: 11-04-2024 a las 09:01:05
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
  `PORTADAC` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`IDCURSO`, `CODCATEGORIA`, `CODNIVEL`, `NOMCURSO`, `CARGAHORARIAC`, `COSTOC`, `DESCRIPCIONC`, `PORTADAC`) VALUES
(34, 2, 2, 'programacion', '34', '25', 'La programacion es la actividad que se enfoca en organizar un conjunto de datos ordenados a seguir para ser ciertas cosas esta definicion puede utilizarse en muchos contextos', '/static/archivos/programacion.jpg'),
(35, 2, 2, 'Calculo II', '34', '25', 'Se estudia la integral definida los teoremas fundamentales del calculo y algunas aplicaciones en los que la integracion definida apoyada en los metodos de integracion ', '/static/archivos/image.jpg'),
(36, 1, 2, 'Inteligencia Artificial', '34', '25', 'La inteligencia artificial  es un campo de la informatica que se enfoca en crear sistemas que puedan realizar tareas que normalmente requieren inteligencia humana como el aprendizaje el razonamiento y la percepcion', '/static/archivos/ia.jpeg'),
(37, 2, 2, 'Base de datos', '34', '25', 'Una base de datos es una recopilacion de datos sistematica y almacenada electronicamente', '/static/archivos/Arregui-como-crear-codigos-seguros.jpg'),
(38, 2, 2, 'Redes ', '34', '25', 'Una red de computadoras tambien llamada red de ordenadores o red informatica es un conjunto de equipos conectados por medio de cables senales ondas o cualquier otro metodo de transporte de datos', '/static/archivos/redes.png'),
(39, 1, 1, 'programacion', '34', '25', 'Una red de computadoras, también llamada red de ordenadores o red informática, es un conjunto de equipos conectados por medio de cables, señales, ondas o cualquier otro método de transporte de datos, que comparten información .', '/static/archivos/contrase%C3%B1a.jpg');

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

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`CODCATEGORIA`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`IDCURSO`),
  ADD KEY `FK_CUENTA` (`CODCATEGORIA`),
  ADD KEY `FK_TIENE` (`CODNIVEL`);

--
-- Indices de la tabla `nivel`
--
ALTER TABLE `nivel`
  ADD PRIMARY KEY (`CODNIVEL`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `CODCATEGORIA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `IDCURSO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `nivel`
--
ALTER TABLE `nivel`
  MODIFY `CODNIVEL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `FK_CUENTA` FOREIGN KEY (`CODCATEGORIA`) REFERENCES `categoria` (`CODCATEGORIA`),
  ADD CONSTRAINT `FK_TIENE` FOREIGN KEY (`CODNIVEL`) REFERENCES `nivel` (`CODNIVEL`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
