SELECT customer_id,order_id,ordered_at,amount,
sum(amount) OVER (PARTITION BY customer_id ORDER BY ordered_at RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_amount
FROM sales ORDER BY customer_id,ordered_at,order_id;
