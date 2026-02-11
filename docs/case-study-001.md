Case Study: Optimizing High-Latency Financial Queries
🛑 The Problem
A critical reporting query was taking 12 seconds to execute, causing timeouts in the application. Initial monitoring showed High CPU (SOS_SCHEDULER_YIELD) and Excessive Logical Reads.

🔍 The Investigation
Using the High-CPU-Queries.sql script from this lab, I identified the offending execution plan.

Finding: The plan showed an Index Scan instead of a Seek on a table with 50 million rows.

Bottleneck: A "Bookmark Lookup" was occurring because the existing index did not "cover" all the columns required by the SELECT statement.

🛠️ The Solution
I implemented a Covering Index with INCLUDE columns to eliminate the lookup and converted the Scan into a Seek.

SQL:
CREATE INDEX IX_Transaction_Reporting 
ON Transactions (TransactionDate, Status) 
INCLUDE (Amount, CustomerID);


📈 The Results

Metric				Before			After		Improvement
Execution Time		12s450ms		96% 		Faster
Logical Reads		850,0001,200	99% 		Reduction
CPU Usage			High Spike		Negligible	Stabilized