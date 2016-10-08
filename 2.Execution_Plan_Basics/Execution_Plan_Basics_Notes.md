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
   
   ## Non-Clustered Index Seek
     - When
       - Columns part of non-clustered index accessed in query and rows located in B+ tree
     - Good or Bad
       - Good
     - Action Item
       - Further evaluate other operators
  
  ## Lookups
    - When
      - Query Optimizer uses non-custered index to search few column data and base table for other columns data
    - Good or Bad
      - Bad
    - Action Item
      - Included Index or Covered Index
    - When the query optimizer uses the Non-Clustered Index to narrow down the number of rows to get the columns needed as part of the table or the select condition, it needs to hop to the base table and then lookups will start.  
    - Lookups can be deterrent to performance unless you use a covered index or included index

