WITH totals AS (
 SELECT customer_id,channel,sum(amount) AS amount FROM sales GROUP BY 1,2
)
SELECT * FROM totals QUALIFY row_number() OVER (PARTITION BY customer_id ORDER BY amount DESC,channel)=1 ORDER BY customer_id;
