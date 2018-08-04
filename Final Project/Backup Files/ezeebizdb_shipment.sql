-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ezeebizdb
-- ------------------------------------------------------
-- Server version	5.5.59

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipment` (
  `ShipmentID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Warehouse_WarehouseID` int(10) unsigned NOT NULL,
  `PurchaseOrder_PONumber` int(10) unsigned NOT NULL,
  `PurchaseOrder_Customer_CustomerID` int(10) unsigned NOT NULL,
  `DeliveryProvider_ProviderID` int(10) unsigned NOT NULL,
  `PreparedBy` varchar(20) NOT NULL,
  `Weight` float NOT NULL,
  `Preparedon` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ShipmentID`,`Warehouse_WarehouseID`,`PurchaseOrder_PONumber`,`PurchaseOrder_Customer_CustomerID`),
  KEY `fk_Shipment_Warehouse1_idx` (`Warehouse_WarehouseID`),
  KEY `fk_Shipment_PurchaseOrder1_idx` (`PurchaseOrder_PONumber`,`PurchaseOrder_Customer_CustomerID`),
  KEY `fk_Shipment_DeliveryProvider1_idx` (`DeliveryProvider_ProviderID`),
  CONSTRAINT `fk_Shipment_DeliveryProvider1` FOREIGN KEY (`DeliveryProvider_ProviderID`) REFERENCES `deliveryprovider` (`ProviderID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Shipment_PurchaseOrder1` FOREIGN KEY (`PurchaseOrder_PONumber`, `PurchaseOrder_Customer_CustomerID`) REFERENCES `purchaseorder` (`PONumber`, `Customer_CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Shipment_Warehouse1` FOREIGN KEY (`Warehouse_WarehouseID`) REFERENCES `warehouse` (`WarehouseID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment`
--

LOCK TABLES `shipment` WRITE;
/*!40000 ALTER TABLE `shipment` DISABLE KEYS */;
INSERT INTO `shipment` VALUES (1,1,1,1,1,'whouse1@localhost',2.5,'2018-04-16 18:36:44'),(2,1,2,1,1,'whouse1@localhost',1.4,'2018-04-16 23:30:16'),(3,1,3,1,1,'whouse1@localhost',3.9,'2018-04-18 00:02:01'),(4,1,4,1,2,'whouse1@localhost',6.3,'2018-04-21 16:58:40'),(5,1,5,1,1,'whouse1@localhost',4.2,'2018-04-21 17:12:43'),(6,1,6,1,2,'whouse1@localhost',1.9,'2018-04-21 17:19:03');
/*!40000 ALTER TABLE `shipment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validate_shipment_weight
BEFORE INSERT ON shipment
FOR EACH ROW
BEGIN
	IF NEW.weight = 0
    THEN
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Shipment weight cannot be 0';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-22 16:21:40
