-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 03-12-2020 a las 17:12:44
-- Versión del servidor: 5.7.31-log
-- Versión de PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `duckyshop`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id_u` int(2) NOT NULL,
  `nombre_u` varchar(12) DEFAULT NULL,
  `correo_u` varchar(25) DEFAULT NULL,
  `clave_u` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id_u`, `nombre_u`, `correo_u`, `clave_u`) VALUES
(1, 'Reindhart', 'japp.banjo@gmail.com', '1256897463lol'),
(2, 'Filling', 'elpepe@gmail.com', 'J#iebNETL2Tv1YR*hRf@n58T'),
(3, 'Bonfett', 'fylobidojy-2163@gmail.com', 'Mi%A7EzSRW#X$H4c!MeNPCjC'),
(4, 'Jorge', 'nudogalu-4992@gmail.com', 'kvBctQoUdTe4V*tD4H1@^rv9'),
(5, 'Pikachu', 'vurkezigno@gmail.com', 'YN$!utP&CxyJRPmOiU43K6Uc'),
(6, 'Federico', 'f3d3r1c0@gmail.com', 'LuO%kTWw%*Gl0Di*yi8#Ta&6'),
(7, 'Rodrigo', 'samus20@gmail.com', '^u!DBaNCc!VHv*sTMrVxLv3J'),
(8, 'Joseju', 'sanchezlopez@gmail.com', '*xnUW*ru8RIZ*wveb&DLyH9g'),
(9, 'MisterCarlos', 'curiosowichu96@gmail.com', 'Fg%P6WS@dr!#%DsStb7CUj1T'),
(10, 'Joan', 'cosarandom@gmail.com', 'oG!#pyoBBEStBf10#laVyBsA'),
(11, 'SoyAdmin', 'admin@gmail.com', '$2b$12$gr58J8iB7hh1BaJwlmb9TOLKUDT4pZ1BtkjHvqfbvX8/BYAGg9Egu');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id_ca` int(11) NOT NULL,
  `id_p` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `importe` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_c` int(11) NOT NULL,
  `nombre_c` char(50) COLLATE utf8_spanish_ci NOT NULL,
  `correo_c` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `telefono_c` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `direccion_c` text COLLATE utf8_spanish_ci NOT NULL,
  `clave_c` varchar(100) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_c`, `nombre_c`, `correo_c`, `telefono_c`, `direccion_c`, `clave_c`) VALUES
(1, 'Rosa Mendez', 'rosa@gmail.com', '8888888888', 'la rosa #890', '1523'),
(2, 'Joan Piña', 'joan@gmail.com', '9999999999', 'la piña #666', '9843'),
(3, 'Luis Ocaranza', 'luis@gmail.com', '1111111111', 'valdepeñas #975', '1753'),
(4, 'Patricia Sanchez', 'patricia@gmail.com', '2222222222', 'haciendas del valle #501', '5431'),
(5, 'Alma Elias', 'alma@gmail.com', '3333333333', 'la cima #218', '7562'),
(6, 'Juan Monrroy', 'juan@gmail.com', '4444444444', 'hilasal #508', '2193'),
(7, 'Andrea Puga', 'andrea@gmail.com', '5555555555', 'egipto #442', '7462'),
(8, 'Timoteo Smith', 'timoteo@gmail.com', '6666666666', 'oracle #954', '1821'),
(9, 'Reindhart Belmont', 'reindhart@gmail.com', '7777777777', 'rio nilo #301', '1935'),
(10, 'Gordon Freeman', 'gordon@gmail.com', '1234567890', 'valle real #178', '3540'),
(11, 'Superyeet', 'yeet@gmail.com', '3621654', 'onasdnasd', '$2b$12$gr58J8iB7hh1BaJwlmb9TOLKUDT4pZ1BtkjHvqfbvX8/BYAGg9Egu'),
(12, 'asd', 'asd@gmail.com', '123', 'asd123', '$2b$12$Rrt/WpB3KR2DycaBZHJ/xO6X3pNgkJ7Fbh75jeuxjmFKfkoIjyE9i'),
(13, 'qwe', 'qwe@gmail.com', '1234', 'qwe1234', '$2b$12$N2MZTkdInriF1h/TvHJP8uPlJ9sruYatuNtzywCIB5SYnk5wgi9v2'),
(14, 'poi', 'poi@gmail.com', '134654', 'poi', '$2b$12$ckW.lqoWeIpAoTLs.4fMV.lQEiMjk/1xNsbuOepy0VIf6azPbpQcG'),
(15, 'tyui', 'yui@gmail.com', '1234', 'asd123', '$2b$12$AdQPPAAzUrfwkGiNvNvc7.LjGFT9SNb8rvgaKjkT2EcBhQuwm7PmO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_p` int(11) NOT NULL,
  `nombre_p` text COLLATE utf8_spanish_ci NOT NULL,
  `precio` float NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `existencia` int(11) NOT NULL,
  `imagen` varchar(30) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_p`, `nombre_p`, `precio`, `descripcion`, `existencia`, `imagen`) VALUES
(1, 'SUPER BIRD CREACIONES WIGGLES', 294.17, 'Los juguetes destructibles satisfacen la necesidad instintiva de un pájaro para masticar. Diseños de juguete de Super pájaro diseños utilizan una selección diversa de materiales de seguridad para asegurar el mental y bienestar físico de pájaros para mascotas', 150, 'juguetes1.png'),
(2, 'RedKite alimento p/pato juvenil 1 KG', 59.2, 'Alimento balanceado para patos juveniles durante las primeras 24 horas de vida hasta el 1° año', 100, 'alimento1.png'),
(3, 'SlowTon Arnés de Coche para Pato con Correa de Conector', 368.54, 'El arnés de chaleco tiene un acoplamiento respirable que aliviaría la presión. Es ajustable dependiendo de la cantidad de camino de plomo que necesita para conectar a su cinturón de seguridad de los coches que encajan perfectamente.', 80, 'arnes1.png'),
(4, 'Bebedero Para Patos 1L', 39, 'Evita derrames con este bebedero autodespachable para patos, impide que tus pato se queden sin agua y solo sirve lo que necesita beber. Práctico y desarmable para lavar.', 100, 'bebedero1.png'),
(5, 'HYONAN Comedero para Patos', 326.09, 'La forma más fácil de alimentar a sus polluelos, patos y gallinas: ya sea que tenga tres o cuatro pollos, o una bandada entera, alimentarlos no es pan comido. Sin embargo, SatisPet está aquí para hacerte la vida más fácil con esta fantástica cubeta de alimentación que te ayudará a minimizar el derrame, mantener tu gallinero limpio y tus aves bien alimentadas.', 120, 'comedero1.png'),
(6, 'Pawhut Corral de Madera para Exteriores', 2695.05, 'Gallinero muy equipado de dos pisos. El piso inferior está cercado por alambre para proteger a los animales, pero al mismo tiempo para disfrutar del aire libre. En el piso superior hay una caseta cubierta para dormir y un nido, que permite acceder des del exterior. Ambos pisos están conectados con una rampa.', 300, 'casas1.png'),
(7, 'OMAS Pañal ajustable de paño para pato', 219.09, 'Pañales de tela para patos. Nuestros pañales son increíblemente fáciles de poner, muy ajustables y tienen un forro a prueba de agua en la bolsa. La forma \'V\' en nuestros pañales le permite copa alrededor de la cola del pato para proporcionar un mejor ajuste sin ser demasiado apretado. Utilizamos todo elástico con una hebilla, Esto nos permite hacer un pañal casi único para todos y lo hace más cómodo para tu pato', 60, 'ropa1.png'),
(8, 'Röhnfried - Complemento alimenticio para Bienestar digestivo', 280.26, 'Apoyo digestivo y crianza más fácil: mejora la salud intestinal y reduce las pérdidas de cría gracias al pienso complementario con efecto natural.\r\nComplemento alimenticio adecuado para la cría de patos con ingredientes de alta calidad, naturales y probados que consisten en orégano y liquen de barba', 90, 'vitaminas1.png'),
(9, 'PawHut Bañera Plegable ', 1025.08, 'Bañera compuesta por 22 piezas de paneles de madera. Estructura muy sólida Cubierta de PVC repelente al agua y a la suciedad, Piscina para mascotas plegable y fácil de almacenar y transportar, Tiene una válvula de drenaje que permite evacuar el agua cuando finalices de usarla', 240, 'varios1.png'),
(10, 'Manna Pro Duck Starter Grower Crumble', 881.34, 'Alimento completo para patos jóvenes; Nutrición equilibrada para apoyar patos fuertes y saludables; Formulado con probióticos para apoyar la salud intestinal y la digestión; No medicado, sin antibióticos; Sin colores artificiales', 270, 'alimento3.png'),
(13, 'asd', 123, '', 123, 'asd');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_v` int(11) NOT NULL,
  `id_c` int(11) NOT NULL,
  `id_ca` int(11) NOT NULL,
  `modo_pago` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `modo_envio` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_entrega` date NOT NULL,
  `total` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_u`);

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id_ca`),
  ADD KEY `id_p` (`id_p`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_c`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_p`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id_v`),
  ADD KEY `id_u` (`id_c`),
  ADD KEY `id_ca` (`id_ca`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id_u` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id_ca` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_c` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_p` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`id_p`) REFERENCES `producto` (`id_p`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`id_ca`) REFERENCES `carrito` (`id_ca`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`id_c`) REFERENCES `clientes` (`id_c`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
