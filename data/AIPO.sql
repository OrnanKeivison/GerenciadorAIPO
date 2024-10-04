-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: aipo
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `perfil`
--

DROP TABLE IF EXISTS `perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil` (
  `nome` varchar(100) DEFAULT NULL,
  `id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
INSERT INTO `perfil` VALUES ('admin',1),('usuário',2);
/*!40000 ALTER TABLE `perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `porta`
--

DROP TABLE IF EXISTS `porta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `porta` (
  `nome` varchar(100) DEFAULT NULL,
  `id` varchar(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `porta`
--

LOCK TABLES `porta` WRITE;
/*!40000 ALTER TABLE `porta` DISABLE KEYS */;
INSERT INTO `porta` VALUES ('lab. de robótica e automação','A208'),('lab. Maker','A211');
/*!40000 ALTER TABLE `porta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portausuario`
--

DROP TABLE IF EXISTS `portausuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portausuario` (
  `idPorta` varchar(4) NOT NULL,
  `codigoUsuario` varchar(100) NOT NULL,
  PRIMARY KEY (`idPorta`,`codigoUsuario`),
  KEY `fk_codigoUsuarioAcessa_idx` (`codigoUsuario`),
  CONSTRAINT `fk_codigoUsuarioAcessa` FOREIGN KEY (`codigoUsuario`) REFERENCES `usuario` (`codigo`),
  CONSTRAINT `fk_idPortaAcessa` FOREIGN KEY (`idPorta`) REFERENCES `porta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portausuario`
--

LOCK TABLES `portausuario` WRITE;
/*!40000 ALTER TABLE `portausuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `portausuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `matricula` varchar(14) DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `senha` varchar(8) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `codigo` varchar(100) NOT NULL,
  `idPerfil` int NOT NULL,
  PRIMARY KEY (`codigo`,`idPerfil`),
  UNIQUE KEY `unique_email` (`email`),
  UNIQUE KEY `unique_matricula` (`matricula`),
  KEY `fk_idPerfilUsuario_idx` (`idPerfil`),
  CONSTRAINT `fk_idPerfilUsuario` FOREIGN KEY (`idPerfil`) REFERENCES `perfil` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('20221174010009','Ornã Câmara','26052905','ornakeivisonf@gmail.com','A1B2C3D4',1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-04 14:30:15
