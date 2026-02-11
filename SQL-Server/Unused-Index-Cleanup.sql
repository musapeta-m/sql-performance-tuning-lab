/* Purpose: Identify indexes that are costing the system resources 
but are not helping query performance. 
*/
SELECT 
    OBJECT_NAME(i.object_id) AS [TableName], 
    i.name AS [IndexName], 
    s.user_seeks, s.user_scans, s.user_lookups, s.user_updates
FROM sys.indexes i
JOIN sys.dm_db_index_usage_stats s ON s.object_id = i.object_id AND s.index_id = i.index_id
WHERE OBJECTPROPERTY(i.object_id, 'IsUserTable') = 1
AND s.user_seeks = 0 AND s.user_scans = 0 AND s.user_lookups = 0 -- Never used for reads
AND i.type_desc <> 'CLUSTERED' -- Do not drop the table itself!
ORDER BY s.user_updates DESC;