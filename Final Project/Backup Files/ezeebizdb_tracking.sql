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
-- Table structure for table `tracking`
--

DROP TABLE IF EXISTS `tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tracking` (
  `TrackingID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `DeliveryProvider_ProviderID` int(10) unsigned NOT NULL,
  `DeliveryProvider_ProviderID1` int(10) unsigned NOT NULL,
  `Shipment_ShipmentID` int(10) unsigned NOT NULL,
  `Shipment_Warehouse_WarehouseID` int(10) unsigned NOT NULL,
  `Shipment_PurchaseOrder_PONumber` int(10) unsigned NOT NULL,
  `Shipment_PurchaseOrder_Customer_CustomerID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`TrackingID`,`DeliveryProvider_ProviderID`,`DeliveryProvider_ProviderID1`),
  KEY `fk_TrackingData_DeliveryProvider1_idx` (`DeliveryProvider_ProviderID1`),
  KEY `fk_TrackingData_Shipment1_idx` (`Shipment_ShipmentID`,`Shipment_Warehouse_WarehouseID`,`Shipment_PurchaseOrder_PONumber`,`Shipment_PurchaseOrder_Customer_CustomerID`),
  CONSTRAINT `fk_TrackingData_DeliveryProvider1` FOREIGN KEY (`DeliveryProvider_ProviderID1`) REFERENCES `deliveryprovider` (`ProviderID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TrackingData_Shipment1` FOREIGN KEY (`Shipment_ShipmentID`, `Shipment_Warehouse_WarehouseID`, `Shipment_PurchaseOrder_PONumber`, `Shipment_PurchaseOrder_Customer_CustomerID`) REFERENCES `shipment` (`ShipmentID`, `Warehouse_WarehouseID`, `PurchaseOrder_PONumber`, `PurchaseOrder_Customer_CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracking`
--

LOCK TABLES `tracking` WRITE;
/*!40000 ALTER TABLE `tracking` DISABLE KEYS */;
INSERT INTO `tracking` VALUES (1,1,1,1,1,1,1),(3,1,1,2,1,2,1),(4,1,1,3,1,3,1),(5,2,2,4,1,4,1),(6,1,1,5,1,5,1),(7,2,2,6,1,6,1);
/*!40000 ALTER TABLE `tracking` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_change_order_status
AFTER INSERT ON tracking
FOR EACH ROW
BEGIN
	UPDATE purchaseorder
    SET OrderStatus = 'Shipped'
    WHERE PONumber = NEW.Shipment_PurchaseOrder_PONumber;
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

-- Dump completed on 2018-04-22 16:21:38
