# PluralSight QueryTuning 
https://app.pluralsight.com/library/courses/query-tuning-introduction/table-of-contents

Config:

## Location of the AdventureWorks database  http://bit.ly/sa-adw

## SQL Query to Attach to database
```SQL
  CREATE DATABASE AdventureWorks2012
  ON (FILENAME = '/C/Program Files/Microsoft SQL Server/MSSQL12.LOCALHOST/MSSQL/DATA/AdventureWorks2012_Data.mdf')
  FOR ATTACH_REBUILD_LOG;
```
