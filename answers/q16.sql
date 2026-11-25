SELECT source_ref,order_id,customer_id
FROM orders
QUALIFY row_number() OVER (PARTITION BY source_ref ORDER BY order_id DESC)=1 ORDER BY source_ref;
