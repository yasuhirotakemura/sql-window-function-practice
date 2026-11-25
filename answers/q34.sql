SELECT customer_id,order_id,rating,last_value(rating IGNORE NULLS) OVER (PARTITION BY customer_id ORDER BY ordered_at,order_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS latest_rating
FROM orders ORDER BY customer_id,ordered_at,order_id;
