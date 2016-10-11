/*********************************************************************************
*************************  Demo: Basics of Index  ********************************
*********************************************************************************/
USE AdventureWorks2012
Go

/*********************************************************************************

Description: Script to show Unused Indexes using DMVs

*********************************************************************************/

SELECT DISTINCT		 OBJECT_NAME(sis.OBJECT_ID) TableName
					,Schema_Name()		AS SchemaName
					,si.name			AS Indexname
					,sc.Name			AS ColumnName
					,sic.Index_ID
					,sis.user_seeks
					,sis.user_scans
					,sis.user_lookups
					,sis.user_updates
					,'DROP INDEX ' + QUOTENAME(si.name) + ' ON ' + QUOTENAME(s.name)  + '.' + QUOTENAME(OBJECT_NAME(sis.OBJECT_ID)) DropIndexCommand
FROM sys.dm_db_index_usage_stats sis
INNER JOIN sys.indexes si on sis.OBJECT_ID =si.OBJECT_ID AND sis.Index_ID = si.Index_id
INNER JOIN sys.index_columns sic ON sis.OBJECT_ID = sic.OBJECT_ID AND sic.Index_ID = si.Index_ID
INNER JOIN sys.columns sc ON sis.OBJECT_ID = sc.OBJECT_ID AND sic.Column_ID = sc.Column_ID
INNER JOIN sys.objects o on sis.object_id = o.object_id
INNER JOIN sys.schemas s on o.schema_id = s.schema_id
WHERE OBJECTPROPERTY(sis.object_id, 'IsUserTable') = 1
AND sis.database_id = DB_ID()
AND si.type_desc = 'nonclustered'
AND si.is_primary_key = 0
AND si.is_unique_constraint = 0
GO
/*********************************************************************************

Description: Script to detect Missing Indexes

*********************************************************************************/
SELECT TOP 25
				 dm_mid.database_id AS DatabaseID
				,dm_migs.avg_user_impact*(dm_migs.user_seeks+dm_migs.user_scans) Avg_Estimated_Impact
				,dm_migs.last_user_seek AS Last_User_Seek,
				OBJECT_NAME(dm_mid.OBJECT_ID,dm_mid.database_id) AS [TableName]
				,'CREATE INDEX [IX_' + OBJECT_NAME(dm_mid.OBJECT_ID,dm_mid.database_id) + '_'
				+ REPLACE(REPLACE(REPLACE(ISNULL(dm_mid.equality_columns,''),', ','_'),'[',''),']','') 
				+ CASE
				WHEN dm_mid.equality_columns IS NOT NULL
				AND dm_mid.inequality_columns IS NOT NULL THEN '_'
				ELSE ''
				END
				+ REPLACE(REPLACE(REPLACE(ISNULL(dm_mid.inequality_columns,''),', ','_'),'[',''),']','')
				+ ']'
				+ ' ON ' + dm_mid.statement
				+ ' (' + ISNULL (dm_mid.equality_columns,'')
				+ CASE WHEN dm_mid.equality_columns IS NOT NULL AND dm_mid.inequality_columns 
				IS NOT NULL THEN ',' ELSE
				'' END
				+ ISNULL (dm_mid.inequality_columns, '')
				+ ')'
				+ ISNULL (' INCLUDE (' + dm_mid.included_columns + ')', '') AS Create_Statement
FROM sys.dm_db_missing_index_groups dm_mig
INNER JOIN sys.dm_db_missing_index_group_stats dm_migs
	ON dm_migs.group_handle = dm_mig.index_group_handle
INNER JOIN sys.dm_db_missing_index_details dm_mid
	ON dm_mig.index_handle = dm_mid.index_handle
WHERE dm_mid.database_ID = DB_ID()
ORDER BY Avg_Estimated_Impact DESC
GO