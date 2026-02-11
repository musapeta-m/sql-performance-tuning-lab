/* Identify what the SQL Server is waiting on most */
SELECT TOP 10
    wait_type, 
    wait_time_ms / 1000.0 AS Wait_S,
    100.0 * wait_time_ms / SUM(wait_time_ms) OVER() AS Percentage
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN ('CLR_SEMAPHORE','LAZYWRITER_SLEEP','RESOURCE_QUEUE','SLEEP_TASK')
ORDER BY wait_time_ms DESC;