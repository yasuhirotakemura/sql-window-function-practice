SELECT customer_id, order_id, amount, lag(amount) OVER (PARTITION BY customer_id ORDER BY ordered_at,order_id) AS prev_amount
FROM sales ORDER BY customer_id,ordered_at,order_id;
