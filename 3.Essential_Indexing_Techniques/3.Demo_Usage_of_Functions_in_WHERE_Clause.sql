/*********************************************************************************
**********  Using Functions in WHERE Clause  *************************************
*********************************************************************************/
USE tempdb
GO

SET STATISTICS IO ON
GO

-- Create Table
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDFEffect]') AND type in (N'U'))
	DROP TABLE [dbo].[UDFEffect]
GO
CREATE TABLE UDFEffect ( ID			Int
						,FirstName	VARCHAR(100)
						,LastName	VARCHAR(100)
						,City		VARCHAR(100)
						)
GO
-- Insert One Hundred Thousand Records
INSERT INTO [UDFEffect] (ID, FirstName,LastName,City)
SELECT TOP 100000 ROW_NUMBER() OVER (ORDER BY a.name) RowID,
					'Bob', 
					CASE WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%2 = 1 THEN 'Smith' 
					ELSE 'Brown' END,
					CASE WHEN ROW_NUMBER() OVER (ORDER BY a.name)%10 = 1 THEN 'New York' 
						WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%10 = 5 THEN 'Salt Lake City' 
						WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%10 = 3 THEN 'Los Angeles' 
						WHEN ROW_NUMBER() OVER (ORDER BY a.name)%427 = 1 THEN 'Ahmedabad'
					ELSE 'Houston' END
FROM sys.all_objects a
CROSS JOIN sys.all_objects b
GO
INSERT INTO [UDFEffect] (ID, FirstName,LastName,City)
SELECT 100001,'FirstNameTest','SecondNameTest','CityNameTest'
GO

-- Create Clustered Index
CREATE CLUSTERED INDEX IX_UDFEffect_ID
ON UDFEffect(ID)
GO
-- Create NonClustered Index
CREATE NONCLUSTERED INDEX IX_UDFEffect_City
ON UDFEffect(City)
GO
-- Create NonClustered Index
CREATE NONCLUSTERED INDEX IX_UDFEffect_ID_City
ON UDFEffect(ID,City)
GO

-- Run the following two SELECT statements together and see the execution plan and compare the execution cost
-- SELECT TABLE
SELECT	 ID
		,City
FROM UDFEffect
WHERE City = 'Salt Lake City'
GO
-- Performs an Index Seek with 10% cost 
-- SELECT TABLE
SELECT	 ID
		,City
FROM UDFEffect
WHERE RTRIM(LTRIM(City)) = 'Salt Lake City'
GO
-- Performs an Index Scan with 90% cost

-- Question: What is the reason for UDF Reducing Performance?
	-- the RTRIM and LTRIM
-- How to solve the issue?
	-- Adding a Computed Column can solve the performance degradation problem

-- Add Computed Column
ALTER TABLE dbo.UDFEffect ADD
	CityTrim AS RTRIM(LTRIM(City))
GO

-- Run the following two SELECT statements together and see the execution plan and compare the execution cost
-- SELECT TABLE
SELECT	 ID
		,City
FROM UDFEffect
WHERE City = 'Salt Lake City'
GO
-- Performs an Index Seek with 10% cost 
-- SELECT TABLE
SELECT	 ID
		,City
FROM UDFEffect
WHERE CityTrim = 'Salt Lake City'
GO
-- Performs an Index Scan with 90% cost

-- Question Why has the computed column not reduced the performance degradation?
	-- Because it has not been index!!!

-- Create NonClustered Index on Computed Column
CREATE NONCLUSTERED INDEX IX_UDFEffect_ID_CityTrim
ON UDFEffect(CityTrim,ID,City)
GO
-- When creating an index on the computed column make sure it is deterministic

-- Run the following two SELECT statements together and see the execution plan and compare the execution cost
-- SELECT TABLE
SELECT	 ID
		,City
FROM UDFEffect
WHERE City = 'Salt Lake City'
GO
-- Performs an Index Seek with 44% cost 
-- SELECT TABLE
SELECT	 ID
		,City
FROM UDFEffect
WHERE CityTrim = 'Salt Lake City'
GO
-- Performs an Index Scan with 56% cost

-- Clean Up
SET STATISTICS IO OFF