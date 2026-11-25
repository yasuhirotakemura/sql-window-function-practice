SELECT customer_id, order_id, ordered_at
FROM orders
QUALIFY row_number() OVER (PARTITION BY customer_id ORDER BY ordered_at DESC, order_id)=1 ORDER BY customer_id;
