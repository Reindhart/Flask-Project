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
  `nombre_u` varchar(12) DEFAULT NULL,
  `correo_u` varchar(25) DEFAULT NULL,
  `clave_u` varchar(100) DEFAULT NULL,
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
-- Table structure for table `carritos`
--

DROP TABLE IF EXISTS `carritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carritos` (
  `id_ca` int(11) NOT NULL AUTO_INCREMENT,
  `FK_Cliente` int(11) NOT NULL,
  `id_sesion` int(11) NOT NULL,
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
  `telefono_c` varchar(10) NOT NULL,
  `direccion_c` mediumtext NOT NULL,
  `clave_c` varchar(100) NOT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'pepe','alog@gmail.com','151515','sus','$2b$12$44k3qv0QFWkxwV4IH8xvMOd1cZ0tW0CkxpfKQviSta718n3qkCG6G'),(2,'asd','asd@gmail.com','','','$2b$12$JKOdvzed8/kgDIbuI2Xg3.4DU2SGqIYvUNygAgbTJOEppmSpRxhhq'),(3,'alfonso','zxc@gmail.com','','','$2b$12$aw6oWrWwnBQTa72bnIAdrO.3GrTlRa8jgebzrht4Q9.pcn3R5MQK6'),(4,'poi','poi@gmail.com','123123','zxc','$2b$12$9OoJy1vQmZ/gqpfAP5eqcuZcwRRGC0bmT39zgMbw.0DoG54QYCwWi'),(5,'fgh','fgh@fgh','','','$2b$12$o8BLtkCgR4mzCspwGPT/0utsOTxNxkK0jBWQzhZKVNXB9NEUFvEOq');
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
  `descripcion` mediumtext NOT NULL,
  `existencia` int(11) NOT NULL,
  `imagen` varchar(30) NOT NULL,
  PRIMARY KEY (`id_p`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'SUPER BIRD CREACIONES WIGGLES',294.17,'Los juguetes destructibles satisfacen la necesidad instintiva de un pájaro para masticar. Diseños de juguete de Super pájaro diseños utilizan una selección diversa de materiales de seguridad para asegurar el mental y bienestar físico de pájaros para mascotas',150,'juguetes1.png'),(2,'RedKite alimento p/pato juvenil 1 KG',59.2,'Alimento balanceado para patos juveniles durante las primeras 24 horas de vida hasta el 1° año',100,'alimento1.png'),(3,'SlowTon Arnés de Coche para Pato con Correa de Conector',368.54,'El arnés de chaleco tiene un acoplamiento respirable que aliviaría la presión. Es ajustable dependiendo de la cantidad de camino de plomo que necesita para conectar a su cinturón de seguridad de los coches que encajan perfectamente.',80,'arnes1.png'),(4,'Bebedero Para Patos 1L',39,'Evita derrames con este bebedero autodespachable para patos, impide que tus pato se queden sin agua y solo sirve lo que necesita beber. Práctico y desarmable para lavar.',100,'bebedero1.png'),(5,'HYONAN Comedero para Patos',326.09,'La forma más fácil de alimentar a sus polluelos, patos y gallinas: ya sea que tenga tres o cuatro pollos, o una bandada entera, alimentarlos no es pan comido. Sin embargo, SatisPet está aquí para hacerte la vida más fácil con esta fantástica cubeta de alimentación que te ayudará a minimizar el derrame, mantener tu gallinero limpio y tus aves bien alimentadas.',120,'comedero1.png'),(6,'Pawhut Corral de Madera para Exteriores',2695.05,'Gallinero muy equipado de dos pisos. El piso inferior está cercado por alambre para proteger a los animales, pero al mismo tiempo para disfrutar del aire libre. En el piso superior hay una caseta cubierta para dormir y un nido, que permite acceder des del exterior. Ambos pisos están conectados con una rampa.',300,'casas1.png'),(7,'OMAS Pañal ajustable de paño para pato',219.09,'Pañales de tela para patos. Nuestros pañales son increíblemente fáciles de poner, muy ajustables y tienen un forro a prueba de agua en la bolsa. La forma \'V\' en nuestros pañales le permite copa alrededor de la cola del pato para proporcionar un mejor ajuste sin ser demasiado apretado. Utilizamos todo elástico con una hebilla, Esto nos permite hacer un pañal casi único para todos y lo hace más cómodo para tu pato',60,'ropa1.png'),(8,'Röhnfried - Complemento alimenticio para Bienestar digestivo',280.26,'Apoyo digestivo y crianza más fácil: mejora la salud intestinal y reduce las pérdidas de cría gracias al pienso complementario con efecto natural.\r\nComplemento alimenticio adecuado para la cría de patos con ingredientes de alta calidad, naturales y probados que consisten en orégano y liquen de barba',90,'vitaminas1.png'),(9,'PawHut Bañera Plegable ',1025.08,'Bañera compuesta por 22 piezas de paneles de madera. Estructura muy sólida Cubierta de PVC repelente al agua y a la suciedad, Piscina para mascotas plegable y fácil de almacenar y transportar, Tiene una válvula de drenaje que permite evacuar el agua cuando finalices de usarla',240,'varios1.png'),(10,'Manna Pro Duck Starter Grower Crumble',881.34,'Alimento completo para patos jóvenes; Nutrición equilibrada para apoyar patos fuertes y saludables; Formulado con probióticos para apoyar la salud intestinal y la digestión; No medicado, sin antibióticos; Sin colores artificiales',270,'alimento3.png'),(13,'asd',123,'',123,'asd'),(14,'zxc',123,'jhhgkghk',123,'default.png');
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
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
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
  `fecha` date DEFAULT NULL,
  `FK_Cliente` int(11) DEFAULT NULL,
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-25  5:28:25
