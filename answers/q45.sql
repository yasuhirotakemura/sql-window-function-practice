SELECT customer_id,order_id,amount,
lag(amount,2) OVER (PARTITION BY customer_id ORDER BY ordered_at,order_id) AS prev2_amount,
amount-prev2_amount AS diff
FROM sales ORDER BY customer_id,ordered_at,order_id;
