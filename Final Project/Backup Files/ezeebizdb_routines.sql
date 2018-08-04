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
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_productid`(IN PONumber INT, IN OrderItemID INT, 
OUT productid INT)
BEGIN
SELECT product_productID
INTO productid
FROM orderitem
WHERE orderitem.PurchaseOrder_PONumber = PONumber AND
orderitem.OrderItemID = OrderItemID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_business_on_days` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_total_business_on_days`(IN supplierid INT, IN startdate varchar(10), IN enddate varchar(10))
BEGIN
SELECT sum(invoice.TotalAmount) AS 'Total Earnings'
FROM invoice
WHERE invoice.PurchaseOrder_PONumber IN 
(
	SELECT purchaseorder.PONumber
	FROM purchaseorder
	WHERE purchaseorder.OrderPlacedOn >= startdate 
	AND purchaseorder.OrderPlacedOn <= enddate 
	AND purchaseorder.PONumber IN
		(SELECT orderitem.PurchaseOrder_PONumber
		FROM orderitem
		where orderitem.Product_ProductID IN 
			(SELECT product.ProductID
			FROM product
			WHERE product.Supplier_SupplierID = supplierid)));
-- 			GROUP BY orderitem.PurchaseOrder_PONumber))
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-22 16:21:41
