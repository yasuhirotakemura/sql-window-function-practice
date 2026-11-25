WITH r AS (
 SELECT product_id,amount,sum(amount) OVER (ORDER BY amount DESC,product_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)-amount AS before_amount,
 sum(amount) OVER () AS total FROM product_sales
)
SELECT product_id,amount,CASE WHEN total=0 THEN 'C' WHEN before_amount*10<total*7 THEN 'A'
 WHEN before_amount*10<total*9 THEN 'B' ELSE 'C' END AS abc_class
FROM r ORDER BY amount DESC,product_id;
