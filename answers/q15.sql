SELECT order_id,customer_id,count(*) OVER (PARTITION BY customer_id) AS total_count,count(rating) OVER (PARTITION BY customer_id) AS rated_count
FROM orders ORDER BY order_id;
