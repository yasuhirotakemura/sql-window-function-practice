WITH ranked AS (
 SELECT *,ntile(10) OVER (PARTITION BY region ORDER BY amount DESC,customer_id) AS decile FROM customer_sales
), totals AS (
 SELECT region,decile,count(*) AS customer_count,sum(amount) AS amount FROM ranked GROUP BY 1,2
)
SELECT *,sum(amount) OVER (PARTITION BY region ORDER BY decile ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)::DOUBLE/
 nullif(sum(amount) OVER (PARTITION BY region),0) AS cumulative_share
FROM totals ORDER BY region,decile;
