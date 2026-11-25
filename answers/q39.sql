SELECT source_ref,order_id,customer_id,count(*) OVER (PARTITION BY source_ref) AS duplicate_count
FROM orders QUALIFY duplicate_count>1 ORDER BY source_ref,order_id;
