SELECT order_id, customer_id, count(*) OVER (PARTITION BY customer_id) AS order_count
FROM orders ORDER BY order_id;
