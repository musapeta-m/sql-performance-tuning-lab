/* Identify queries with highest total execution time */
SELECT 
    query, 
    calls, 
    total_exec_time / 1000 AS total_sec, 
    mean_exec_time AS avg_ms
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;