WITH prev AS (
 SELECT *,lag(event_at) OVER (PARTITION BY customer_id ORDER BY event_at,log_id) AS prev_at FROM access_logs
), flags AS (
 SELECT *,CASE WHEN prev_at IS NULL OR event_at-prev_at>INTERVAL 30 MINUTE THEN 1 ELSE 0 END AS is_start FROM prev
)
SELECT customer_id,log_id,event_at,sum(is_start) OVER (PARTITION BY customer_id ORDER BY event_at,log_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS session_no
FROM flags ORDER BY customer_id,event_at,log_id;
