# Avoid ```SQL SELECT * ```
  - Retrieves unnecessary data
    - Increase network traffic
  - Defaults to Clustered index usage
    - May not use optimal indexes
  - Application may break as column order changes
    - Issues when used in views

# ```SQL Exists``` vs ```SQL IN``` vs ```SQL JOIN```
  - Comparison
    - ```SQL IN```
    - ```SQL Exists```
    - ```SQL JOIN```
  - IN and EXISTS gives mostly same result and performance
  - JOIN may not send the same results as IN or EXIST clause
