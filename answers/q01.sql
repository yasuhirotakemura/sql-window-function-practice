SELECT order_id, ordered_at, row_number() OVER (ORDER BY ordered_at DESC, order_id) AS seq
FROM orders ORDER BY seq;
