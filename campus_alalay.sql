-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-05-2024 a las 21:09:58
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

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
(1, 'Informática y Desarrollo'),
(2, 'Negocios y Emprendimiento\r\n'),
(3, 'Ciencias y Matemáticas\r\n');

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
(1, 1, 2, 'Angular: De cero a experto', '35', '150', 'Lo que aprenderás, tener una base sólida para trabajar con Angular, dominar TypeScript para crear aplicaciones en Angular, aplicar los conceptos nuevos del ECMAScript 6 en nuestros proyectos de Angular, crear aplicaciones en Angular siguiendo las mejores prácticas, crear aplicaciones básicas en Ionic y utilizarlas en su celular.', '/static/archivos/angular.png', 2),
(2, 1, 2, 'Maestro de Python: De Cero a Programador Experto', '37', '70', 'Este es el curso en español más completo y exhaustivo que encontrarás sobre Python 3. Perfectamente estructurado y balanceado, introduce todos los temas de forma sencilla, gradual y 100% práctica. Todos los temas han sido cuidadosamente preparados para presentarse de forma gradual, de manera que el alumno nunca se sienta perdido durante su aprendizaje.', '/static/archivos/python.jpg', 2),
(3, 1, 1, 'React: De cero a experto ( Hooks y MERN )', '55', '200', 'Este curso tiene por objetivo llevarte de cero conocimiento de React hasta un nivel competitivo en el ambiente laboral de hoy en día. Este curso está construido 100% en Hooks y functional components.\r\nTambién cuenta con secciones sobre pruebas unitarias y de integración en cada aplicación que hacemos en el curso, esto incluye pruebas en componentes, hooks, customHooks, context, Redux, Fetch, mocks, spies, snapshots y mucho más relacionado al unit test.', '/static/archivos/react.jpg', 2),
(4, 1, 2, 'Máster en SQL Server: Desde Cero a Nivel Profesional [2024]', '18', '30', 'SQL Server es un motor de Base de Datos Gratuito en su versión Express y Developer, que permite almacenar información ordenada y estructurada de manera tal que pueda ser consultada rápidamente. Puede ser utilizado para Sitios Web, Aplicaciones para dispositivos móviles o bien para almacenar datos de un Videojuego o cualquier aplicación.\r\nEn este Máster aprenderás sólidos conceptos de diseño y programación de Bases de Datos, que te permitirán posicionarte bien alto en el ámbito profesional del área de desarrollo tecnológico.', '/static/archivos/sql-server.png', 2),
(5, 1, 1, 'Diseño Web Profesional El Curso Completo, Práctico y desde 0', '42', '50', 'Bienvenido al Curso de Diseño Web, en el que aprenderás, paso a paso y desde lo más básico, a diseñar cualquier página web de manera práctica y sencilla.\r\nNo importa si nunca antes has programado o si no tienes conocimientos de páginas web, este curso está diseñado para que aprendas desde lo más básico hasta un nivel avanzado en el que podrás diseñar cualquier sitio web de forma profesional.', '/static/archivos/diseño-web.jpg', 2),
(6, 1, 2, 'Guía de JavaScript Moderna', '55', '150', 'En este curso aprenderás JavaScript desde los fundamentos hasta temas más avanzados como Prototypes, Delegation, Classes, Ajax, Promises, Generadores, Orientado a Objetos, Fetch API, Async Await, Async JS, Objetos, así como consumir REST APIs, API\'s de JavaScript nátivas como Notification API, Speech API y mucho más!', '/static/archivos/javascript.jpeg', 4),
(7, 1, 3, 'Programación de Android desde cero con Java', '45', '50', 'Tendrás el desarrollo de una app como ejercicio por cada sección del curso, así como el código de los ejemplos mostrados en los videos. El curso está estructurado de forma modular, así que tú decides en qué orden ver las secciones, sin necesidad de seguir una secuencia obligatoria. Tienes más de 20 horas de videos que irán aumentando con el tiempo, ya que esté curso estará en constante renovación y ampliación.', '/static/archivos/android.jpeg', 4),
(8, 1, 2, 'GIT+GitHub: Todo un sistema de control de versiones de cero', '20', '200', 'Este curso te llevará de la mano partiendo desde cero hasta tener más de lo que necesitas para trabajar con Git, adicionalmente aprenderás a utilizar GitHub como un repositorio remoto, incluyendo formas de trabajar en equipo, flujos de trabajo, tokens, Pull Request y otros temas avanzados que serán de mucha utilidad en tu vida profesional.', '/static/archivos/git.png', 4),
(9, 1, 2, 'PHP 8 y MYSQL: El Curso Completo, Práctico y Desde Cero!', '20', '80', 'Bienvenido a PHP y MYSQL: El Curso Completo, Practico y Desde Cero el curso en el que aprenderás paso por paso y desde lo más básico a programar cualquier Aplicación o Sitio Web de una forma práctica y sencilla.\r\nEste curso es tu oportunidad de crear sitios en uno de los lenguajes más utilizados del mundo.', '/static/archivos/php8.jpg', 4),
(10, 1, 1, 'Master en CSS: Responsive, SASS, Flexbox, Grid y Bootstrap', '22', '65', 'Bienvenido al Máster en CSS, en el que aprenderemos todo lo necesario para dominar HTML, CSS, CSS3, Maquetación web, Responsive, SASS, LESS, Flexbox, CSS Grid Layout y Bootstrap, las tecnologías de front-end orientadas al diseño web más importantes, con más demanda laboral y más proyección de futuro.', '/static/archivos/css.jpg', 4),
(11, 2, 1, 'Scrum Master Esencial: Fundamentos Sólidos y Efectivos', '5', '20', 'Según LinkedIn, el Scrum Master se encuentra entre los 10 perfiles más buscados en el mercado laboral. Al dominar Scrum, no solo enriqueces tu CV, sino que también puedes incrementar significativamente tu salario y oportunidades laborales.', '/static/archivos/scrum.png', 4),
(12, 2, 1, 'Excel - Fórmulas, tablas dinámicas y dashboards', '5', '35', 'En esta sección realizaremos la presentación inicial del curso y se trataran temas relacionados con la distribución de las clases,  por qué es tan importante saber Excel, cómo se pueden descargar los materiales, preguntar dudas, etc.', '/static/archivos/excel.jpg', 4),
(13, 2, 3, 'Power BI – Análisis de Datos y Business Intelligence', '22', '75', 'Microsoft Power BI es uno de los programas con tecnologías de Business Intelligence más robusto en el mercado, y al mismo tiempo es uno de los más baratos ¡incluso gratuito! Cualquiera puede iniciar a desarrollar reportes con visualizaciones interactivas gratis. Si eres dueño de un negocio, gerente de un departamento, o simplemente tienes interés en analizar y dar seguimiento a tus actividades y objetivos, entonces este curso es para ti.', '/static/archivos/power-bi.jpg', 4),
(14, 2, 3, 'Inteligencia Emocional para la Atención al Cliente.', '2', '10', '¿Por qué es tan difícil dar un buen servicio al cliente?\r\nSimple, porque queremos abordarlo como un problema racional, como un sistema organizacional que podamos mecanizar, pero desgraciadamente, el servicio al cliente se basa en relaciones humanas, y por ello, es irracional y emocional.', '/static/archivos/emocional.jpg', 4),
(15, 2, 3, 'Finanzas Inmobiliarias (Para principiantes)', '7', '50', 'Al finalizar el curso los asistentes tendrán una visión y entendimiento global de cómo se realiza un análisis financiero inmobiliario profesional, para desarrollo y valuación de propiedades, así como cuales son los indicadores financieros adecuados para cada tipo de proyecto inmobiliario (TIR, ROI, Tasa Capitalización, múltiplo de retorno, valor presente neto, etc).', '/static/archivos/finanzas.png', 4),
(16, 3, 1, 'Funciones Matemáticas', '7', '50', 'Este curso está dedicado para alumnos que tengan conocimiento de Matemática Básica y Geometría Analítica o cualquier alumno que quiera refrescar sus conocimientos de Funciones.', '/static/archivos/funciones.jpeg', 3),
(17, 3, 3, 'Matemática discreta desde cero: Lógica y Teoría de Conjuntos', '6', '40', 'En este curso, que tiene el foco puesto en aprender y comprender, tendrás, además de toda la teoría necesaria explicada en variedad de clases en vídeo, multitud de ejemplos resueltos y explicados en formato vídeo. Aprenderás todo lo necesario para poder introducirte en las matemáticas discretas y aplicar dichos conocimientos en tu futuro profesional y académico.', '/static/archivos/discreta.jpg', 3),
(18, 3, 1, 'Experto en Matemáticas con Geogebra', '5', '50', 'En este curso conoceremos las opciones del programa para varios temas de Matemáticas como: construcciones geométricas, análisis de funciones, cálculo, gráficos 3D, a través de diferentes ejercicios que te ayudarán a conocer los comandos y herramientas de graficación en cada caso.', '/static/archivos/geogebra.png', 3),
(19, 3, 3, 'Aprende Derivadas desde cero - Cálculo', '6', '20', '100 ejercicios explicados detalladamente, aprenderás a derivar desde las funciones mas básicas pasando por trigonométricas, exponenciales, logarítmicas implícitas y hasta orden superior en diferentes temas con una sola variable independiente que te permitirán resolver ejercicios de dificultad media y avanzada incluyendo demostraciones', '/static/archivos/derivadas.png', 3),
(20, 3, 3, 'Aprende matemáticas desde cero - Fundamentos de Álgebra', '35', '70', 'La estructura dinámica de este curso de Fundamentos de Álgebra te ayudará a asentar las bases de este campo de las Matemáticas. En primer lugar, podrás ver los vídeos de teoría donde tienes todo lo esencial explicado en formato de vídeo y podrás aprender y repasar los conceptos clave de todos los temas del Álgebra. ', '/static/archivos/algebra.jpg', 3);

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
(1, 'Intermedio\n\n'),
(2, 'Avanzado'),
(3, 'Básico');

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
(2, 'Juan Ramos Perez ', 'jhonnyrojasflu6@gmail.com', '123adER@', 'estudiante', 'peru', '/static/archivos/juan%20perez.jpeg', 'asdfasdfasdfasdfasdfasdfasdf', '/static/archivos/descarga%20(2).pdf'),
(3, 'Raul Katari Ríos', '202108055@est.umss.edu', 'asdfER23@', 'calculo', 'bolivia', '/static/archivos/juan%20perez.jpeg', 'asdfasdfasdf', '/static/archivos/II_Administracion%20(1).pdf'),
(4, 'Rodrigo Mamani Juchasara', 'mamani@gmail.com', 'asdfETR2345@', 'ingeniero', 'bolivia', '/static/archivos/juan%20perez.jpeg', 'asdfasdf', '/static/archivos/Reporte%20Venta.pdf');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
