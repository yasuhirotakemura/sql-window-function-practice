SELECT customer_id,order_id,first_value(ordered_at) OVER (PARTITION BY customer_id ORDER BY ordered_at,order_id) AS first_purchase_at
FROM sales ORDER BY customer_id,order_id;
