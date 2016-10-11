USE AdventureWorks2012
GO
-- Build Sample DB
SELECT *
into MySalesOrderDetail
FROM Sales.SalesOrderDetail
GO

/****************************************************************************************************************
*********************************  Clustered Index Scan and CLustered Index Seek  *******************************
****************************************************************************************************************/
--CTRL + M
-- Build Sample DB
SET STATISTICS IO ON
GO
SELECT * 
FROM MySalesOrderDetail
-- Logical Reads 1494
-- Execution Plan tells us that a Table Scan has occurred because there are no clustered indexes on this table
/****************************************************************************************************************
****************************************************************************************************************/
GO
SELECT *
FROM MySalesOrderDetail
WHERE SalesOrderID = 60726 AND SalesOrderDetailID = 74616
-- Logical Reads 1494
GO
-- Execution plan is a Table Scan
/****************************************************************************************************************
****************************************************************************************************************/

--Create Clustered Index
ALTER TABLE MySalesOrderDetail
ADD CONSTRAINT PK_MySalesOrderDetail_SalesOrderID_SalesOrderDetailID
PRIMARY KEY CLUSTERED
(
	SalesOrderID ASC,
	SalesOrderDetailID ASC
)
GO
/****************************************************************************************************************
****************************************************************************************************************/

-- Now execute with a clustered index
GO
SELECT * 
FROM MySalesOrderDetail
-- logical reads 1506
  -- Notice that the amount of logical reads has increased by 12!!!
    -- The additional pages came from the formation of the binary tree

/****************************************************************************************************************
****************************************************************************************************************/

GO
SELECT *
FROM MySalesOrderDetail
WHERE SalesOrderID = 60726 AND SalesOrderDetailID = 74616
-- Logical Reads = 3 !!!
  -- Previously a Clustered Index Scan is now  Clustered Index Seek
    -- SQL can narrow down using the clustered index key bsaed on the where condition to use a seek instead of a scan
	-- Whenerever you use a SELECT * SQL must look at each row, therefore a clustered index scan
	-- When you use a where clause on a specific key SQL will use a clustered index seek