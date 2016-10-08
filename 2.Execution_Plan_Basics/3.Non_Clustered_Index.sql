/*********************************************************************************
********************  Non-Clustered Index Scan  **********************************
*********************************************************************************/

-- Create a sample non clustered index
CREATE NONCLUSTERED INDEX IX_MySalesOrderDetail_OrderQTY_ProductID
ON MySalesOrderDetail
(OrderQty, ProductID)
GO

SET STATISTICS IO ON
GO
-- Sample Query
SELECT	 SalesOrderID
		,SalesOrderDetailID
		,ProductID,OrderQty
FROM MySalesOrderDetail
GO
-- logical reads 306
-- Performs a NonClustered Index Scan

-- Sample Query with Where Clause
SELECT	 SalesOrderID
		,SalesOrderDetailID
		,ProductID,OrderQty
FROM MySalesOrderDetail
WHERE ProductID = 799
GO
-- logical reads 306
-- Performs a NonClustered Index Scan

-- How do we change the query to avoid a NonClustered Index Scan?

--Method 1: Add OrderQty in WHERE Clause
SELECT	 SalesOrderID
		,SalesOrderDetailID
		,ProductID,OrderQty
FROM MySalesOrderDetail
WHERE ProductID = 799 AND OrderQty > 0
GO
-- Additional Information allows SQL server to find info more efficiently
-- logical reads 306
-- Performs a NonClustered Index Seek

-- Method 2: Create Index with ProductID as First column
CREATE NONCLUSTERED INDEX IX_MySalesOrderDetail_ProductID_OrderQty
ON MySalesOrderDetail
(ProductID, OrderQty)
GO
-- We have reordered the index to put product id first which provides a better model for the index

SELECT	 SalesOrderID
		,SalesOrderDetailID
		,ProductID
		,OrderQty
FROM MySalesOrderDetail
WHERE ProductID = 799
GO
-- logical reads 5
-- Execution Plan performs a NonClustered Index Seek


-- Clean Up
SET STATISTICS IO OFF
GO

-- DROP INDEX IX_MySalesOrderDetail_OrderQty_ProductID ON dbo.MySalesOrderDetail