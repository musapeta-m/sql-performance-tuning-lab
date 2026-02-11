/* Find the top 10 queries consuming most CPU */
SELECT TOP 10
    st.text AS [Query Text],
    qs.total_worker_time / qs.execution_count AS [Avg CPU Time],
    qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY [Avg CPU Time] DESC;