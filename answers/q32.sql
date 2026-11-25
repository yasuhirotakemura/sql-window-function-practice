SELECT order_id,customer_id,first_value(order_id) OVER w AS first_id,last_value(order_id) OVER w AS last_id
FROM orders
WINDOW w AS (PARTITION BY customer_id ORDER BY ordered_at,order_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) ORDER BY order_id;
