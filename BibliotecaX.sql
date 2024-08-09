-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-08-2024 a las 16:53:15
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bibliotecax`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_deleteLibro` (IN `id_libro` BIGINT(20))   BEGIN
DELETE
FROM tbl_libro
WHERE lib_isbn = id_libro;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_innerJoin` ()   SELECT
tbl_libro.lib_titulo,
tbl_prestamo.pres_fechaPrestamo,
tbl_socio.soc_nombre
FROM tbl_prestamo
INNER JOIN tbl_socio ON tbl_socio.soc_numero = tbl_prestamo.soc_copiaNumero
INNER JOIN tbl_libro ON tbl_libro.lib_isbn = tbl_prestamo.lib_copiaisbn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_insertSocio` (IN `s_numero` INT(11), IN `s_nombre` VARCHAR(45), IN `s_apellido` VARCHAR(45), IN `s_direccion` VARCHAR(255), IN `s_telefono` VARCHAR(10))   BEGIN
INSERT INTO tbl_socio (soc_numero, soc_nombre, soc_apellido, soc_direccion, soc_telefono)
VALUES (s_numero, s_nombre, s_apellido, s_direccion, s_telefono);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_leftJoin` ()   SELECT 
tbl_socio.soc_apellido,
tbl_socio.soc_nombre,
tbl_prestamo.pres_fechaPrestamo,
tbl_prestamo.pres_fechaDevolucion
FROM tbl_socio
LEFT JOIN tbl_prestamo ON
tbl_socio.soc_numero =
tbl_prestamo.soc_copiaNumero$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_listaAutores` ()   SELECT aut_codigo,aut_apellido
FROM tbl_autor
ORDER BY aut_apellido DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_nomLibro` (IN `libro` VARCHAR(255))   SELECT *
FROM tbl_libro
WHERE lib_titulo = libro$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tipoAutor` (`variable` VARCHAR(20))   SELECT aut_apellido as 'Autor', tipoAutor
FROM tbl_autor
INNER JOIN tbl_tipoautores
ON aut_codigo=copiaAutor
WHERE tipoAutor=variable$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_updateSocio` (IN `id_socio` INT(11), IN `t_socio` VARCHAR(10), IN `d_socio` VARCHAR(255))   BEGIN
UPDATE tbl_socio
SET soc_telefono = t_socio, soc_direccion = d_socio
WHERE soc_numero = id_socio;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_libro` (`c1_isbn` BIGINT(20), `c2_titulo` VARCHAR(255), `c3_genero` VARCHAR(20), `c4_paginas` INT(11), `c5diaspres` TINYINT(4))   INSERT INTO
tbl_libro(lib_isbn,lib_titulo,lib_genero,lib_numeroPaginas,lib_diasPrestamo)
VALUES (c1_isbn,c2_titulo,c3_genero, c4_paginas,c5diaspres)$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_diasPrestamo` (`libro` INT) RETURNS INT(11)  BEGIN 
	DECLARE dias_prestamo INT;  	
    SELECT DATEDIFF (pres_fechaDevolucion, pres_fechaPrestamo)
    INTO dias_prestamo 
    FROM tbl_prestamo
    WHERE lib_copiaisbn	 = libro; 
    
    RETURN dias_prestamo; 
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_numSocio` () RETURNS INT(11)  BEGIN
	DECLARE total_socios INT; 
	SELECT COUNT(*) INTO total_socios FROM tbl_socio; 
	RETURN total_socios;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_autor`
--

CREATE TABLE `audi_autor` (
  `aut_codigo_audi` int(11) NOT NULL,
  `aut_apellido_old` varchar(255) DEFAULT NULL,
  `aut_nacimiento_old` date DEFAULT NULL,
  `aut_muerte_old` date DEFAULT NULL,
  `aut_apellido_new` varchar(255) DEFAULT NULL,
  `aut_nacimiento_new` date DEFAULT NULL,
  `aut_muerte_new` date DEFAULT NULL,
  `aut_fechaModificacion` datetime DEFAULT NULL,
  `aut_usuario` varchar(10) DEFAULT NULL,
  `aut_accion` varchar(55) DEFAULT NULL,
  `num_audi_autor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audi_autor`
--

INSERT INTO `audi_autor` (`aut_codigo_audi`, `aut_apellido_old`, `aut_nacimiento_old`, `aut_muerte_old`, `aut_apellido_new`, `aut_nacimiento_new`, `aut_muerte_new`, `aut_fechaModificacion`, `aut_usuario`, `aut_accion`, `num_audi_autor`) VALUES
(1, NULL, NULL, NULL, 'García Márquez', '1927-03-06', '2014-04-17', '2024-08-01 07:02:47', 'root@local', 'INSERT', 1),
(2, NULL, NULL, NULL, 'Cifuentes', '1974-12-21', '2018-07-21', '2024-08-01 07:28:13', 'root@local', 'INSERT', 98),
(3, 'Cifuentes', '1974-12-21', '2018-07-21', 'Noreña', '1974-12-21', '2018-07-21', '2024-08-01 07:34:56', 'root@local', 'UPDATE', 98),
(4, NULL, NULL, NULL, 'Sepulveda', '0000-00-00', '0000-00-00', '2024-08-01 09:04:40', 'root@local', 'INSERT', 66),
(5, 'Sepulveda', '0000-00-00', '0000-00-00', 'Sepulveda', '2000-01-01', '2005-08-09', '2024-08-01 09:06:48', 'root@local', 'UPDATE', 66);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_libro`
--

CREATE TABLE `audi_libro` (
  `lib_isbn_audi` int(11) NOT NULL,
  `num_audi_libro` int(11) DEFAULT NULL,
  `lib_titulo_old` varchar(255) DEFAULT NULL,
  `lib_genero_old` varchar(20) DEFAULT NULL,
  `lib_numeroPaginas_old` int(11) DEFAULT NULL,
  `lib_dias_old` tinyint(4) DEFAULT NULL,
  `lib_titulo_new` varchar(255) DEFAULT NULL,
  `lib_genero_new` varchar(20) DEFAULT NULL,
  `lib_numeroPaginas_new` int(11) DEFAULT NULL,
  `lib_dias_new` tinyint(4) DEFAULT NULL,
  `lib_fechaModificacion` datetime DEFAULT NULL,
  `lib_usuario` varchar(10) DEFAULT NULL,
  `lib_accion` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audi_libro`
--

INSERT INTO `audi_libro` (`lib_isbn_audi`, `num_audi_libro`, `lib_titulo_old`, `lib_genero_old`, `lib_numeroPaginas_old`, `lib_dias_old`, `lib_titulo_new`, `lib_genero_new`, `lib_numeroPaginas_new`, `lib_dias_new`, `lib_fechaModificacion`, `lib_usuario`, `lib_accion`) VALUES
(1, 2147483647, 'El Enigma de los Espejos Rotos', 'romance', 156, 7, 'Los hmnos Grimm', 'romance', 156, 7, '2024-08-08 09:30:50', 'root@local', 'UPDATE'),
(3, 202020, 'Los 3 Cerditos', 'Infantil', 10, 3, NULL, NULL, NULL, NULL, '2024-08-08 09:36:50', 'root@local', 'DELETE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_socio`
--

CREATE TABLE `audi_socio` (
  `id_audi` int(10) NOT NULL,
  `socNumero_audi` int(11) DEFAULT NULL,
  `socNombre_anterior` varchar(45) DEFAULT NULL,
  `socApellido_anterior` varchar(45) DEFAULT NULL,
  `socDireccion_anterior` varchar(255) DEFAULT NULL,
  `socTelefono_anterior` varchar(10) DEFAULT NULL,
  `socNombre_nuevo` varchar(45) DEFAULT NULL,
  `socApellido_nuevo` varchar(45) DEFAULT NULL,
  `socDireccion_nuevo` varchar(255) DEFAULT NULL,
  `socTelefono_nuevo` varchar(10) DEFAULT NULL,
  `audi_fechaModificacion` datetime DEFAULT NULL,
  `audi_usuario` varchar(10) DEFAULT NULL,
  `audi_accion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `nombre_libros`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `nombre_libros` (
`lib_titulo` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_autor`
--

CREATE TABLE `tbl_autor` (
  `aut_codigo` int(11) NOT NULL,
  `aut_apellido` varchar(45) NOT NULL,
  `aut_nacimiento` date NOT NULL,
  `aut_muerte` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_autor`
--

INSERT INTO `tbl_autor` (`aut_codigo`, `aut_apellido`, `aut_nacimiento`, `aut_muerte`) VALUES
(1, 'García Márquez', '1927-03-06', '2014-04-17'),
(66, 'Sepulveda', '2000-01-01', '2005-08-09'),
(98, 'Noreña', '1974-12-21', '2018-07-21'),
(123, 'Taylor', '1980-04-15', '0000-00-00'),
(234, 'Medina', '1977-06-21', '2005-09-12'),
(345, 'Wilson', '1975-08-29', '0000-00-00'),
(432, 'Miller', '1981-10-26', '0000-00-00'),
(456, 'García', '1978-09-27', '2021-12-09'),
(567, 'Davis', '1983-03-04', '2010-03-28'),
(678, 'Silva', '1986-02-02', '0000-00-00'),
(765, 'López', '1976-07-08', '2023-12-09'),
(789, 'Rodríguez', '1985-12-10', '0000-00-00'),
(890, 'Brown', '1982-11-17', '0000-00-00'),
(901, 'Soto', '1979-05-13', '2015-11-05');

--
-- Disparadores `tbl_autor`
--
DELIMITER $$
CREATE TRIGGER `autor_delete` AFTER DELETE ON `tbl_autor` FOR EACH ROW BEGIN
INSERT INTO audi_socio(
num_audi_autor,
aut_apellido_old,
aut_nacimiento_old,
aut_muerte_old,
aut_fechaModificacion,
aut_usuario,
aut_accion)
VALUES (
old.aut_codigo,
old.aut_apellido,
old.aut_nacimiento,
old.aut_muerte,
NOW(),
USER(),
'DELETE'
);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `autor_insert` AFTER INSERT ON `tbl_autor` FOR EACH ROW BEGIN 
    INSERT INTO audi_autor(
        num_audi_autor, aut_apellido_new, aut_nacimiento_new, aut_muerte_new,
        aut_fechaModificacion, aut_usuario, aut_accion)
    VALUES (
        NEW.aut_codigo, NEW.aut_apellido, NEW.aut_nacimiento, NEW.aut_muerte, 
        NOW(), USER(), 'INSERT'
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `autor_update` BEFORE UPDATE ON `tbl_autor` FOR EACH ROW BEGIN 
    INSERT INTO audi_autor(
        num_audi_autor, aut_apellido_old, aut_nacimiento_old, aut_muerte_old,
        aut_apellido_new, aut_nacimiento_new, aut_muerte_new,
        aut_fechaModificacion, aut_usuario, aut_accion)
    VALUES (
        OLD.aut_codigo, OLD.aut_apellido, OLD.aut_nacimiento, OLD.aut_muerte,
        NEW.aut_apellido, NEW.aut_nacimiento, NEW.aut_muerte,
        NOW(), USER(), 'UPDATE'
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_libro`
--

CREATE TABLE `tbl_libro` (
  `lib_isbn` bigint(20) NOT NULL,
  `lib_titulo` varchar(255) NOT NULL,
  `lib_genero` varchar(20) NOT NULL,
  `lib_numeroPaginas` int(11) NOT NULL,
  `lib_diasPrestamo` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_libro`
--

INSERT INTO `tbl_libro` (`lib_isbn`, `lib_titulo`, `lib_genero`, `lib_numeroPaginas`, `lib_diasPrestamo`) VALUES
(1234567890, 'El Sueño de los Susurros', 'novela', 275, 7),
(1357924680, 'El Jardín de las Mariposas Perdidas', 'novela', 536, 7),
(2468135790, 'La Melodía de la Oscuridad', 'romance', 189, 7),
(2718281828, 'El Bosque de los Suspiros', 'novela', 387, 2),
(3141592653, 'El Secreto de las Estrellas Olvidadas', 'Misterio', 203, 7),
(5555555555, 'La Última Llave del Destino', 'cuento', 503, 7),
(7777777777, 'El Misterio de la Luna Plateada', 'Misterio', 422, 7),
(8642097531, 'El Reloj de Arena Infinito', 'novela', 321, 7),
(8888888888, 'La Ciudad de los Susurros', 'Misterio', 274, 1),
(9517530862, 'Las Crónicas del Eco Silencioso', 'fantasía', 448, 7),
(9876543210, 'El Laberinto de los Recuerdos', 'cuento', 412, 7),
(9999999999, 'Los hmnos Grimm', 'romance', 156, 7);

--
-- Disparadores `tbl_libro`
--
DELIMITER $$
CREATE TRIGGER `libro_delete` BEFORE DELETE ON `tbl_libro` FOR EACH ROW BEGIN
	INSERT INTO audi_libro (num_audi_libro, lib_titulo_old, lib_genero_old,
	lib_numeroPaginas_old, lib_dias_old, lib_fechaModificacion, lib_usuario, lib_accion)
    VALUES (old.lib_isbn, old.lib_titulo, old.lib_genero, old.lib_numeroPaginas,
    old.lib_diasPrestamo, NOW(), USER(), 'DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `libro_update` BEFORE UPDATE ON `tbl_libro` FOR EACH ROW BEGIN
	INSERT INTO audi_libro (num_audi_libro,lib_titulo_old,lib_genero_old,
	lib_numeroPaginas_old,lib_dias_old,lib_titulo_new,lib_genero_new,
	lib_numeroPaginas_new,lib_dias_new,lib_fechaModificacion,lib_usuario,
	lib_accion)
    VALUES (old.lib_isbn, old.lib_titulo, old.lib_genero, old.lib_numeroPaginas,
    old.lib_diasPrestamo, new.lib_titulo, new.lib_genero, new.lib_numeroPaginas, 
    new.lib_diasPrestamo, NOW(), USER(), 'UPDATE');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_prestamo`
--

CREATE TABLE `tbl_prestamo` (
  `pres_id` varchar(20) NOT NULL,
  `pres_fechaPrestamo` date NOT NULL,
  `pres_fechaDevolucion` date NOT NULL,
  `soc_copiaNumero` int(11) NOT NULL,
  `lib_copiaisbn` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_prestamo`
--

INSERT INTO `tbl_prestamo` (`pres_id`, `pres_fechaPrestamo`, `pres_fechaDevolucion`, `soc_copiaNumero`, `lib_copiaisbn`) VALUES
('pres6', '2023-08-19', '2023-08-26', 12, 5555555555),
('pres7', '2023-10-24', '2024-08-27', 3, 1357924680),
('pres8', '2023-11-11', '2023-11-12', 4, 9999999999),
('pres9', '2023-12-29', '2024-08-30', 8, 5555555555);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_socio`
--

CREATE TABLE `tbl_socio` (
  `soc_numero` int(11) NOT NULL,
  `soc_nombre` varchar(45) NOT NULL,
  `soc_apellido` varchar(45) NOT NULL,
  `soc_direccion` varchar(255) NOT NULL,
  `soc_telefono` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_socio`
--

INSERT INTO `tbl_socio` (`soc_numero`, `soc_nombre`, `soc_apellido`, `soc_direccion`, `soc_telefono`) VALUES
(1, 'Ana ', 'Ruiz', 'Calle Primavera 123, Ciudad Jardín, Barcelona', '9123456780'),
(2, 'Andrés Felipe', 'Galindo Luna', 'Avenida del Sol 456, Pueblo Nuevo, Madrid', '2123456789'),
(3, ' Juan ', 'González', 'Calle Principal 789, Villa Flores, Valencia', '2012345678'),
(4, 'María ', 'Rodríguez', 'Carrera del Río 321, El Pueblo, Sevilla', '3012345678'),
(5, 'Pedro ', 'Martínez', 'Calle del Bosque 654, Los Pinos, Málaga', '1234567812'),
(6, 'Ana', ' López', 'Avenida Central 987, Villa Hermosa, Bilbao', '6123456781'),
(7, 'Carlos', 'Sánchez', 'Calle de la Luna 234, El Prado, Alicante', '1123456781'),
(8, ' Laura ', 'Ramírez', 'Carrera del Mar 567, Playa Azul, Palma de Mallorca', '1312345678'),
(9, 'Luis ', 'Hernández', 'Avenida de la Montaña 890, Monte Verde, Granada', '6101234567'),
(10, 'Andrea ', 'García', 'Calle del Sol 432, La Colina, Zaragoza', '1112345678'),
(11, 'Alejandro ', 'Torres', 'Carrera del Oeste 765, Ciudad Nueva, Murcia', '4951234567'),
(12, 'Sofia ', 'Morales', 'Avenida del Mar 098, Costa Brava, Gijón', '5512345678');

--
-- Disparadores `tbl_socio`
--
DELIMITER $$
CREATE TRIGGER `socios_after_delete` AFTER DELETE ON `tbl_socio` FOR EACH ROW INSERT INTO audi_socio(
    socNumero_audi,
    socNombre_anterior,
    socApellido_anterior,
    socDireccion_anterior,
    socTelefono_anterior,
    audi_fechaModificacion,
    audi_usuario,
    audi_accion)
    VALUES(
    old.soc_numero,
    old.soc_nombre,
    old.soc_apellido,
    old.soc_direccion,
    old.soc_telefono,
    NOW(),
    CURRENT_USER(),
    'Registro eliminado')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `socios_before_update` BEFORE UPDATE ON `tbl_socio` FOR EACH ROW INSERT INTO audi_socio(
    socNumero_audi,
    socNombre_anterior,
    socApellido_anterior,
    socDireccion_anterior,
    socTelefono_anterior,
    socNombre_nuevo,
    socApellido_nuevo,
    socDireccion_nuevo,
    socTelefono_nuevo,
    audi_fechaModificacion,
    audi_usuario,
    audi_accion)
    VALUES(
    new.soc_numero,
    old.soc_nombre,
    old.soc_apellido,
    old.soc_direccion,
    old.soc_telefono,
    new.soc_nombre,
    new.soc_apellido,
    new.soc_direccion,
    new.soc_telefono,
    NOW(),
    CURRENT_USER(),
    'Actualización')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipoautores`
--

CREATE TABLE `tbl_tipoautores` (
  `copiaisbn` bigint(20) NOT NULL,
  `copiaAutor` int(11) NOT NULL,
  `tipoAutor` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_tipoautores`
--

INSERT INTO `tbl_tipoautores` (`copiaisbn`, `copiaAutor`, `tipoAutor`) VALUES
(1357924680, 123, 'Traductor'),
(1234567890, 123, 'Autor'),
(1234567890, 456, 'Coautor'),
(2718281828, 789, 'Traductor'),
(8888888888, 234, 'Autor'),
(2468135790, 234, 'Autor'),
(9876543210, 567, 'Autor'),
(1234567890, 890, 'Autor'),
(8642097531, 345, 'Autor'),
(8888888888, 345, 'Coautor'),
(5555555555, 678, 'Autor'),
(3141592653, 901, 'Autor'),
(9517530862, 432, 'Autor'),
(7777777777, 765, 'Autor'),
(9999999999, 98, 'Autor');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_autor`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_autor` (
`aut_apellido` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `nombre_libros`
--
DROP TABLE IF EXISTS `nombre_libros`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nombre_libros`  AS SELECT `tbl_libro`.`lib_titulo` AS `lib_titulo` FROM `tbl_libro` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_autor`
--
DROP TABLE IF EXISTS `vista_autor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_autor`  AS SELECT `tbl_autor`.`aut_apellido` AS `aut_apellido` FROM `tbl_autor` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `audi_autor`
--
ALTER TABLE `audi_autor`
  ADD PRIMARY KEY (`aut_codigo_audi`);

--
-- Indices de la tabla `audi_libro`
--
ALTER TABLE `audi_libro`
  ADD PRIMARY KEY (`lib_isbn_audi`);

--
-- Indices de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  ADD PRIMARY KEY (`id_audi`);

--
-- Indices de la tabla `tbl_autor`
--
ALTER TABLE `tbl_autor`
  ADD PRIMARY KEY (`aut_codigo`);

--
-- Indices de la tabla `tbl_libro`
--
ALTER TABLE `tbl_libro`
  ADD PRIMARY KEY (`lib_isbn`),
  ADD KEY `idx_titulo` (`lib_titulo`);

--
-- Indices de la tabla `tbl_prestamo`
--
ALTER TABLE `tbl_prestamo`
  ADD PRIMARY KEY (`pres_id`),
  ADD KEY `soc_copiaNumero` (`soc_copiaNumero`),
  ADD KEY `lib_copiaisbn` (`lib_copiaisbn`);

--
-- Indices de la tabla `tbl_socio`
--
ALTER TABLE `tbl_socio`
  ADD PRIMARY KEY (`soc_numero`);

--
-- Indices de la tabla `tbl_tipoautores`
--
ALTER TABLE `tbl_tipoautores`
  ADD KEY `copiaisbn` (`copiaisbn`),
  ADD KEY `copiaAutor` (`copiaAutor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `audi_autor`
--
ALTER TABLE `audi_autor`
  MODIFY `aut_codigo_audi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `audi_libro`
--
ALTER TABLE `audi_libro`
  MODIFY `lib_isbn_audi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  MODIFY `id_audi` int(10) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_prestamo`
--
ALTER TABLE `tbl_prestamo`
  ADD CONSTRAINT `tbl_prestamo_ibfk_1` FOREIGN KEY (`soc_copiaNumero`) REFERENCES `tbl_socio` (`soc_numero`),
  ADD CONSTRAINT `tbl_prestamo_ibfk_2` FOREIGN KEY (`lib_copiaisbn`) REFERENCES `tbl_libro` (`lib_isbn`);

--
-- Filtros para la tabla `tbl_tipoautores`
--
ALTER TABLE `tbl_tipoautores`
  ADD CONSTRAINT `tbl_tipoautores_ibfk_1` FOREIGN KEY (`copiaisbn`) REFERENCES `tbl_libro` (`lib_isbn`),
  ADD CONSTRAINT `tbl_tipoautores_ibfk_2` FOREIGN KEY (`copiaAutor`) REFERENCES `tbl_autor` (`aut_codigo`);

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `minuto_Aliminar_prestamos` ON SCHEDULE EVERY 1 MINUTE STARTS '2024-08-08 06:52:29' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN 
	DELETE FROM tbl_prestamo
    WHERE pres_fechaPrestamo <= NOW()  - INTERVAL 1 YEAR;
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
