USE AdventureWorks2012
GO
-- Enable Execution Plan
-- CTRL + M
SELECT	 SalesOrderID
		,SalesOrderDetailID
		,CarrierTrackingNumber
		,OrderQty
		,ProductID
		,SpecialOfferID
		,UnitPrice
		,UnitPriceDiscount
	FROM Sales.SalesOrderDetail
GO
SELECT	 SUM(Orderqty)
		,ProductID
	FROM Sales.SalesOrderDetail
	GROUP By ProductID
GO
USE AdventureWorks2012
GO
SELECT	 VendorID
		,EmployeeID
	FROM Purchasing.PurchaseOrderHeader
	WHERE VendorID = 1540 AND EmployeeID = 258
GO