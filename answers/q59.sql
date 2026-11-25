WITH rankings AS (
 SELECT m.month_start,p.category,m.product_id,m.amount,
 rank() OVER (PARTITION BY m.month_start,p.category ORDER BY m.amount DESC) AS current_rank
 FROM product_monthly m JOIN products p USING(product_id)
)
SELECT *,lag(current_rank) OVER (PARTITION BY product_id ORDER BY month_start) AS previous_rank,
previous_rank-current_rank AS improvement
FROM rankings QUALIFY improvement>0 ORDER BY month_start,category,product_id;
