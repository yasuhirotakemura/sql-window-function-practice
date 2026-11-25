WITH latest AS (
 SELECT customer_id,order_id,status FROM orders
 QUALIFY row_number() OVER (PARTITION BY customer_id ORDER BY ordered_at DESC,order_id)=1
)
SELECT * FROM latest WHERE status='cancelled' ORDER BY customer_id;
