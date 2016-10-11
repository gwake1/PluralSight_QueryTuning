/*********************************************************************************
*****************  Lookup vs Seek vs Scan  ***************************************
*********************************************************************************/
USE AdventureWorks2012
GO

SET STATISTICS IO ON
GO

-- CTRL + M
-- Enforces Key Lookup
SELECT	 NationalIDNumber
		,HireDate
		,MaritalStatus
FROM HumanResources.Employee
WHERE NationalIDNumber = 14417807
GO
-- Performs an Index Scan on a nonclustered index based on NationalIDNumber
	-- If NationalIDNumber has an Index (AK_Employee_NationalIDNumber) why is it performing a scan?
-- Performs a Key Lookup where it is retrieving extra values: Output List (Marital Status & HireDate)

-- Create Non Clustered Index on NationalIDNumber
CREATE NONCLUSTERED INDEX IX_HumanResources_Employee_Example
	ON HumanResources.Employee
(
	NationalIDNumber ASC, HireDate, MaritalStatus
) ON [PRIMARY]
GO

-- Removes Key Lookup, but it still enforces Index Scan
-- Step 1
SELECT	 NationalIDNumber
		,HireDate
		,MaritalStatus
FROM HumanResources.Employee
WHERE NationalIDNumber = 14417807
GO
-- The Key Lookup has been removed from the execution plan by creating a covering index in above step
-- It is still performing a scan because a CONVERT_IMPLICIT is occurring in the predicate on the NationalIDNumber
-- Hovering above the SELECT statement there is a Warning Indicator
	-- Press F4 to bring up properties
	/* Type conversion in expression (CONVERT_IMPLICIT(int,[AdventureWorks2012].[HumanResources].[Employee].[NationalIDNumber],0)) 
	may affect "CardinalityEstimate" in query plan choice, Type conversion in expression (CONVERT_IMPLICIT(int,[AdventureWorks2012]
	.[HumanResources].[Employee].[NationalIDNumber],0)=[@1]) may affect "SeekPlan" in query plan choice, Type conversion in expression 
	(CONVERT_IMPLICIT(int,[AdventureWorks2012].[HumanResources].[Employee].[NationalIDNumber],0)=(14417807)) may affect "SeekPlan" in 
	query plan choice */
		-- Type conversion in expression, NationalIDNumber may affect "CardinalityEstimate" in query plan choice
		-- It is performing an implicit conversion to a varchar character, therefore supply the value in varchar format, ''

-- Step 2
-- Remove Key Lookup and enforces Index Seek
SELECT	 NationalIDNumber
		,HireDate
		,MaritalStatus
FROM HumanResources.Employee
WHERE NationalIDNumber = '14417807'
GO
-- Despite removing the warnings in the SELCT statement, the Index Seek is still performing an Implicit Conversion in the Predicate

-- Step 3
-- Remove Key Lookup and enforces Index Seek and no CONVERT_IMPLICIT in predicate of Index Seek
SELECT	 NationalIDNumber
		,HireDate
		,MaritalStatus
FROM HumanResources.Employee
WHERE NationalIDNumber = N'14417807'
GO


-- Clean Up
SET STATISTICS IO OFF
GO

DROP INDEX IX_HumanResources_Employee_Example 
	ON HumanResources.Employee WITH (ONLINE = OFF)
GO