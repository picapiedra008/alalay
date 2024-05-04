-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3310
-- Tiempo de generación: 04-05-2024 a las 21:29:52
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
(1, 'Tecnología e Informática'),
(2, 'Negocios y Emprendimiento'),
(4, 'Ciencias y Matemáticas');

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
(54, 1, 2, 'Curso de Fundamentos de IA para Data y Machine Learning', '345', '90', 'Descubre el mundo de la IA y machine learning desde cero sin saber programación. Domina los conceptos fundamentales y conoce sus aplicaciones en una variedad de campos. Conoce cómo funcionan por dentro herramientas como ChatGPT, Dall-E 2 y Hugging Face. Aprender de IA y data science es un reto, pero Platzi lo hace efectivo .', '/static/archivos/inteligencia%20artificial.jpeg'),
(60, 1, 2, 'Desarrollo Web Completo con HTML5, CSS3, JS PHP y MySQL', '350', '25', ' Un curso paso a paso si deseas comenzar en el mundo de la Programación Web.En este curso aprenderás 10 Lenguajes y Tecnologías Web:HTML, CSS, SASS, Workflows, JavaScript, Fetch (Antes AJAX), PHP, POO - MVC, MySQL - SQL y API\'sEl Curso Incluye 4 proyectos finales, puedes ver los videos con los demos totalmente gratis Además, aprenderás otros temas muy importante.', '/static/archivos/980450_7fc0_4.jpg');

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
(1, 'Intermedio'),
(2, 'Avanzado'),
(3, 'Basico');

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
  ADD KEY `FK_TIENE` (`CODNIVEL`);

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
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `CODCATEGORIA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `contenido`
--
ALTER TABLE `contenido`
  MODIFY `codContenido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `IDCURSO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `nivel`
--
ALTER TABLE `nivel`
  MODIFY `CODNIVEL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `registro_docentes`
--
ALTER TABLE `registro_docentes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `unidad`
--
ALTER TABLE `unidad`
  MODIFY `codUnidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- Restricciones para tablas volcadas
--

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
  ADD CONSTRAINT `FK_TIENE` FOREIGN KEY (`CODNIVEL`) REFERENCES `nivel` (`CODNIVEL`);

--
-- Filtros para la tabla `unidad`
--
ALTER TABLE `unidad`
  ADD CONSTRAINT `unidad_ibfk_1` FOREIGN KEY (`IDCURSO`) REFERENCES `curso` (`IDCURSO`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
