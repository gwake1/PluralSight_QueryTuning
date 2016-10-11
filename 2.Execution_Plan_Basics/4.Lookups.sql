/*********************************************************************************
******************************  Lookups  *****************************************
*********************************************************************************/

SET STATISTICS IO ON
GO
-- Sample Query
SELECT	 SalesOrderID
		,SalesOrderDetailID
		,ProductID
		,OrderQty
		,SpecialOfferID
FROM MySalesOrderDetail
Where ProductID = 789
GO
--  logical reads 1125

-- Option 1: Add column to Index: based on covered index
CREATE NONCLUSTERED INDEX IX_MySalesOrderDetail_ProductID_OrderQTY_SpecialOfferID
ON MySalesOrderDetail
(ProductID, OrderQTY, SpecialOfferID)
GO

-- Sample Query
SELECT	 SalesOrderID
		,SalesOrderDetailID
		,ProductID
		,OrderQty
		,SpecialOfferID
FROM MySalesOrderDetail
Where ProductID = 789
GO
-- logical reads 4
--  Execution Plan NonClustered Index Seek

-- CleanUp
DROP INDEX IX_MySalesOrderDetail_ProductID_OrderQty_SpecialOfferID
ON dbo.MySalesOrderDetail
GO

-- Option 2: Add Column as Included Column
CREATE NONCLUSTERED INDEX IX_MySalesOrderDetail_ProductID_OrderQty_SpecialOfferID
ON MySalesOrderDetail
(ProductID)
INCLUDE (OrderQty, SpecialOfferID)
GO
-- OrderQty and SpecialOfferID are added to the leaf node

-- Sample Query
SELECT	 SalesOrderID
		,SalesOrderDetailID
		,ProductID
		,OrderQty
		,SpecialOfferID
FROM MySalesOrderDetail
Where ProductID = 789
GO
-- Logical Reads 3
-- Execution Plan NonClustered Index Seek


-- Clean Up
 --DROP INDEX IX_MySalesOrderDetail_ProductID_OrderQty_SpecialOfferID ON dbo.MySalesOrderDetail
