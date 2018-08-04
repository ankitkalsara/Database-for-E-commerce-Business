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
-- Table structure for table `trackingstatus`
--

DROP TABLE IF EXISTS `trackingstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trackingstatus` (
  `TrackingStatusID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Tracking_TrackingID` int(16) unsigned NOT NULL,
  `Tracking_DeliveryProvider_ProviderID` int(10) unsigned NOT NULL,
  `Tracking_DeliveryProvider_ProviderID1` int(10) unsigned NOT NULL,
  `OrderStateLocation` varchar(2) NOT NULL,
  `OrderZIPLocation` varchar(10) NOT NULL,
  `StatusDate` date NOT NULL,
  `StatusTime` time NOT NULL,
  PRIMARY KEY (`TrackingStatusID`,`Tracking_TrackingID`,`Tracking_DeliveryProvider_ProviderID`,`Tracking_DeliveryProvider_ProviderID1`),
  KEY `fk_TrackingStatus_TrackingData1_idx` (`Tracking_TrackingID`,`Tracking_DeliveryProvider_ProviderID`,`Tracking_DeliveryProvider_ProviderID1`),
  CONSTRAINT `fk_TrackingStatus_TrackingData1` FOREIGN KEY (`Tracking_TrackingID`, `Tracking_DeliveryProvider_ProviderID`, `Tracking_DeliveryProvider_ProviderID1`) REFERENCES `tracking` (`TrackingID`, `DeliveryProvider_ProviderID`, `DeliveryProvider_ProviderID1`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trackingstatus`
--

LOCK TABLES `trackingstatus` WRITE;
/*!40000 ALTER TABLE `trackingstatus` DISABLE KEYS */;
INSERT INTO `trackingstatus` VALUES (1,1,1,1,'NJ','36521','2018-04-16','16:47:15'),(2,1,1,1,'MA','02115','2018-04-16','16:51:11'),(3,3,1,1,'CA','65241','2018-04-16','19:47:56'),(4,3,1,1,'MA','02120','2018-04-17','12:57:51'),(5,4,1,1,'MA','02120','2018-04-17','20:06:43'),(6,5,2,2,'CO','85412','2018-04-21','13:05:29'),(7,5,2,2,'MA','02120','2018-04-21','13:07:03'),(8,6,1,1,'MA','02115','2018-04-21','13:16:42'),(9,7,2,2,'MA','02115','2018-04-21','13:22:14');
/*!40000 ALTER TABLE `trackingstatus` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_order_delivered
AFTER INSERT ON trackingstatus
FOR EACH ROW
BEGIN
	-- get trackingid from tracking status
    SET @trackingid = NEW.Tracking_TrackingID;
    
    -- from the tracking id get PO number stored in tracking table
    SELECT tracking.Shipment_PurchaseOrder_PONumber
    INTO @shipment_ponumber
    FROM tracking
    WHERE tracking.TrackingID = @trackingid;
    
	-- get PO from trackingid
    SELECT purchaseorder.PONumber,
    purchaseorder.DeliveryState, purchaseorder.DeliveryZIP
    INTO @ponumber, @deliverystate, @deliveryzip
    FROM purchaseorder
    WHERE purchaseorder.PONumber = @shipment_ponumber;
    
    -- SELECT purchaseorder.PONumber,
    -- purchaseorder.DeliveryState, purchaseorder.DeliveryZIP
    -- INTO @ponumber, @deliverystate, @deliveryzip
    -- FROM purchaseorder
    -- INNER JOIN tracking
    -- ON purchaseorder.PONumber = @shipment_ponumber;
    
    -- check if state/zip of tracking status matches with order's state & zip
    IF (NEW.OrderStateLocation = @deliverystate AND
	    NEW.OrderZIPLocation = @deliveryzip) 
	THEN
    UPDATE purchaseorder
    SET OrderStatus = 'Delivered'
    WHERE PONumber = @ponumber; 
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

-- Dump completed on 2018-04-22 16:21:41
