SELECT customer_id, order_id, row_number() OVER (PARTITION BY customer_id ORDER BY ordered_at, order_id) AS seq
FROM orders ORDER BY customer_id, seq;
