-- MariaDB dump 10.19  Distrib 10.5.18-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `codCliente` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tipoCliente` enum('Pessoa Jurídica','Pessoa Física') NOT NULL,
  PRIMARY KEY (`codCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Ramos e Cia','ramos.rh@gmail.com','Pessoa Jurídica'),(2,'Roberto de Souza','roberto.souza1@gmail.com','Pessoa Física'),(3,'Leidiane Almeida Santos','leidy.as@gmail.com','Pessoa Física'),(4,'Vanessa Rodrigues Souza','nessasouza10@gmail.com','Pessoa Física'),(5,'Lucas Vinicius Passos','vinicius322@gmail.com','Pessoa Física'),(6,'Alberto Santos','asantos.25@gmail.com','Pessoa Física'),(7,'Adalton Junior Albuquerque','adaltonrh@hotmail.com','Pessoa Física'),(8,'Construtora R&S','rogerioeselma.rh@yahoo.com.br','Pessoa Jurídica'),(9,'Casa das Peças','rh.002@gmail.com','Pessoa Jurídica'),(10,'Jonas Casaes Santos','jcsantos.200@gmail.com','Pessoa Física'),(11,'Armazém Amorim','adalton.am@gmail.com','Pessoa Jurídica'),(12,'Paulo  Júnior Santos','jr.gammer@gmail.com','Pessoa Física'),(13,'Lojas Sport','ljsport.rh@gmail.com','Pessoa Jurídica'),(14,'Lojas Omega Sports','omegasports@omega.com.br','Pessoa Jurídica'),(15,'Caio Passos','caio.passos100@gmail.com','Pessoa Física'),(16,'Supermercado Santos','santos.rh@gmail.com','Pessoa Jurídica'),(17,'Jonas Souza Lima','jonas.ultimatesports@ultimate.com.br','Pessoa Física'),(18,'Ultimame Sport','ultimate.sports10@ultimate.com.br','Pessoa Jurídica'),(19,'Paulo Sports','paulo.empresario@gmail.com','Pessoa Jurídica'),(20,'Diana Equipamentos Esportivos Em Geral','equipamentos.rh@gmail.com','Pessoa Jurídica');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endereco` (
  `codCliente` int unsigned NOT NULL,
  `endereco` int unsigned NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `uf` char(2) NOT NULL,
  `logradouro` varchar(80) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `num` varchar(20) NOT NULL,
  `cep` varchar(8) NOT NULL,
  PRIMARY KEY (`codCliente`,`endereco`),
  CONSTRAINT `endereco_ibfk_1` FOREIGN KEY (`codCliente`) REFERENCES `cliente` (`codCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (1,1,'Vitória da Conquista','BA','Apartamento','Brasil','263','45051090'),(1,2,'Carapicuíba','SP','Condomínio','Centro','316b','34323400'),(3,1,'Salvador','BA','Casa','Centro','134a','45900000'),(4,1,'Vitória da Conquista','BA','Apartamento','Ibirapuera','135','45075083'),(5,1,'Vitória da Conquista','BA','Casa','Centro','345a','47009045'),(6,1,'Vitória da Conquista','BA','Casa','Brasil','76','45105100'),(7,1,'Salvador','BA','Condomínio','Chapada','435a','54235002'),(8,1,'São Paulo','SP','Casa','Concha','452','99024394'),(9,1,'São Paulo','SP','Apartamento','Concha','252','52444432'),(10,1,'Belo Horizonte','MG','Condomínio','São João','431','42935342');
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido` (
  `codPedido` int unsigned NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `status` enum('aprovado','negado','em andamento','separado para entrega') NOT NULL DEFAULT 'em andamento',
  `formaPagamento` enum('cartão','boleto') NOT NULL,
  `codRastreamento` varchar(13) DEFAULT NULL,
  `codCliente` int unsigned NOT NULL,
  PRIMARY KEY (`codPedido`),
  KEY `codCliente` (`codCliente`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`codCliente`) REFERENCES `cliente` (`codCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'2015-12-30 23:13:59','aprovado','cartão','PN602625635BR',1),(2,'2015-10-23 12:10:40','negado','cartão',NULL,2),(3,'2016-01-04 20:54:02','aprovado','boleto','PN817438981BR',8),(4,'2016-02-15 20:01:42','aprovado','cartão','PN090012341BR',3),(5,'2016-07-09 06:11:40','aprovado','boleto','PN201600003BR',8),(6,'2016-09-07 14:49:54','negado','cartão',NULL,10),(7,'2016-11-09 17:01:26','aprovado','boleto','JA235167833BR',9),(8,'2016-11-10 15:00:59','aprovado','boleto','JA134154167BR',4),(9,'2016-11-10 15:01:54','aprovado','boleto','JA252467321BR',4),(10,'2016-11-11 07:10:10','aprovado','boleto','JA254299879BR',1),(11,'2016-11-14 04:21:01','aprovado','cartão','JA319810089BR',6),(12,'2016-11-16 17:21:21','aprovado','cartão','CP239800102BR',6),(13,'2016-11-18 16:16:20','aprovado','boleto','CP138997124BR',10),(14,'2016-08-12 12:12:21','aprovado','boleto','CP134000800BR',5),(15,'2017-06-21 12:12:21','em andamento','cartão','CP389124150BR',2),(16,'2017-06-21 12:12:21','separado para entrega','boleto','CP138914154BR',1),(17,'2017-11-18 16:16:20','aprovado','boleto','CP134004500BR',7);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoafisica`
--

DROP TABLE IF EXISTS `pessoafisica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoafisica` (
  `codCliente` int unsigned NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `sexo` enum('F','M') NOT NULL,
  PRIMARY KEY (`codCliente`),
  CONSTRAINT `pessoafisica_ibfk_1` FOREIGN KEY (`codCliente`) REFERENCES `cliente` (`codCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoafisica`
--

LOCK TABLES `pessoafisica` WRITE;
/*!40000 ALTER TABLE `pessoafisica` DISABLE KEYS */;
INSERT INTO `pessoafisica` VALUES (2,'43454254254','M'),(3,'25465664776','F'),(4,'23576787554','F'),(5,'42565657365','M'),(6,'35676476675','M'),(7,'75352476424','M'),(10,'04242554676','M'),(12,'01205425496','M'),(15,'12943153541','M'),(17,'01902214315','M');
/*!40000 ALTER TABLE `pessoafisica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoajuridica`
--

DROP TABLE IF EXISTS `pessoajuridica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoajuridica` (
  `codCliente` int unsigned NOT NULL,
  `cnpj` varchar(18) NOT NULL,
  `razaoSocial` varchar(150) NOT NULL,
  PRIMARY KEY (`codCliente`),
  CONSTRAINT `pessoajuridica_ibfk_1` FOREIGN KEY (`codCliente`) REFERENCES `cliente` (`codCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoajuridica`
--

LOCK TABLES `pessoajuridica` WRITE;
/*!40000 ALTER TABLE `pessoajuridica` DISABLE KEYS */;
INSERT INTO `pessoajuridica` VALUES (1,'46562663524534','Ramos Máquinas Industriais LTDA'),(8,'21354315143276','Agência de Construções de Pequeno Porte da equipe Rogerio e Selma - Construtora EPP'),(9,'13641531154312','Casa das Peças ME'),(11,'12985436792345','Armazém Amorim EPP'),(13,'43163490653419','Lojas Sport & Equipamentos LTDA'),(14,'21844400923157','Lojas Qualificadas Omega Sports LTDA'),(16,'13904857301350','Supermercado Santos EPP'),(18,'09334598613542','Lojas Ultimate Sports LTDA'),(19,'90913256789931','Paulo Lima Sports'),(20,'10054219784905','Diana Souza Equipamentos Esportivos e Roupas Esportivas em geral');
/*!40000 ALTER TABLE `pessoajuridica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produto` (
  `codProduto` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(40) NOT NULL,
  `precoSugerido` decimal(6,2) NOT NULL,
  `precoCompra` decimal(6,2) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `qtdEstoque` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`codProduto`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Nike Shox',449.90,429.99,'Tênis líder de mercado da Nike',55),(2,'Adidas Springblade',499.90,474.99,'Tênis da Adidas',30),(3,'Chuteira Nike Mercurial',329.90,299.99,'Chuteira mais requisitada da Nike',20),(4,'Chuteira Adidas Ace',259.90,249.99,'Chuteira mais requisitada da Adidas',12),(5,'Chuteira Umbro Attak 2 ',139.90,129.99,'Chuteira mais requisitada da Umbro',16),(6,'Meia Esportiva Umbro',47.30,39.99,'Meia Esportiva da Umbro',8),(7,'Caneleira Adidas Everlesto',39.90,29.99,'Caneleira da Adidas',6),(8,'Joelheira Umbro Neoprene',29.90,19.99,'Joelheira da Umbro',10),(9,'Capacete Esportivo Tsw',99.00,84.99,'Capacete protetor esportivo da Tsw, específico para ciclistas',3),(10,'Luvas Nike Bike Cycling',119.90,99.99,'Luva para ciclistas',7);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefone`
--

DROP TABLE IF EXISTS `telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefone` (
  `codCliente` int unsigned NOT NULL,
  `telefone` char(13) NOT NULL,
  PRIMARY KEY (`codCliente`,`telefone`),
  CONSTRAINT `telefone_ibfk_1` FOREIGN KEY (`codCliente`) REFERENCES `cliente` (`codCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefone`
--

LOCK TABLES `telefone` WRITE;
/*!40000 ALTER TABLE `telefone` DISABLE KEYS */;
INSERT INTO `telefone` VALUES (1,'5577988356531'),(2,'5511988121343'),(3,'5571989782354'),(4,'5577999256246'),(5,'5577999145134'),(6,'5577989256523'),(7,'5571999431541'),(8,'5511999230875'),(9,'5511988907142'),(10,'3199811435586');
/*!40000 ALTER TABLE `telefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trocaproduto`
--

DROP TABLE IF EXISTS `trocaproduto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trocaproduto` (
  `codPedido` int unsigned NOT NULL,
  `codProdutoVenda` int unsigned NOT NULL,
  `codProdutoTrocado` int unsigned NOT NULL,
  `dataTroca` datetime NOT NULL,
  `precoUnitario` decimal(6,2) NOT NULL,
  `descontoTroca` decimal(6,2) NOT NULL,
  `quantidade` tinyint unsigned NOT NULL,
  PRIMARY KEY (`codPedido`,`codProdutoVenda`,`codProdutoTrocado`),
  KEY `codProdutoTrocado` (`codProdutoTrocado`),
  CONSTRAINT `trocaproduto_ibfk_1` FOREIGN KEY (`codPedido`, `codProdutoVenda`) REFERENCES `venda` (`codPedido`, `codProduto`),
  CONSTRAINT `trocaproduto_ibfk_2` FOREIGN KEY (`codProdutoTrocado`) REFERENCES `produto` (`codProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trocaproduto`
--

LOCK TABLES `trocaproduto` WRITE;
/*!40000 ALTER TABLE `trocaproduto` DISABLE KEYS */;
INSERT INTO `trocaproduto` VALUES (1,10,1,'2016-01-03 12:53:31',119.90,11.99,2),(3,8,2,'2016-12-15 10:03:10',99.00,4.95,1),(4,7,5,'2016-02-15 13:34:34',39.90,2.00,1),(5,1,3,'2016-07-15 23:13:12',449.90,44.99,2),(7,4,9,'2016-11-20 12:23:13',259.90,13.00,1),(8,5,10,'2016-11-15 20:23:10',139.90,7.00,1),(9,2,10,'2016-11-20 15:23:46',499.90,25.00,1),(10,10,4,'2016-11-23 21:54:43',119.90,11.99,2),(11,5,6,'2016-11-14 21:43:12',139.90,7.00,1),(13,2,7,'2016-11-24 04:43:15',499.90,25.00,1),(14,9,8,'2016-02-04 21:11:12',99.00,4.95,1),(17,10,1,'2016-12-21 20:23:10',119.90,6.00,1);
/*!40000 ALTER TABLE `trocaproduto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venda`
--

DROP TABLE IF EXISTS `venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venda` (
  `codPedido` int unsigned NOT NULL,
  `codProduto` int unsigned NOT NULL,
  `desconto` decimal(6,2) NOT NULL,
  `precoVenda` decimal(6,2) NOT NULL,
  `quantidade` tinyint unsigned NOT NULL,
  PRIMARY KEY (`codPedido`,`codProduto`),
  KEY `codProduto` (`codProduto`),
  CONSTRAINT `venda_ibfk_1` FOREIGN KEY (`codPedido`) REFERENCES `pedido` (`codPedido`),
  CONSTRAINT `venda_ibfk_2` FOREIGN KEY (`codProduto`) REFERENCES `produto` (`codProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venda`
--

LOCK TABLES `venda` WRITE;
/*!40000 ALTER TABLE `venda` DISABLE KEYS */;
INSERT INTO `venda` VALUES (1,10,0.40,71.94,3),(3,8,0.00,29.90,1),(4,2,0.12,439.91,3),(4,7,0.14,34.31,2),(5,1,0.10,404.91,1),(7,4,0.50,129.95,1),(8,5,0.20,111.92,3),(9,2,0.50,249.95,7),(10,1,0.40,269.94,2),(10,10,0.10,107.91,2),(11,1,0.20,359.92,1),(11,5,0.15,118.92,2),(12,2,0.25,374.93,10),(12,8,0.25,22.43,10),(13,2,0.10,449.91,1),(14,9,0.20,79.20,2),(16,1,0.30,314.93,2),(16,3,0.30,230.93,2),(17,10,0.10,107.91,1);
/*!40000 ALTER TABLE `venda` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-21 14:41:33
