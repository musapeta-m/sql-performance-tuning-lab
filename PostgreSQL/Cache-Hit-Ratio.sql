/* Ideally, hit ratio should be > 99% */
SELECT 
    relname AS table_name, 
    heap_blks_read AS from_disk, 
    heap_blks_hit AS from_cache,
    (heap_blks_hit::float / (heap_blks_hit + heap_blks_read + 1)) * 100 AS hit_ratio
FROM pg_statio_user_tables
ORDER BY heap_blks_read DESC LIMIT 10;