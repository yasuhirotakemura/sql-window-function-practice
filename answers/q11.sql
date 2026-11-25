SELECT customer_id,log_id,event_at,lead(event_at) OVER (PARTITION BY customer_id ORDER BY event_at,log_id) AS next_event_at
FROM access_logs ORDER BY customer_id,event_at,log_id;
