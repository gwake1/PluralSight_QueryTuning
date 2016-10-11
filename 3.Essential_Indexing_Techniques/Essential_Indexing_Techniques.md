# Unused Indexes
  - Consumes unnecessary disk space
  - Queries may use less efficient index
  - Less efficient execution plan
  - Reduction in overall server performance
  - Confusion among developer when troubleshooting
  - Best Practice: Drop Unused Indexes

# Duplicate Index
  - Reduces the performance of INSERT, UPDATE, DELETE Query
  - No performance advantages to SELECTs
  - Wasteful of space
  - Best Practice: Drop Duplicate Indexes

# Missing Index
  - Analysis worload over period of the time
  - Create Clustered Index on table if necessary
  - Create indexes for most critical queries for performance
  - Narrow width indexes are preferred
  - Careful with column order in indexes
  - Best Practice: Create Missing Indexes

# Seek vs Scan vs Lookup
  - Create clustered index
    - if seeing a scan
  - Create cover index
    - for a scan on restrictive number of columns
  - Create included index
    - for a scan on restrictive number of columns
  - Use most selective column as first column

# Index Best Practices
  - Create narrow Index
    - Try to use Included Index!!!
  - Prefer Integer Column for Index
  - Use most selective column as first column
  - Avoid using function in WHERE Clause


