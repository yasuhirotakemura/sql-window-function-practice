WITH prev AS (
 SELECT *,lag(event_at) OVER (PARTITION BY customer_id ORDER BY event_at,log_id) AS prev_at FROM access_logs
), sessions AS (
 SELECT *,sum(CASE WHEN prev_at IS NULL OR event_at-prev_at>INTERVAL 30 MINUTE THEN 1 ELSE 0 END)
 OVER (PARTITION BY customer_id ORDER BY event_at,log_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS session_no FROM prev
)
SELECT customer_id,session_no,min(event_at) AS started_at,max(event_at) AS ended_at,
count(*) AS event_count,count(*) FILTER (WHERE event_type='purchase') AS purchase_count
FROM sessions GROUP BY 1,2 HAVING count(*) FILTER (WHERE event_type='purchase')>0 ORDER BY 1,2;
