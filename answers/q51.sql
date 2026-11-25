WITH running AS (
 SELECT customer_id,amount,sum(amount) OVER (ORDER BY amount DESC,customer_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_amount,
 sum(amount) OVER () AS total FROM customer_sales
)
SELECT customer_id,amount,cumulative_amount,cumulative_amount::DOUBLE/total AS cumulative_share
FROM running WHERE total>0 AND (cumulative_amount-amount)*5<total*4
ORDER BY amount DESC,customer_id;
