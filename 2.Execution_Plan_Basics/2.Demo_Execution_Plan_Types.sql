SET STATISTICS TIME ON
GO
SELECT *
FROM Sales.SalesPerson sp
INNER JOIN Sales.SalesPersonQuotaHistory spq
	ON sp.BusinessEntityID = spq.BusinessEntityID
ORDER BY sp.SalesQuota
GO
SET STATISTICS TIME OFF
GO
-- Tells us how long it took to actually execute the query
/****************************************************************************************************************
****************************************************************************************************************/

-- Display Options of Execution Plans - STATISTICS IO
SET STATISTICS IO ON
GO
SELECT *
FROM Sales.SalesPerson sp
INNER JOIN Sales.SalesPersonQuotaHistory spq
	ON sp.BusinessEntityID = spq.BusinessEntityID
ORDER BY sp.SalesQuota
GO
SET STATISTICS IO OFF
GO
/****************************************************************************************************************
****************************************************************************************************************/

-- Display Options of Estimated Execution Plans - Text - SHOWPLAN_TEXT
SET SHOWPLAN_TEXT ON
GO
SELECT *
FROM Sales.SalesPerson sp
INNER JOIN Sales.SalesPersonQuotaHistory spq
	ON sp.BusinessEntityID = spq.BusinessEntityID
ORDER BY sp.SalesQuota
GO
SET SHOWPLAN_TEXT OFF
GO
-- Gives execution plan and what it is
/****************************************************************************************************************
****************************************************************************************************************/

-- Display Options of Estimated Execution Plans - Text - SHOWPLAN_ALL
SET SHOWPLAN_ALL ON
GO
SELECT *
FROM Sales.SalesPerson sp
INNER JOIN Sales.SalesPersonQuotaHistory spq
	ON sp.BusinessEntityID = spq.BusinessEntityID
ORDER BY sp.SalesQuota
GO
SET SHOWPLAN_ALL OFF
GO

/****************************************************************************************************************
****************************************************************************************************************/

-- Display Options of Estimated Execution Plans - Text - STATISTICS PROFILE
SET STATISTICS PROFILE ON
GO
SELECT *
FROM Sales.SalesPerson sp
INNER JOIN Sales.SalesPersonQuotaHistory spq
	ON sp.BusinessEntityID = spq.BusinessEntityID
ORDER BY sp.SalesQuota
GO
SET STATISTICS PROFILE OFF
GO
--Gives execution plan from an actual query that was executed
/****************************************************************************************************************
****************************************************************************************************************/

-- Display Options of Estimated Execution Plans - XML - SHOWPLAN_XML
SET SHOWPLAN_XML ON
GO
SELECT *
FROM Sales.SalesPerson sp
INNER JOIN Sales.SalesPersonQuotaHistory spq
	ON sp.BusinessEntityID = spq.BusinessEntityID
ORDER BY sp.SalesQuota
GO
SET SHOWPLAN_XML OFF
GO
-- In order to display turn off Include Actual Execution Plan (CTRL + M)
/****************************************************************************************************************
****************************************************************************************************************/

-- Display Options of Estimated Execution Plans - XML - STATISTICS XML
SET STATISTICS XML ON
GO
SELECT *
FROM Sales.SalesPerson sp
INNER JOIN Sales.SalesPersonQuotaHistory spq
	ON sp.BusinessEntityID = spq.BusinessEntityID
ORDER BY sp.SalesQuota
GO
SET STATISTICS XML OFF
GO
-- Inspect the properties of the CLustered Index Seek by pressing F4
  -- Seek Predicates
    -- It is a WHERE Clause that is added 
	-- If you see any anomalies within the WHERE clause or bubbling up of the where clause to other operators then investigate the indexes that have been defined