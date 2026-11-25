WITH latest AS (
 SELECT * FROM orders QUALIFY row_number() OVER (PARTITION BY source_ref ORDER BY order_id DESC)=1
), totals AS (
 SELECT c.region,c.customer_id,coalesce(sum(o.quantity*o.unit_price*(100-o.discount_pct)//100),0) AS amount
 FROM customers c LEFT JOIN latest o ON c.customer_id=o.customer_id AND o.status='completed' GROUP BY 1,2
)
SELECT *,row_number() OVER (PARTITION BY region ORDER BY amount DESC,customer_id) AS rn
FROM totals QUALIFY rn<=5 ORDER BY region,rn;
