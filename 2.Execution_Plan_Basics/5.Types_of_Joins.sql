/*********************************************************************************
**********************  Types of Joins  ******************************************
*********************************************************************************/


USE AdventureWorks2012
GO

SET STATISTICS IO ON
-- Loop Join
SELECT * 
FROM Sales.SalesOrderDetail sod
INNER LOOP JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice BETWEEN 1121 AND 1213
GO
-- Table Product: logical reads 34
-- Table SalesOrderDetal: logical reads 1246

-- Merge Join
SELECT * 
FROM Sales.SalesOrderDetail sod
INNER MERGE JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice < 2.5
GO
-- Table Product: logical reads 11
-- Table SalesOrderDetal: logical reads 11

-- Hash Join
SELECT *
FROM Sales.SalesOrderDetail sod
INNER HASH JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice < 3
GO
-- Table Product: logical reads 15
-- Table SalesOrderDetal: logical reads 1246

/*********************************************************************************/
-- All Loop Join
-- Loop Join
SELECT * 
FROM Sales.SalesOrderDetail sod
INNER LOOP JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice BETWEEN 1121 AND 1213
GO
-- Merge Join
SELECT * 
FROM Sales.SalesOrderDetail sod
INNER MERGE JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice BETWEEN 1121 AND 1213
GO
-- Hash Join
SELECT *
FROM Sales.SalesOrderDetail sod
INNER HASH JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice BETWEEN 1121 AND 1213
GO
-- Query Cost Order (least to most): Loop < Hash < Merge
/*********************************************************************************/


/*********************************************************************************/
-- All Merge Join
-- Loop Join
SELECT * 
FROM Sales.SalesOrderDetail sod
INNER LOOP JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice < 2.5
GO
-- Merge Join
SELECT * 
FROM Sales.SalesOrderDetail sod
INNER MERGE JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice < 2.5
GO
-- Hash Join
SELECT *
FROM Sales.SalesOrderDetail sod
INNER HASH JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice < 2.5
GO
-- Query Cost Order (least to most): Merge < Hash < Loop
/*********************************************************************************/

/*********************************************************************************/
-- All Hash Join
-- Loop Join
SELECT * 
FROM Sales.SalesOrderDetail sod
INNER LOOP JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice < 3
GO
-- Merge Join
SELECT * 
FROM Sales.SalesOrderDetail sod
INNER MERGE JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice < 3
GO
-- Hash Join
SELECT *
FROM Sales.SalesOrderDetail sod
INNER HASH JOIN Production.Product p on p.ProductID = sod.ProductID
WHERE sod.UnitPrice < 3
GO
-- Query Cost Order (least to most): Hash < Merge < Loop
/*********************************************************************************/


-- Clean Up
SET STATISTICS IO OFF