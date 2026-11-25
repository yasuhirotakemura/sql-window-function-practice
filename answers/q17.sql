SELECT customer_id,order_id,ordered_at,row_number() OVER (PARTITION BY customer_id ORDER BY ordered_at DESC,order_id) AS rn
FROM orders
QUALIFY rn<=3 ORDER BY customer_id,rn;
