# Execution Plans are like Weather Forecasts
  The execution plan window does not always operate exactly as projected
  - Estimated Execution Plan is the forecast based on environmental variables (memory, cpu, io) and statistics
  - Actual Execution Plan is whether it rained or not

# Query Optimization

 - SQL Server is a cost based query execution 
   - Query with lowest cost will be executed
     - factors in cpu, memery, and IO
 
 - Example of Logical (Inner) Join
   - SQL Server physically executes this command as a nested loop join

# Display Options of Execution Plans

 - SET STATISTICS TIME ON
 - SET STATISTICS IO ON

# Execution Plan Operators

  ## Table Scan 
      - when a table is there without a clustered index therefore SQL server doesn't have a particular order in which it stores information.
    - When
      - Table without clustered index is accessed
    - Good or Bad
      - Can't decide
      - For small tables it doesn't make sense to do it
      - When large it is a good idea
    - Action Item
      - Create Clustered Index
        - In General: If you have only one index on a table it should be a clustered index

  ## Clustered Index Scan
    - When
      - Table with clustered index is accessed
        - Query does not use non clustered index
	-  Table does not have non clustered index
    - Good or Bad
      - Bad unless large data with most columns and rows retrieved
    - Action Item
      - Create clustered index

  ## Clustered Index Seek
    - When
      - Table with clustered index is accessed and query locates specific rows in B+ tree
    - Good or Bad
      - Good
    - Action Item
      - Evaluate possibility of non-clustered index

  ## Non-Clustered Index Scan
    - When 
      - Columns part of non-clustered index accessed in query
    - Good or Bad
      - Bad unless large data with most columns and rows retrieved
    - Action item
      - Create more refined non-clustered index

