-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para campus_alalay
CREATE DATABASE IF NOT EXISTS `campus_alalay` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `campus_alalay`;

-- Volcando estructura para tabla campus_alalay.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `CODCATEGORIA` int(11) NOT NULL AUTO_INCREMENT,
  `NOMCATEGORIA` varchar(100) NOT NULL,
  PRIMARY KEY (`CODCATEGORIA`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla campus_alalay.categoria: ~2 rows (aproximadamente)
INSERT INTO `categoria` (`CODCATEGORIA`, `NOMCATEGORIA`) VALUES
	(1, 'Tecnología e Informática'),
	(2, 'Negocios y Emprendimiento'),
	(4, 'Ciencias y Matemáticas');

-- Volcando estructura para tabla campus_alalay.contenido
CREATE TABLE IF NOT EXISTS `contenido` (
  `codContenido` int(11) NOT NULL AUTO_INCREMENT,
  `videoC` varchar(100) DEFAULT NULL,
  `archivo` varchar(100) DEFAULT NULL,
  `descripcion` varchar(1000) DEFAULT NULL,
  `codUnidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`codContenido`),
  KEY `codUnidad` (`codUnidad`),
  CONSTRAINT `contenido_ibfk_1` FOREIGN KEY (`codUnidad`) REFERENCES `unidad` (`codUnidad`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla campus_alalay.contenido: ~0 rows (aproximadamente)

-- Volcando estructura para tabla campus_alalay.curso
CREATE TABLE IF NOT EXISTS `curso` (
  `IDCURSO` int(11) NOT NULL AUTO_INCREMENT,
  `CODCATEGORIA` int(11) DEFAULT NULL,
  `CODNIVEL` int(11) DEFAULT NULL,
  `NOMCURSO` varchar(100) NOT NULL,
  `CARGAHORARIAC` varchar(50) NOT NULL,
  `COSTOC` varchar(50) NOT NULL,
  `DESCRIPCIONC` varchar(1000) NOT NULL,
  `PORTADAC` varchar(200) NOT NULL,
  PRIMARY KEY (`IDCURSO`),
  KEY `FK_CUENTA` (`CODCATEGORIA`),
  KEY `FK_TIENE` (`CODNIVEL`),
  CONSTRAINT `FK_CUENTA` FOREIGN KEY (`CODCATEGORIA`) REFERENCES `categoria` (`CODCATEGORIA`),
  CONSTRAINT `FK_TIENE` FOREIGN KEY (`CODNIVEL`) REFERENCES `nivel` (`CODNIVEL`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla campus_alalay.curso: ~6 rows (aproximadamente)
INSERT INTO `curso` (`IDCURSO`, `CODCATEGORIA`, `CODNIVEL`, `NOMCURSO`, `CARGAHORARIAC`, `COSTOC`, `DESCRIPCIONC`, `PORTADAC`) VALUES
	(34, 2, 2, 'programacion', '34', '25', 'La programacion es la actividad que se enfoca en organizar un conjunto de datos ordenados a seguir para ser ciertas cosas esta definicion puede utilizarse en muchos contextos', '/static/archivos/programacion.jpg'),
	(35, 2, 2, 'Calculo II', '34', '25', 'Se estudia la integral definida los teoremas fundamentales del calculo y algunas aplicaciones en los que la integracion definida apoyada en los metodos de integracion ', '/static/archivos/image.jpg'),
	(36, 1, 2, 'Inteligencia Artificial', '34', '25', 'La inteligencia artificial  es un campo de la informatica que se enfoca en crear sistemas que puedan realizar tareas que normalmente requieren inteligencia humana como el aprendizaje el razonamiento y la percepcion', '/static/archivos/ia.jpeg'),
	(37, 2, 2, 'Base de datos', '34', '25', 'Una base de datos es una recopilacion de datos sistematica y almacenada electronicamente', '/static/archivos/Arregui-como-crear-codigos-seguros.jpg'),
	(54, 1, 2, 'Curso de Fundamentos de IA para Data y Machine Learning', '345', '90', 'Descubre el mundo de la IA y machine learning desde cero sin saber programación. Domina los conceptos fundamentales y conoce sus aplicaciones en una variedad de campos. Conoce cómo funcionan por dentro herramientas como ChatGPT, Dall-E 2 y Hugging Face. Aprender de IA y data science es un reto, pero Platzi lo hace efectivo .', '/static/archivos/inteligencia%20artificial.jpeg'),
	(60, 1, 2, 'Desarrollo Web Completo con HTML5, CSS3, JS PHP y MySQL', '350', '25', ' Un curso paso a paso si deseas comenzar en el mundo de la Programación Web.En este curso aprenderás 10 Lenguajes y Tecnologías Web:HTML, CSS, SASS, Workflows, JavaScript, Fetch (Antes AJAX), PHP, POO - MVC, MySQL - SQL y API\'sEl Curso Incluye 4 proyectos finales, puedes ver los videos con los demos totalmente gratis Además, aprenderás otros temas muy importante.', '/static/archivos/980450_7fc0_4.jpg');

-- Volcando estructura para tabla campus_alalay.estudiante
CREATE TABLE IF NOT EXISTS `estudiante` (
  `codEstudiante` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Contraseña` varchar(50) NOT NULL,
  `foto` varchar(50) NOT NULL,
  PRIMARY KEY (`codEstudiante`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla campus_alalay.estudiante: ~2 rows (aproximadamente)
INSERT INTO `estudiante` (`codEstudiante`, `nombre`, `Email`, `Contraseña`, `foto`) VALUES
	(78, 'Jhonny', 'jhonnydelgadillo003@gmail.com', 'fsffs4343ffff4ffF', ''),
	(79, 'Jhonny', 'jhonnylopezfox123@gmail.com', 'fsfsfdFDF43', '');

-- Volcando estructura para tabla campus_alalay.nivel
CREATE TABLE IF NOT EXISTS `nivel` (
  `CODNIVEL` int(11) NOT NULL AUTO_INCREMENT,
  `NOMNIVEL` varchar(100) NOT NULL,
  PRIMARY KEY (`CODNIVEL`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla campus_alalay.nivel: ~3 rows (aproximadamente)
INSERT INTO `nivel` (`CODNIVEL`, `NOMNIVEL`) VALUES
	(1, 'Intermedio'),
	(2, 'Avanzado'),
	(3, 'Basico');

-- Volcando estructura para tabla campus_alalay.registro_docentes
CREATE TABLE IF NOT EXISTS `registro_docentes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(255) NOT NULL,
  `correo_electronico` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `especialidad` varchar(255) NOT NULL,
  `nacionalidad` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `curiculum` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla campus_alalay.registro_docentes: ~0 rows (aproximadamente)

-- Volcando estructura para tabla campus_alalay.unidad
CREATE TABLE IF NOT EXISTS `unidad` (
  `codUnidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombreU` varchar(100) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `IDCURSO` int(11) DEFAULT NULL,
  PRIMARY KEY (`codUnidad`),
  KEY `IDCURSO` (`IDCURSO`),
  CONSTRAINT `unidad_ibfk_1` FOREIGN KEY (`IDCURSO`) REFERENCES `curso` (`IDCURSO`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla campus_alalay.unidad: ~2 rows (aproximadamente)
INSERT INTO `unidad` (`codUnidad`, `nombreU`, `descripcion`, `IDCURSO`) VALUES
	(149, 'introducion ', '43r3r34r', 34),
	(150, 'presentacion', 'r3r3', 34);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
