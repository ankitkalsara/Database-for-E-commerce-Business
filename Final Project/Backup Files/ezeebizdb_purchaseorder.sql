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
-- Table structure for table `purchaseorder`
--

DROP TABLE IF EXISTS `purchaseorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchaseorder` (
  `PONumber` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Customer_CustomerID` int(10) unsigned NOT NULL,
  `OrderPlacedOn` date NOT NULL,
  `OrderStatus` varchar(20) NOT NULL DEFAULT 'Placed' COMMENT 'Status should be either Placed/Shipped/Delivered',
  `PaymentMethod` varchar(10) NOT NULL COMMENT 'Payment Method should be Card/Cash/Gift Card',
  `Deliverat` varchar(15) DEFAULT NULL,
  `DeliveryStreet` varchar(45) NOT NULL,
  `DeliveryCity` varchar(25) NOT NULL,
  `DeliveryState` varchar(2) NOT NULL,
  `DeliveryZIP` varchar(10) NOT NULL,
  PRIMARY KEY (`PONumber`,`Customer_CustomerID`),
  KEY `fk_PurchaseOrder_Customer1_idx` (`Customer_CustomerID`),
  CONSTRAINT `fk_PurchaseOrder_Customer1` FOREIGN KEY (`Customer_CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseorder`
--

LOCK TABLES `purchaseorder` WRITE;
/*!40000 ALTER TABLE `purchaseorder` DISABLE KEYS */;
INSERT INTO `purchaseorder` VALUES (1,1,'2018-04-16','Delivered','Card',NULL,'75 Smith st','Boston','MA','02115'),(2,1,'2018-04-16','Delivered','Card',NULL,'90 Mission Hill','Boston','MA','02120'),(3,1,'2018-04-17','Delivered','Card',NULL,'91 Mission Hill','Boston','MA','02120'),(4,1,'2018-04-20','Delivered','Card',NULL,'91 Mission Hill','Boston','MA','02120'),(5,1,'2018-04-20','Delivered','Card','Mailing','75 Smith st','Boston','MA','02115'),(6,1,'2018-04-21','Delivered','Card','Mailing','75 Smith st','Boston','MA','02115'),(7,2,'2018-04-21','Placed','giftcard','Mailing','10 Prince st','Boston','MA','02651');
/*!40000 ALTER TABLE `purchaseorder` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_get_mailadrs_for_customer
BEFORE INSERT ON purchaseorder
FOR EACH ROW
BEGIN
IF NEW.Deliverat = 'Mailing'
THEN
SELECT street, city, state, zip
INTO @street, @city, @state, @zip 
FROM customeraddress
WHERE Customer_CustomerID = NEW.Customer_CustomerID 
AND AddressType = 'Mailing'; 
SET NEW.DeliveryStreet = @street, NEW.DeliveryCity = @city, NEW.DeliveryState = @state, NEW.DeliveryZIP = @zip;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_cancel_placed_orders_remove_oi_invoice
BEFORE DELETE ON purchaseorder
FOR EACH ROW
BEGIN
IF (OLD.OrderStatus = 'Shipped' OR OLD.OrderStatus = 'Delivered')
THEN
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Order cannot be cancelled when order is Shipped or Delivered';
ELSEIF (OLD.OrderStatus = 'Placed' AND OLD.PaymentMethod = 'giftcard')
THEN
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Order cannot be cancelled when placed with Gift card';
ELSEIF (OLD.OrderStatus = 'Placed' AND OLD.PaymentMethod = 'Card')
THEN
DELETE FROM orderitem WHERE orderitem.PurchaseOrder_PONumber = OLD.PONumber;
DELETE FROM invoice WHERE invoice.PurchaseOrder_PONumber = OLD.PONumber;
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

-- Dump completed on 2018-04-22 16:21:37
