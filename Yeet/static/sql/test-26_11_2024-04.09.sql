-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `test`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `test` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `test`;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id_u` int(2) NOT NULL AUTO_INCREMENT,
  `nombre_u` varchar(12) NOT NULL,
  `correo_u` varchar(25) NOT NULL,
  `clave_u` varchar(100) NOT NULL,
  PRIMARY KEY (`id_u`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (15,'pedro','qwe@gmail.com','$2b$12$RBz1/uAxvdW7Qg5mT6Wo4eWsMHFIf1MBTqBsxKX.zwGvakZlogA8.');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrito`
--

DROP TABLE IF EXISTS `carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carrito` (
  `id_ca` int(11) NOT NULL AUTO_INCREMENT,
  `id_p` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `importe` float NOT NULL,
  PRIMARY KEY (`id_ca`),
  KEY `id_p` (`id_p`),
  CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`id_p`) REFERENCES `producto` (`id_p`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
/*!40000 ALTER TABLE `carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carritos`
--

DROP TABLE IF EXISTS `carritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carritos` (
  `id_ca` int(11) NOT NULL AUTO_INCREMENT,
  `FK_Cliente` int(11) DEFAULT NULL,
  `id_sesion` varchar(36) NOT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_ca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carritos`
--

LOCK TABLES `carritos` WRITE;
/*!40000 ALTER TABLE `carritos` DISABLE KEYS */;
/*!40000 ALTER TABLE `carritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `id_c` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_c` char(50) NOT NULL,
  `correo_c` varchar(50) NOT NULL,
  `telefono_c` varchar(10) DEFAULT NULL,
  `direccion_c` mediumtext DEFAULT NULL,
  `clave_c` varchar(100) NOT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'pepe','alog@gmail.com','151515','sus','$2b$12$44k3qv0QFWkxwV4IH8xvMOd1cZ0tW0CkxpfKQviSta718n3qkCG6G'),(2,'asd','asd@gmail.com','','','$2b$12$JKOdvzed8/kgDIbuI2Xg3.4DU2SGqIYvUNygAgbTJOEppmSpRxhhq'),(3,'alfonso','zxc@gmail.com','','','$2b$12$aw6oWrWwnBQTa72bnIAdrO.3GrTlRa8jgebzrht4Q9.pcn3R5MQK6'),(4,'poi','poi@gmail.com','123123','zxc','$2b$12$9OoJy1vQmZ/gqpfAP5eqcuZcwRRGC0bmT39zgMbw.0DoG54QYCwWi'),(5,'fgh','fgh@fgh','','','$2b$12$o8BLtkCgR4mzCspwGPT/0utsOTxNxkK0jBWQzhZKVNXB9NEUFvEOq'),(6,'Juan Pérez','juan.perez@email.com','555-0101','Calle Ficticia 123, Ciudad, País','$2b$12$fpGfIu1Vm1lJ5kGbPlXgEO6qZXZ10XBxTbA9.wzIEHzfG28Tz8gtC'),(7,'María García','maria.garcia@email.com','555-0102','Avenida Libertad 456, Ciudad, País','$2b$12$8q1g1y.A9dZ7jz9V0s6de17NS8mTeewjMEyy18eGGvV.t.uyF6fR2'),(8,'José Rodríguez','jose.rodriguez@email.com','555-0103','Calle Sol 789, Ciudad, País','$2b$12$0G37sbUWsB60g7Kz81D9Ydlcb7j4e/Zu1p6S9dIltp36svs9uW/nK'),(9,'Ana López','ana.lopez@email.com','555-0104','Boulevard del Río 101, Ciudad, País','$2b$12$gcCZjTnk0FdoyzSbtaLqY6ob8Ob81XGb3FxxghwLnW80yAWd5t1P6'),(10,'Carlos Fernández','carlos.fernandez@email.com','555-0105','Calle Nueva 202, Ciudad, País','$2b$12$Fgt50UzOlJ6aR3zRzMcbb5Rfgxh3KkxeK0dfBLGZXYbbRQST01WJe'),(11,'Laura Martínez','laura.martinez@email.com','555-0106','Avenida de la Paz 303, Ciudad, País','$2b$12$8xrtUwv/Jv6tqItJupq0SOcbzYg9lqtsOW0nCGztzYrcwjjdp8d.m'),(12,'David Sánchez','david.sanchez@email.com','555-0107','Calle La Plata 404, Ciudad, País','$2b$12$4Ue.Omk8tozD03jmV7XJtYykIkLv3zPjwnmjPjEq2RtU6tW3pGRoy'),(13,'Marta González','marta.gonzalez@email.com','555-0108','Avenida Santa Fe 505, Ciudad, País','$2b$12$kT.G4t5fOq9sT8X0gAOzVq7Ox8WR8Tcge3c6VpqZqrz5BhqRMm7Vu'),(14,'Luis Pérez','luis.perez@email.com','555-0109','Calle Bella Vista 606, Ciudad, País','$2b$12$zkxlPBRcNl/DXvX9A8HbchSzxgP8Avdcbud1Wjx6N0RdeInng6OwW'),(15,'Sofía Gómez','sofia.gomez@email.com','555-0110','Calle del Sol 707, Ciudad, País','$2b$12$P.ZjNGp4st33G2hs9G9J9W6ZjyslZmrSSg1VlkbfkpBpXJUKA5HUS'),(16,'Pedro Martín','pedro.martin@email.com','555-0111','Calle del Mar 808, Ciudad, País','$2b$12$H8nnsDsIWv68vqG6D25JDu9NeJl7zErVImxLdiF.0uoW0tfQ.d9ie'),(17,'Elena Sánchez','elena.sanchez@email.com','555-0112','Calle Mayor 909, Ciudad, País','$2b$12$WoVpmXs8YeFEpWl.NKJ0s6t1cPo2gXfCvRY4HkdF7hUB6NfUVrg8y'),(18,'Álvaro Torres','alvaro.torres@email.com','555-0113','Calle la Luna 1010, Ciudad, País','$2b$12$DNe2TfU9jkj2p.OV9yRu7Wvk9FcsosTKOGN3pfbuTtOKvQTxHvle0'),(19,'Carmen Díaz','carmen.diaz@email.com','555-0114','Avenida Andalucía 1111, Ciudad, País','$2b$12$RH68h0gvk79BdErHzF0QYe9rZos0Swh9mfuELkn9gICtC03w.zOX6'),(20,'Fernando Ruiz','fernando.ruiz@email.com','555-0115','Calle de la Esperanza 1212, Ciudad, País','$2b$12$Tgx51M7M3ItSpxf2l/jJ7nm2or2lxf1AZjxdk5lH0HYO21vnbswZq'),(21,'Isabel Jiménez','isabel.jimenez@email.com','555-0116','Avenida del Sol 1313, Ciudad, País','$2b$12$Hes0Dtb3RlC9eq/hbcXzBfDOwVeB9ioB9gr4h2GVxUslmFVtKInqPq'),(22,'José Luis Hernández','jose.luis.hernandez@email.com','555-0117','Calle 23 de Octubre 1414, Ciudad, País','$2b$12$5YWQxbjvq23E19u1Hqmf5iItJxGBeqAOSNxAqkgL1KT5pp3RYhr3G'),(23,'Patricia García','patricia.garcia@email.com','555-0118','Calle Libertador 1515, Ciudad, País','$2b$12$ZlKxyXps6wH2tFc3NOZXqsGqbhhU4GIn7pVmYPXHeOUYcF0FO2cK2'),(24,'Antonio Fernández','antonio.fernandez@email.com','555-0119','Calle del Río 1616, Ciudad, País','$2b$12$DmfYhBcdk3xo0tIqhmRJgIpe4DC.0eYyFv5m1iE9aB9.PnL00mMry'),(25,'Susana García','susana.garcia@email.com','555-0120','Avenida de los Olivos 1717, Ciudad, País','$2b$12$ckS9lhXkCwx32nM57g1/9ueUox5aA0b0a84aJmv5s1U.8gqGyjPiW');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_carrito`
--

DROP TABLE IF EXISTS `detalle_carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_carrito` (
  `id_deCa` int(11) NOT NULL AUTO_INCREMENT,
  `FK_Carritos` int(11) NOT NULL,
  `FK_Producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_deCa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_carrito`
--

LOCK TABLES `detalle_carrito` WRITE;
/*!40000 ALTER TABLE `detalle_carrito` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_f_compra`
--

DROP TABLE IF EXISTS `detalle_f_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_f_compra` (
  `id_Detalle_Compra` bigint(20) NOT NULL AUTO_INCREMENT,
  `Cantidad` int(11) DEFAULT NULL,
  `Precio_Compra` double(12,2) DEFAULT NULL,
  `FK_Factura_Compra` bigint(20) DEFAULT NULL,
  `FK_Producto` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Detalle_Compra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_f_compra`
--

LOCK TABLES `detalle_f_compra` WRITE;
/*!40000 ALTER TABLE `detalle_f_compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_f_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_f_venta`
--

DROP TABLE IF EXISTS `detalle_f_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_f_venta` (
  `id_Detalle_Venta` bigint(20) NOT NULL AUTO_INCREMENT,
  `Cantidad` int(11) DEFAULT NULL,
  `Precio_Venta` double(12,2) DEFAULT NULL,
  `FK_Factura_Venta` bigint(20) DEFAULT NULL,
  `FK_Producto` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Detalle_Venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_f_venta`
--

LOCK TABLES `detalle_f_venta` WRITE;
/*!40000 ALTER TABLE `detalle_f_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_f_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura_compra`
--

DROP TABLE IF EXISTS `factura_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura_compra` (
  `Folio_Compra` bigint(20) NOT NULL,
  `fecha` date DEFAULT NULL,
  `FK_Proveedor` int(11) DEFAULT NULL,
  PRIMARY KEY (`Folio_Compra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura_compra`
--

LOCK TABLES `factura_compra` WRITE;
/*!40000 ALTER TABLE `factura_compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `factura_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `id_p` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_p` mediumtext NOT NULL,
  `precio` float NOT NULL,
  `categoria` varchar(20) DEFAULT NULL,
  `descripcion` mediumtext DEFAULT NULL,
  `existencia` int(11) NOT NULL,
  `imagen` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_p`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'SUPER BIRD CREACIONES WIGGLES',294.17,'Juguetes','Los juguetes destructibles satisfacen la necesidad instintiva de un pájaro para masticar. Diseños de juguete de Super pájaro diseños utilizan una selección diversa de materiales de seguridad para asegurar el mental y bienestar físico de pájaros para mascotas',150,'juguetes1.png'),(2,'RedKite alimento p/pato juvenil 1 KG',59.2,'Alimentos','Alimento balanceado para patos juveniles durante las primeras 24 horas de vida hasta el 1° año',100,'alimento1.png'),(3,'SlowTon Arnés de Coche para Pato con Correa de Conector',368.54,'Accesorios','El arnés de chaleco tiene un acoplamiento respirable que aliviaría la presión. Es ajustable dependiendo de la cantidad de camino de plomo que necesita para conectar a su cinturón de seguridad de los coches que encajan perfectamente.',80,'arnes1.png'),(4,'Bebedero Para Patos 1L',39,'Accesorios','Evita derrames con este bebedero autodespachable para patos, impide que tus pato se queden sin agua y solo sirve lo que necesita beber. Práctico y desarmable para lavar.',100,'bebedero1.png'),(5,'HYONAN Comedero para Patos',326.09,'Accesorios','La forma más fácil de alimentar a sus polluelos, patos y gallinas: ya sea que tenga tres o cuatro pollos, o una bandada entera, alimentarlos no es pan comido. Sin embargo, SatisPet está aquí para hacerte la vida más fácil con esta fantástica cubeta de alimentación que te ayudará a minimizar el derrame, mantener tu gallinero limpio y tus aves bien alimentadas.',120,'comedero1.png'),(6,'Pawhut Corral de Madera para Exteriores',2695.05,'Viviendas','Gallinero muy equipado de dos pisos. El piso inferior está cercado por alambre para proteger a los animales, pero al mismo tiempo para disfrutar del aire libre. En el piso superior hay una caseta cubierta para dormir y un nido, que permite acceder des del exterior. Ambos pisos están conectados con una rampa.',300,'casas1.png'),(7,'OMAS Pañal ajustable de paño para pato',219.09,'Accesorios','Pañales de tela para patos. Nuestros pañales son increíblemente fáciles de poner, muy ajustables y tienen un forro a prueba de agua en la bolsa. La forma \'V\' en nuestros pañales le permite copa alrededor de la cola del pato para proporcionar un mejor ajuste sin ser demasiado apretado. Utilizamos todo elástico con una hebilla, Esto nos permite hacer un pañal casi único para todos y lo hace más cómodo para tu pato',60,'ropa1.png'),(8,'Röhnfried - Complemento alimenticio para Bienestar digestivo',280.26,'Suplementos','Apoyo digestivo y crianza más fácil: mejora la salud intestinal y reduce las pérdidas de cría gracias al pienso complementario con efecto natural.\r\nComplemento alimenticio adecuado para la cría de patos con ingredientes de alta calidad, naturales y probados que consisten en orégano y liquen de barba',90,'vitaminas1.png'),(9,'PawHut Bañera Plegable ',1025.08,'Accesorios','Bañera compuesta por 22 piezas de paneles de madera. Estructura muy sólida Cubierta de PVC repelente al agua y a la suciedad, Piscina para mascotas plegable y fácil de almacenar y transportar, Tiene una válvula de drenaje que permite evacuar el agua cuando finalices de usarla',240,'varios1.png'),(10,'Manna Pro Duck Starter Grower Crumble',881.34,'Alimentos','Alimento completo para patos jóvenes; Nutrición equilibrada para apoyar patos fuertes y saludables; Formulado con probióticos para apoyar la salud intestinal y la digestión; No medicado, sin antibióticos; Sin colores artificiales',270,'alimento3.png'),(15,'Comida para canarios',15.99,'Cuidado','Alimento nutritivo para canarios, en presentación de 500g.',100,'canarios.jpg'),(16,'Jaula para periquitos',40.5,'Viviendas','Jaula espaciosa para periquitos, con comederos y perchas.',50,'jaula_periquitos.jpg'),(17,'Juguete para loros',9.99,'Juguetes','Juguete interactivo para loros, hecho de madera natural.',200,'juguete_loros.jpg'),(18,'Suplemento vitamínico para aves',12,'Cuidado','Suplemento vitamínico para aves exóticas, en formato líquido.',75,'suplemento_vitaminico.jpg'),(19,'Piedra de calcio para aves',3.5,'Cuidado','Piedra de calcio para el pico y huesos de las aves.',150,'piedra_calcio.jpg'),(20,'Comida para agapornis',17.25,'Alimentos','Alimento balanceado para agapornis, 1 kg.',120,'agapornis.jpg'),(21,'Perchas de madera para aves',7.99,'Perchas','Perchas naturales de madera para aves, tamaño grande.',180,'perchas_madera.jpg'),(22,'Vivienda para cotorras',55,'Viviendas','Casa cómoda y segura para cotorras, con espacio para volar.',30,'vivienda_cotorras.jpg'),(23,'Cepillo para plumas',6,'Accesorios','Cepillo suave para el cuidado de las plumas de las aves.',90,'cepillo_plumas.jpg'),(24,'Bebedero para pájaros',4.99,'Accesorios','Bebedero automático para aves, fácil de instalar en la jaula.',200,'bebedero_pajaros.jpg'),(25,'Comida para loros',22.75,'Alimentos','Alimento de alta calidad para loros grandes, 1.5 kg.',60,'comida_loros.jpg'),(26,'Gateras para aves',5.99,'Accesorios','Gatera para aves pequeñas, ideal para descansar y dormir.',110,'gatera_aves.jpg'),(27,'Aceite de oliva para aves',8.99,'Cuidado','Aceite de oliva natural para el brillo del plumaje.',85,'aceite_oliva_aves.jpg'),(28,'Baño para aves',14,'Accesorios','Bañera para aves pequeñas, de plástico resistente y fácil de limpiar.',50,'bano_aves.jpg'),(29,'Alimento para aves exóticas',19.99,'Alimentos','Alimento especializado para aves exóticas, mezcla de semillas y frutas.',130,'alimento_exoticas.jpg'),(30,'Planta de interior para aves',25,NULL,'Planta natural segura para aves, ideal para decorar la jaula.',70,'planta_aves.jpg'),(31,'Caja nido para aves',12.5,NULL,'Caja nido de madera natural, adecuada para aves reproductoras.',40,'caja_nido.jpg'),(32,'Comida para palomas',11.75,'Alimentos','Alimento especial para palomas, 1 kg.',160,'comida_palomas.jpg'),(33,'Hueso de sepia para aves',2.99,'Cuidado','Hueso de sepia natural, fuente de calcio para aves.',250,'hueso_sepias.jpg'),(34,'Tenedor de semillas para aves',5.49,'Accesorios','Tenedor de semillas para aves, ideal para evitar desperdicio.',220,'tenedor_semillas.jpg');
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `asesor` varchar(35) NOT NULL,
  `correo` varchar(80) DEFAULT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Walmart','',NULL,NULL,NULL),(2,'Amazon','',NULL,NULL,NULL),(3,'Best Buy','',NULL,NULL,NULL),(4,'Costco','',NULL,NULL,NULL),(5,'Home Depot','',NULL,NULL,NULL),(6,'Lowe\'s','',NULL,NULL,NULL),(7,'Target','',NULL,NULL,NULL),(8,'Walgreens','',NULL,NULL,NULL),(9,'CVS Health','',NULL,NULL,NULL),(10,'Apple Inc.','',NULL,NULL,NULL),(11,'Microsoft','',NULL,NULL,NULL),(12,'Sony Corporation','',NULL,NULL,NULL),(13,'Samsung Electronics','',NULL,NULL,NULL),(14,'LG Electronics','',NULL,NULL,NULL),(15,'Nike Inc.','',NULL,NULL,NULL),(16,'Adidas AG','',NULL,NULL,NULL),(17,'Coca-Cola Company','',NULL,NULL,NULL),(18,'PepsiCo Inc.','',NULL,NULL,NULL),(19,'Nestlé SA','',NULL,NULL,NULL),(20,'Unilever','',NULL,NULL,NULL),(21,'Procter & Gamble','',NULL,NULL,NULL),(22,'Johnson & Johnson','',NULL,NULL,NULL),(23,'IBM Corporation','',NULL,NULL,NULL),(24,'Intel Corporation','',NULL,NULL,NULL),(25,'Oracle Corporation','',NULL,NULL,NULL);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venta` (
  `folio_venta` bigint(20) NOT NULL,
  `fecha` date NOT NULL,
  `FK_Cliente` int(11) NOT NULL,
  PRIMARY KEY (`folio_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vista_existencia_baja`
--

DROP TABLE IF EXISTS `vista_existencia_baja`;
/*!50001 DROP VIEW IF EXISTS `vista_existencia_baja`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vista_existencia_baja` AS SELECT
 1 AS `nombre_p`,
  1 AS `categoria`,
  1 AS `existencia` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_precio_promedio_categoria`
--

DROP TABLE IF EXISTS `vista_precio_promedio_categoria`;
/*!50001 DROP VIEW IF EXISTS `vista_precio_promedio_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vista_precio_promedio_categoria` AS SELECT
 1 AS `categoria`,
  1 AS `precio_promedio` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_ventas_totales_categoria`
--

DROP TABLE IF EXISTS `vista_ventas_totales_categoria`;
/*!50001 DROP VIEW IF EXISTS `vista_ventas_totales_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vista_ventas_totales_categoria` AS SELECT
 1 AS `categoria`,
  1 AS `total_ventas` */;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `test`
--

USE `test`;

--
-- Final view structure for view `vista_existencia_baja`
--

/*!50001 DROP VIEW IF EXISTS `vista_existencia_baja`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_existencia_baja` AS select `producto`.`nombre_p` AS `nombre_p`,`producto`.`categoria` AS `categoria`,`producto`.`existencia` AS `existencia` from `producto` where `producto`.`existencia` < 70 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_precio_promedio_categoria`
--

/*!50001 DROP VIEW IF EXISTS `vista_precio_promedio_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_precio_promedio_categoria` AS select `producto`.`categoria` AS `categoria`,avg(`producto`.`precio`) AS `precio_promedio` from `producto` group by `producto`.`categoria` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_ventas_totales_categoria`
--

/*!50001 DROP VIEW IF EXISTS `vista_ventas_totales_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_ventas_totales_categoria` AS select `producto`.`categoria` AS `categoria`,sum(`producto`.`precio` * `producto`.`existencia`) AS `total_ventas` from `producto` group by `producto`.`categoria` having `total_ventas` > 5000 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-26  4:10:18
