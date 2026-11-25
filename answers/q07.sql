SELECT order_id, customer_id, amount, sum(amount) OVER (PARTITION BY customer_id) AS customer_total
FROM sales ORDER BY order_id;
