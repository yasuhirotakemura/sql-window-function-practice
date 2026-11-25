SELECT order_id,customer_id,count(*) OVER w AS total_count,
count(*) FILTER (WHERE status='completed') OVER w AS completed_count,
completed_count::DOUBLE/nullif(total_count,0) AS completed_rate
FROM orders WINDOW w AS (PARTITION BY customer_id) ORDER BY order_id;
