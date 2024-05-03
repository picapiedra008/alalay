-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: campus_alalay
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `CODCATEGORIA` int NOT NULL AUTO_INCREMENT,
  `NOMCATEGORIA` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`CODCATEGORIA`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Tecnología e Informática'),(2,'Negocios y Emprendimiento'),(4,'Ciencias y Matemáticas');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `IDCURSO` int NOT NULL AUTO_INCREMENT,
  `CODCATEGORIA` int DEFAULT NULL,
  `CODNIVEL` int DEFAULT NULL,
  `NOMCURSO` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CARGAHORARIAC` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `COSTOC` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPCIONC` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PORTADAC` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`IDCURSO`) USING BTREE,
  KEY `FK_CUENTA` (`CODCATEGORIA`) USING BTREE,
  KEY `FK_TIENE` (`CODNIVEL`) USING BTREE,
  CONSTRAINT `FK_CUENTA` FOREIGN KEY (`CODCATEGORIA`) REFERENCES `categoria` (`CODCATEGORIA`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_TIENE` FOREIGN KEY (`CODNIVEL`) REFERENCES `nivel` (`CODNIVEL`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (34,2,2,'programacion','34','25','La programacion es la actividad que se enfoca en organizar un conjunto de datos ordenados a seguir para ser ciertas cosas esta definicion puede utilizarse en muchos contextos','/static/archivos/programacion.jpg'),(35,2,2,'Calculo II','34','25','Se estudia la integral definida los teoremas fundamentales del calculo y algunas aplicaciones en los que la integracion definida apoyada en los metodos de integracion ','/static/archivos/image.jpg'),(36,1,2,'Inteligencia Artificial','34','25','La inteligencia artificial  es un campo de la informatica que se enfoca en crear sistemas que puedan realizar tareas que normalmente requieren inteligencia humana como el aprendizaje el razonamiento y la percepcion','/static/archivos/ia.jpeg'),(37,2,2,'Base de datos','34','25','Una base de datos es una recopilacion de datos sistematica y almacenada electronicamente','/static/archivos/Arregui-como-crear-codigos-seguros.jpg'),(38,2,2,'Redes ','34','25','Una red de computadoras tambien llamada red de ordenadores o red informatica es un conjunto de equipos conectados por medio de cables senales ondas o cualquier otro metodo de transporte de datos','/static/archivos/redes.png'),(39,1,1,'programacion','34','25','Una red de computadoras, también llamada red de ordenadores o red informática, es un conjunto de equipos conectados por medio de cables, señales, ondas o cualquier otro método de transporte de datos, que comparten información .','/static/archivos/contrase%C3%B1a.jpg'),(40,1,2,'metodologia de la investigacion','12','80','el curso contiene jmxmcb','/static/archivos/CalifActi1.PNG'),(41,4,3,'Algebra','80','70',' En este nivel se dedica mayor tiempo al contenido y los procesos de álgebra y geometría formalizando el estudio de estas disciplinas.','/static/archivos/Algebra.PNG'),(42,2,2,'programacion','34','25','asdfasdfasd','/static/archivos/aiso.png');
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nivel`
--

DROP TABLE IF EXISTS `nivel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivel` (
  `CODNIVEL` int NOT NULL AUTO_INCREMENT,
  `NOMNIVEL` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`CODNIVEL`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nivel`
--

LOCK TABLES `nivel` WRITE;
/*!40000 ALTER TABLE `nivel` DISABLE KEYS */;
INSERT INTO `nivel` VALUES (1,'Intermedio'),(2,'Avanzado'),(3,'Basico');
/*!40000 ALTER TABLE `nivel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_docentes`
--

DROP TABLE IF EXISTS `registro_docentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_docentes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `correo_electronico` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `contrasena` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `especialidad` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nacionalidad` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `foto` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `descripcion` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `curiculum` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_docentes`
--

LOCK TABLES `registro_docentes` WRITE;
/*!40000 ALTER TABLE `registro_docentes` DISABLE KEYS */;
INSERT INTO `registro_docentes` VALUES (1,'Juan Pablo Quispe Espinoza','quispejuan195@gmail.com','170294','Matematicas','Bolivia',NULL,' un profesional formado para desempeñarse en la enseñanza de la matemática en los niveles medio y superior (no universitario y universitario).',NULL),(2,'Juan Pablo Quispe Espinoza','quispejuan195@gmail.com','123456','Matematicas','Bolivia',NULL,'es un profesional formado para desempeñarse en la enseñanza de la matemática en los niveles medio y superior (no universitario y universitario)',NULL),(3,'Alex','alex@gmail.com','1234567','Fisica','Bolivia',NULL,'Enseñar al alumnado las reglas y técnicas de diferentes deportes individuales ',NULL),(4,'Alex','alex@gmail.com','1234567','Fisica','Bolivia',NULL,'Enseñar al alumnado las reglas y técnicas de diferentes deportes individuales ',NULL),(5,'Alex','alex@gmail.com','1234567','Fisica','Bolivia',NULL,'Enseñar al alumnado las reglas y técnicas de diferentes deportes individuales ',NULL),(6,'Alex','alex@gmail.com','1234567','Fisica','Bolivia',NULL,'Enseñar al alumnado las reglas y técnicas de diferentes deportes individuales ',NULL),(7,'Alex','alex@gmail.com','1234567','Fisica','Bolivia',NULL,'Enseñar al alumnado las reglas y técnicas de diferentes deportes individuales ',NULL),(8,'Alex Campos','alex@gmail.com','1234567','Matematicas','Bolivia',NULL,'A continuación, el destinatario del correo podrá abrirlo y descargarlo. Los archivos adjuntos suelen',NULL),(9,'Alex Campos','alex@gmail.com','17294568','Matematicas','Chile',NULL,'http://127.0.0.1:5000vs dnbsa D',NULL),(10,'Rorigo Delgadillo','rodrigo12@gmail.com','12345','Programacion','Peru',NULL,'es la actividad que se enfoca en organizar un conjunto de datos ordenados a seguir para ser ciertas cosas',NULL),(11,'Pepe','pepe@gmail.com','1458','Matematicas','Bolivia',NULL,'Esta especialidad está dirigida a profesionales que se desempeñan como docentes en el área de Matemáticas del nivel Secundario. El participante debe superar las ...',NULL),(12,'Ana','ana@gmail.com','145','Fisica','Bolivia',NULL,'Modalidad De Estudio · Modalidad Mixta: Asistiendo a clases presenciales cada cuatro meses por un periodo de tres días y trabajo virtual en plataforma.',NULL),(13,'Ana','ana@gmail.com','54654','Fisica','Bolivia',NULL,'Modalidad De Estudio · Modalidad Mixta: Asistiendo a clases presenciales cada cuatro meses por un periodo de tres días y trabajo virtual en plataforma.',NULL);
/*!40000 ALTER TABLE `registro_docentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` VALUES (1,'video 2.mp4'),(2,'video1.mp4');
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-28 14:06:12
