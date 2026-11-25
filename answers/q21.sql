SELECT customer_id,order_id,date_diff('day',lag(sale_date) OVER (PARTITION BY customer_id ORDER BY ordered_at,order_id),sale_date) AS days_since_prev
FROM sales ORDER BY customer_id,ordered_at,order_id;
