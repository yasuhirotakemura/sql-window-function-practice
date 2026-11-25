SELECT customer_id,order_id,nth_value(amount,2) OVER (PARTITION BY customer_id ORDER BY ordered_at,order_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS second_amount
FROM sales ORDER BY customer_id,order_id;
