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
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `InvoiceID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PurchaseOrder_PONumber` int(10) unsigned NOT NULL,
  `PurchaseOrder_Customer_CustomerID` int(10) unsigned NOT NULL,
  `ShippingSpeed` varchar(20) NOT NULL DEFAULT 'normal' COMMENT 'Shipping Speed should be 2day/1day/normal',
  `TotalAmount` float unsigned DEFAULT NULL,
  `invoicestreet` varchar(45) DEFAULT NULL,
  `invoicecity` varchar(25) DEFAULT NULL,
  `invoicestate` varchar(2) DEFAULT NULL,
  `invoicezip` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`InvoiceID`,`PurchaseOrder_PONumber`,`PurchaseOrder_Customer_CustomerID`),
  KEY `fk_Invoice_PurchaseOrder1_idx` (`PurchaseOrder_PONumber`,`PurchaseOrder_Customer_CustomerID`),
  CONSTRAINT `fk_Invoice_PurchaseOrder1` FOREIGN KEY (`PurchaseOrder_PONumber`, `PurchaseOrder_Customer_CustomerID`) REFERENCES `purchaseorder` (`PONumber`, `Customer_CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,1,1,'1day',2595,NULL,NULL,NULL,NULL),(2,2,1,'normal',285,NULL,NULL,NULL,NULL),(3,3,1,'2day',600,NULL,NULL,NULL,NULL),(4,4,1,'2day',600,'90 Charles st','Boston','MA','02563'),(5,5,1,'2day',800,'90 Charles st','Boston','MA','02563'),(6,6,1,'1day',1710,'90 Charles st','Boston','MA','02563'),(7,7,2,'normal',85,'10 waltham st','Boston','MA','02854');
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_shipping_speed_get_billing_address
BEFORE INSERT ON invoice
FOR EACH ROW
BEGIN
	IF (NEW.TotalAmount > 1000)
    THEN
    SET NEW.ShippingSpeed = '1day';
    ELSEIF (NEW.TotalAmount > 500 AND NEW.TotalAmount <= 1000)
    THEN 
    SET NEW.ShippingSpeed = '2day';
    END IF;
    
	-- get billing address of customer from customeraddress table
    SELECT street, city, state, zip
	INTO @street, @city, @state, @zip 
	FROM customeraddress
	WHERE Customer_CustomerID = NEW.PurchaseOrder_Customer_CustomerID
	AND AddressType = 'Billing'; 
    -- update the billing address
	SET NEW.invoicestreet = @street, NEW.invoicecity = @city, 
	NEW.invoicestate = @state, NEW.invoicezip = @zip;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_update_giftcard_balance
AFTER INSERT ON invoice
FOR EACH ROW
BEGIN
	-- update giftcard balance if payment method is giftcard
    -- get payment method from PO of given invoice
    SELECT purchaseorder.PaymentMethod
    INTO @paymentmethod
    FROM purchaseorder
    WHERE purchaseorder.PONumber = NEW.PurchaseOrder_PONumber;
    
    IF @paymentmethod = 'giftcard'    
    THEN
    
    -- get giftcard balance of given customer and deduct amount
    SELECT giftcard.Amount, giftcard.GiftcardID
    INTO @giftcardamt, @giftcardid
    FROM giftcard
    WHERE giftcard.Customer_CustomerID = NEW.PurchaseOrder_Customer_CustomerID
    AND giftcard.Expirydate >= now();    
    
    -- set amount to 0 if invoice amount is greater than balance
    -- else deduct the gift card balance
    IF NEW.TotalAmount > @giftcardamt
    THEN
    SET @newbalance = 0;
    ELSE
    SET @newbalance = @giftcardamt - NEW.TotalAmount;
    END IF;
    
    -- update the giftcard balance now for given cardID
    UPDATE giftcard SET giftcard.Amount = @newbalance
    WHERE giftcard.GiftcardID = @giftcardid;
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

-- Dump completed on 2018-04-22 16:21:38
