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
-- Table structure for table `creditcard`
--

DROP TABLE IF EXISTS `creditcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creditcard` (
  `CCNumber` varchar(64) NOT NULL,
  `Customer_CustomerID` int(10) unsigned DEFAULT NULL,
  `CVV` varchar(64) NOT NULL,
  `ExpiryYear` tinyint(2) unsigned NOT NULL,
  `ExpiryMonth` tinyint(2) unsigned NOT NULL,
  `CardType` varchar(10) NOT NULL COMMENT 'Type = Master/Visa/AMEX',
  PRIMARY KEY (`CCNumber`),
  KEY `fk_CreditCard_Customer1_idx` (`Customer_CustomerID`),
  CONSTRAINT `fk_CreditCard_Customer1` FOREIGN KEY (`Customer_CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creditcard`
--

LOCK TABLES `creditcard` WRITE;
/*!40000 ALTER TABLE `creditcard` DISABLE KEYS */;
INSERT INTO `creditcard` VALUES ('33cdbc3872b3789776eff6178cd7585d9c9b080c752aa4e92c274d768e2a7ea2',1,'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',20,12,'VISA'),('606be4be7da45ecaae02068579b7579f4c9218c87fa7e3678b3b151c78457908',2,'b3a8e0e1f9ab1bfe3a36f231f676f78bb30a519d2b21e6c530c0eee8ebb4a5d0',22,10,'AMEX');
/*!40000 ALTER TABLE `creditcard` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validate_creditcard
BEFORE INSERT ON creditcard
FOR EACH ROW
BEGIN
	IF LENGTH(NEW.CCNumber) <> 16
    THEN
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Credit Card umber should be 16 digits';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `CustomerID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(30) NOT NULL,
  `LastName` varchar(30) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `ContactNo` varchar(10) NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'John','Bills','john@gmail.com','1234567890'),(2,'Brown','Wills','brown@gmail.com','9876543210');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_customer_validate_contact_and_email
BEFORE INSERT ON customer
FOR EACH ROW
BEGIN
	IF NEW.email NOT LIKE '%_@%_._%'
    THEN
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Email column is not valid';
    ELSEIF LENGTH(NEW.ContactNo) < 10
    THEN
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Contact Number should be 10 digit';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `customeraddress`
--

DROP TABLE IF EXISTS `customeraddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customeraddress` (
  `AddressType` varchar(15) NOT NULL COMMENT 'Address Type Should be either Shipping or Billing.',
  `Customer_CustomerID` int(10) unsigned NOT NULL,
  `Street` varchar(45) NOT NULL,
  `City` varchar(25) NOT NULL,
  `State` varchar(2) NOT NULL,
  `ZIP` varchar(10) NOT NULL,
  PRIMARY KEY (`AddressType`,`Customer_CustomerID`),
  KEY `fk_CustomerAddress_Customer1_idx` (`Customer_CustomerID`),
  CONSTRAINT `fk_CustomerAddress_Customer1` FOREIGN KEY (`Customer_CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customeraddress`
--

LOCK TABLES `customeraddress` WRITE;
/*!40000 ALTER TABLE `customeraddress` DISABLE KEYS */;
INSERT INTO `customeraddress` VALUES ('Billing',1,'90 Charles st','Boston','MA','02563'),('Billing',2,'10 waltham st','Boston','MA','02854'),('Mailing',1,'75 Smith st','Boston','MA','02115'),('Mailing',2,'10 Prince st','Boston','MA','02651');
/*!40000 ALTER TABLE `customeraddress` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_customer_validate_customeradd_type
BEFORE INSERT ON customeraddress
FOR EACH ROW
BEGIN
	IF NEW.addresstype <> 'Billing'
    THEN
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Address type should be Billing or Mailing';
    ELSEIF NEW.addresstype <> 'Mailing'
    THEN
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Address type should be Billing or Mailing';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `deliveryprovider`
--

DROP TABLE IF EXISTS `deliveryprovider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deliveryprovider` (
  `ProviderID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ProviderName` varchar(45) NOT NULL,
  `ProviderContactNo` varchar(10) NOT NULL,
  `ProviderEmail` varchar(45) NOT NULL,
  `ProviderStreet` varchar(45) NOT NULL,
  `ProviderCity` varchar(25) NOT NULL,
  `ProviderState` varchar(45) NOT NULL,
  `ProviderZIP` varchar(10) NOT NULL,
  PRIMARY KEY (`ProviderID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveryprovider`
--

LOCK TABLES `deliveryprovider` WRITE;
/*!40000 ALTER TABLE `deliveryprovider` DISABLE KEYS */;
INSERT INTO `deliveryprovider` VALUES (1,'Fedex-Bos','1234567890','fedexbos@gmail.com','columbus ave','Boston','MA','02115'),(2,'Fedex-Cal','9876543210','fedexcal@gmail.com','south ave','California','CA','90001');
/*!40000 ALTER TABLE `deliveryprovider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `giftcard`
--

DROP TABLE IF EXISTS `giftcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `giftcard` (
  `GiftcardID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Customer_CustomerID` int(10) unsigned DEFAULT NULL,
  `Amount` int(10) unsigned NOT NULL DEFAULT '10',
  `Expirydate` date NOT NULL,
  PRIMARY KEY (`GiftcardID`),
  KEY `fk_GiftCard_Customer_idx` (`Customer_CustomerID`),
  CONSTRAINT `fk_GiftCard_Customer` FOREIGN KEY (`Customer_CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giftcard`
--

LOCK TABLES `giftcard` WRITE;
/*!40000 ALTER TABLE `giftcard` DISABLE KEYS */;
INSERT INTO `giftcard` VALUES (1,1,100,'2018-03-03'),(2,1,200,'2018-06-06'),(3,2,150,'2018-05-05');
/*!40000 ALTER TABLE `giftcard` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `fk_Invoice_PurchaseOrder1` FOREIGN KEY (`PurchaseOrder_PONumber`, `PurchaseOrder_Customer_CustomerID`) REFERENCES `purchaseorder` (`PONumber`, `Customer_CustomerID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,1,1,'1day',2595,NULL,NULL,NULL,NULL),(2,2,1,'normal',285,NULL,NULL,NULL,NULL),(3,3,1,'2day',600,NULL,NULL,NULL,NULL),(4,4,1,'2day',600,'90 Charles st','Boston','MA','02563'),(5,5,1,'2day',800,'90 Charles st','Boston','MA','02563'),(6,6,1,'1day',1710,'90 Charles st','Boston','MA','02563');
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
	SET NEW.invoicestreet = @street, NEW.invoicecity = @city, 
	NEW.invoicestate = @state, NEW.invoicezip = @zip;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orderitem`
--

DROP TABLE IF EXISTS `orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderitem` (
  `OrderItemID` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `PurchaseOrder_PONumber` int(10) unsigned NOT NULL,
  `PurchaseOrder_Customer_CustomerID` int(10) unsigned NOT NULL,
  `Product_ProductID` int(5) unsigned NOT NULL,
  `OrderedQty` int(2) unsigned NOT NULL,
  PRIMARY KEY (`OrderItemID`,`PurchaseOrder_PONumber`,`PurchaseOrder_Customer_CustomerID`),
  KEY `fk_OrderItem_PurchaseOrder1_idx` (`PurchaseOrder_PONumber`,`PurchaseOrder_Customer_CustomerID`),
  KEY `fk_OrderItem_Product1_idx` (`Product_ProductID`),
  CONSTRAINT `fk_OrderItem_Product1` FOREIGN KEY (`Product_ProductID`) REFERENCES `product` (`ProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderItem_PurchaseOrder1` FOREIGN KEY (`PurchaseOrder_PONumber`, `PurchaseOrder_Customer_CustomerID`) REFERENCES `purchaseorder` (`PONumber`, `Customer_CustomerID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitem`
--

LOCK TABLES `orderitem` WRITE;
/*!40000 ALTER TABLE `orderitem` DISABLE KEYS */;
INSERT INTO `orderitem` VALUES (1,1,1,1,10),(2,1,1,2,7),(3,2,1,1,1),(4,2,1,2,1),(5,3,1,1,3),(6,4,1,1,3),(7,5,1,1,4),(8,6,1,1,6),(9,6,1,2,6);
/*!40000 ALTER TABLE `orderitem` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validate_orderitem_quantity
BEFORE INSERT ON orderitem
FOR EACH ROW
BEGIN
	IF NEW.orderedqty < 0
    THEN
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Order item can not contain 0 or negative quantity';
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_reduce_product_qty
AFTER INSERT ON orderitem
FOR EACH ROW
BEGIN	
    UPDATE Product
    SET AvailProductQty = AvailProductQty - NEW.orderedqty
    WHERE Product.ProductID = NEW.Product_ProductID;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_increase_product_qty
AFTER DELETE ON orderitem
FOR EACH ROW
BEGIN	
    UPDATE Product
    SET AvailProductQty = AvailProductQty + OLD.orderedqty
    WHERE Product.ProductID = OLD.Product_ProductID;
    -- WHERE Product.ProductID = OLD.PurchaseOrder_PONumber;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `ProductID` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `Supplier_SupplierID` int(5) NOT NULL,
  `ProductName` varchar(30) NOT NULL,
  `AvailProductQty` int(2) NOT NULL,
  `ProductPrice` float unsigned NOT NULL,
  PRIMARY KEY (`ProductID`),
  KEY `fk_Product_Supplier1_idx` (`Supplier_SupplierID`),
  CONSTRAINT `fk_Product_Supplier1` FOREIGN KEY (`Supplier_SupplierID`) REFERENCES `supplier` (`SupplierID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,1,'Iphone',20,200),(2,1,'Samsung',16,100),(3,2,'Laptop',10,1200);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validate_available_product_qty
BEFORE INSERT ON product
FOR EACH ROW
BEGIN
	IF NEW.availproductqty < 0
    THEN
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Product Quantity cannot be negative';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `productdiscount`
--

DROP TABLE IF EXISTS `productdiscount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productdiscount` (
  `DiscountID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `Product_ProductID` int(5) unsigned NOT NULL,
  `DiscountStartDate` date NOT NULL,
  `DiscountEndDate` date NOT NULL,
  `DiscountPercentage` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`DiscountID`,`Product_ProductID`),
  KEY `fk_ProductDiscount_Product1_idx` (`Product_ProductID`),
  CONSTRAINT `fk_ProductDiscount_Product1` FOREIGN KEY (`Product_ProductID`) REFERENCES `product` (`ProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productdiscount`
--

LOCK TABLES `productdiscount` WRITE;
/*!40000 ALTER TABLE `productdiscount` DISABLE KEYS */;
INSERT INTO `productdiscount` VALUES (1,1,'2018-03-01','2018-03-31',10),(2,2,'2018-04-04','2018-04-30',15),(3,3,'2018-04-04','2018-04-30',20);
/*!40000 ALTER TABLE `productdiscount` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validate_product_disc_percentage
BEFORE INSERT ON productdiscount
FOR EACH ROW
BEGIN
	IF NEW.DiscountPercentage = 0
    THEN
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Product Discount cannot be 0';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseorder`
--

LOCK TABLES `purchaseorder` WRITE;
/*!40000 ALTER TABLE `purchaseorder` DISABLE KEYS */;
INSERT INTO `purchaseorder` VALUES (1,1,'2018-04-16','Delivered','Card',NULL,'75 Smith st','Boston','MA','02115'),(2,1,'2018-04-16','Delivered','Card',NULL,'90 Mission Hill','Boston','MA','02120'),(3,1,'2018-04-17','Delivered','Card',NULL,'91 Mission Hill','Boston','MA','02120'),(4,1,'2018-04-20','Delivered','Card',NULL,'91 Mission Hill','Boston','MA','02120'),(5,1,'2018-04-20','Delivered','Card','Mailing','75 Smith st','Boston','MA','02115'),(6,1,'2018-04-21','Delivered','Card','Mailing','75 Smith st','Boston','MA','02115');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_cancel_only_placed_orders
BEFORE DELETE ON purchaseorder
FOR EACH ROW
BEGIN
IF OLD.OrderStatus <> 'Placed'
THEN
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Order cannot be cancelled when order is Shipped or Delivered';
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `product_ProductID` int(5) unsigned NOT NULL,
  `Review` varchar(45) DEFAULT NULL,
  `Rating` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`,`product_ProductID`),
  KEY `fk_Rating_product1_idx` (`product_ProductID`),
  CONSTRAINT `fk_Rating_product1` FOREIGN KEY (`product_ProductID`) REFERENCES `product` (`ProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` VALUES (1,1,'Best',5),(2,2,'Average product',3),(3,1,'Bad',1),(4,2,'Bad',1),(5,1,'Awesome',4);
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier` (
  `SupplierID` int(5) NOT NULL AUTO_INCREMENT,
  `SupplierName` varchar(45) NOT NULL,
  `SupplierStreet` varchar(45) NOT NULL,
  `SupplierCity` varchar(25) NOT NULL,
  `SupplierState` varchar(45) NOT NULL,
  `SupplierZIP` varchar(10) NOT NULL,
  `SupplierContactNo` varchar(10) NOT NULL,
  `SupplierEmail` varchar(45) NOT NULL,
  PRIMARY KEY (`SupplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Best buy','huntington ave','boston','MA','02115','1234567890','best@gmail.com'),(2,'Wallmart','south ave','boston','MA','02120','9876543210','wall@gmail.com');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Temporary view structure for view `view_all_product_rating`
--

DROP TABLE IF EXISTS `view_all_product_rating`;
/*!50001 DROP VIEW IF EXISTS `view_all_product_rating`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_all_product_rating` AS SELECT 
 1 AS `ProductID`,
 1 AS `ProductName`,
 1 AS `ProductPrice`,
 1 AS `DiscountPercentage`,
 1 AS `Average product rating`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_most_frequently_buyed_products`
--

DROP TABLE IF EXISTS `view_most_frequently_buyed_products`;
/*!50001 DROP VIEW IF EXISTS `view_most_frequently_buyed_products`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_most_frequently_buyed_products` AS SELECT 
 1 AS `ProductName`,
 1 AS `No of times product was buyed`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouse` (
  `WarehouseID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `WarehouseName` varchar(45) NOT NULL,
  `WarehouseContactNo` varchar(10) NOT NULL,
  `WarehouseEmail` varchar(45) NOT NULL,
  `WarehouseStreet` varchar(45) NOT NULL,
  `WarehouseCity` varchar(25) NOT NULL,
  `WarehouseState` varchar(45) NOT NULL,
  `WarehouseZIP` varchar(10) NOT NULL,
  PRIMARY KEY (`WarehouseID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (1,'amazon\'s warehouse','1234567890','warehouse@gmail.com','columbus ave','Boston','MA','02115');
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ezeebizdb'
--

--
-- Dumping routines for database 'ezeebizdb'
--
/*!50003 DROP PROCEDURE IF EXISTS `check_qty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_qty`(in orderedqty int, in Purchasesorder_PONumber int)
BEGIN
	SELECT AvailProductQty INTO @availprodqty FROM product WHERE ProductID = Purchasesorder_PONumber;
    IF orderedqty > @availprodqty
	THEN
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Ordered Quantity can not be greater than available product quantity';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_orderitem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_orderitem`(in Purchasesorder_PONumber int, in Purchaseorder_Customer_CustomerID int, 
in Product_ProductID int, in orderedqty int)
BEGIN
	-- SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    -- START TRANSACTION;
	CALL check_qty(orderedqty,Purchasesorder_PONumber);	-- if orderedqty > available product qty
	INSERT INTO orderitem 
    (PurchaseOrder_PONumber, PurchaseOrder_Customer_CustomerID,
	Product_ProductID, OrderedQty)
	VALUES
    (PurchaseOrder_PONumber, PurchaseOrder_Customer_CustomerID,
	Product_ProductID, OrderedQty);
	-- COMMIT;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_shipment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_shipment`(IN warehouseid INT, IN ponumber INT, 
IN deliveryproviderid INT, IN currentuser VARCHAR(60), IN weight FLOAT)
BEGIN
-- get the customerid from PO number
SELECT customer_customerid
INTO @customerid
FROM purchaseorder
WHERE purchaseorder.PONumber = ponumber;
-- insert the data into shipment table
INSERT INTO shipment 
(shipment.Warehouse_WarehouseID, shipment.PurchaseOrder_PONumber, 
shipment.PurchaseOrder_Customer_CustomerID, shipment.DeliveryProvider_ProviderID,
shipment.PreparedBy,shipment.Preparedon,shipment.Weight)
VALUES
(warehouseid, ponumber, @customerid, deliveryproviderid, 
currentuser, current_timestamp(), weight);
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_tracking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_tracking`(IN delieryproviderid INT, IN shipmentid INT)
BEGIN
-- get warehouseid, ponumber & customerid from ShipmentID
SELECT shipment.Warehouse_WarehouseID, shipment.PurchaseOrder_PONumber,
shipment.PurchaseOrder_Customer_CustomerID
INTO @warehouseid, @ponumber, @customerid
FROM shipment
WHERE shipment.ShipmentID = shipmentid;
INSERT INTO tracking
(tracking.DeliveryProvider_ProviderID, tracking.DeliveryProvider_ProviderID1,
tracking.Shipment_ShipmentID, tracking.Shipment_Warehouse_WarehouseID,
tracking.Shipment_PurchaseOrder_PONumber, 
tracking.Shipment_PurchaseOrder_Customer_CustomerID)
VALUES
(delieryproviderid, delieryproviderid, shipmentid, @warehouseid, 
@ponumber, @customerid);
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_tracking_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_tracking_status`(IN trackingid INT, IN orderstatelocation VARCHAR(2), IN orderziplocation VARCHAR(10))
BEGIN
-- get deliveryproviderID from trackingid
SELECT Deliveryprovider_providerID INTO @deliveryproviderid
FROM tracking WHERE tracking.TrackingID = trackingid;

INSERT INTO trackingstatus
(Tracking_TrackingID, Tracking_DeliveryProvider_ProviderID, 
Tracking_DeliveryProvider_ProviderID1, OrderStateLocation, OrderZIPLocation,
StatusDate, StatusTime)
VALUES
(trackingid, @deliveryproviderid, @deliveryproviderid,
orderstatelocation, orderziplocation, current_date(), current_time());
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_orders`(IN customerid INT)
BEGIN
SET @cid:= customerid;
SELECT PONumber, OrderPlacedOn, OrderStatus, PaymentMethod,
Shippingspeed, TotalAmount
FROM purchaseorder
INNER JOIN invoice
ON PONumber = invoice.PurchaseOrder_PONumber
WHERE purchaseorder.Customer_CustomerID = @cid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_giftcard_balance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_giftcard_balance`(IN customerid INT)
BEGIN
SET @cid:= customerid;
SELECT SUM(Amount) AS 'Giftcard Balance' FROM giftcard
WHERE Customer_CustomerID = @cid AND
expirydate >= current_date();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_order_location` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_order_location`(IN ponumber INT)
BEGIN
SELECT deliveryprovider.ProviderName AS 'Delivered by',
trackingstatus.TrackingStatusID AS 'Tracking Status number', 
trackingstatus.OrderStateLocation AS 'Order State Location',
trackingstatus.OrderZIPLocation AS 'Order ZIP location', 
trackingstatus.StatusDate 'Date',
trackingstatus.StatusTime 'Time' 
FROM trackingstatus
INNER JOIN tracking
ON trackingstatus.Tracking_TrackingID = tracking.TrackingID
INNER JOIN deliveryprovider
ON tracking.DeliveryProvider_ProviderID = deliveryprovider.ProviderID
INNER JOIN shipment
ON tracking.Shipment_ShipmentID = shipment.ShipmentID
INNER JOIN purchaseorder
ON shipment.PurchaseOrder_PONumber = purchaseorder.PONumber
WHERE purchaseorder.PONumber = ponumber;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_productid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_productid`(IN PONumber INT, IN OrderItemID INT, OUT productid INT)
BEGIN
SELECT product_productID
INTO productid
FROM orderitem
WHERE orderitem.OrderItemID = OrderItemID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `give_rating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `give_rating`(IN PONumber INT, IN OrderItemID INT, OUT productid INT)
BEGIN
SELECT product_productID
INTO productid
FROM orderitem
WHERE orderitem.OrderItemID = OrderItemID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `total_products_sold_for_current_month` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `total_products_sold_for_current_month`(IN supplierid INT)
BEGIN
-- find the first day and last day of month as of today
SELECT DATE_ADD(DATE_ADD(LAST_DAY(NOW()),INTERVAL 1 DAY),
INTERVAL - 1 MONTH) INTO @firstday;
SELECT LAST_DAY(NOW()) INTO @lastday;
 
SELECT product.ProductID, product.ProductName, product.ProductPrice,
@firstday AS 'Start of Month',
@lastday AS 'End of Month',
SUM(orderitem.OrderedQty) AS 'Total products sold',
product.AvailProductQty AS 'Available product quantity'
FROM supplier
INNER JOIN product
ON supplier.SupplierID = product.Supplier_SupplierID
INNER JOIN orderitem
ON product.ProductID = orderitem.Product_ProductID
INNER JOIN purchaseorder
ON orderitem.PurchaseOrder_PONumber = purchaseorder.PONumber
WHERE supplier.SupplierID = supplierid AND 
purchaseorder.OrderPlacedOn BETWEEN @firstday AND @lastday
GROUP BY product.ProductID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_all_product_rating`
--

/*!50001 DROP VIEW IF EXISTS `view_all_product_rating`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_all_product_rating` AS select `product`.`ProductID` AS `ProductID`,`product`.`ProductName` AS `ProductName`,`product`.`ProductPrice` AS `ProductPrice`,`productdiscount`.`DiscountPercentage` AS `DiscountPercentage`,avg(`rating`.`Rating`) AS `Average product rating` from ((`product` left join `productdiscount` on((`product`.`ProductID` = `productdiscount`.`Product_ProductID`))) left join `rating` on((`productdiscount`.`Product_ProductID` = `rating`.`product_ProductID`))) group by `product`.`ProductID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_most_frequently_buyed_products`
--

/*!50001 DROP VIEW IF EXISTS `view_most_frequently_buyed_products`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_most_frequently_buyed_products` AS select `product`.`ProductName` AS `ProductName`,count(`orderitem`.`Product_ProductID`) AS `No of times product was buyed` from ((`purchaseorder` join `orderitem` on((`purchaseorder`.`PONumber` = `orderitem`.`Product_ProductID`))) join `product` on((`orderitem`.`Product_ProductID` = `product`.`ProductID`))) group by `orderitem`.`Product_ProductID` */;
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

-- Dump completed on 2018-04-21 15:22:36
