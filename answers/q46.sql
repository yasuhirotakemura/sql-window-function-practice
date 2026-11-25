WITH totals AS (
 SELECT s.month_start,p.category,s.product_id,sum(s.amount) AS amount
 FROM sales s JOIN products p USING(product_id) GROUP BY 1,2,3
)
SELECT *,row_number() OVER (PARTITION BY month_start,category ORDER BY amount DESC,product_id) AS rn
FROM totals QUALIFY rn<=2 ORDER BY month_start,category,rn;
