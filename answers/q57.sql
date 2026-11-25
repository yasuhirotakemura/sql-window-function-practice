WITH firsts AS (
 SELECT customer_id,sale_date AS first_date,lead(sale_date) OVER w AS second_date FROM sales
 WINDOW w AS (PARTITION BY customer_id ORDER BY ordered_at,order_id)
 QUALIFY row_number() OVER w=1
)
SELECT CAST(date_trunc('month',first_date) AS DATE) AS cohort_month,count(*) AS customers_count,
count(*) FILTER (WHERE date_diff('day',first_date,second_date) BETWEEN 0 AND 30) AS repeat_count,
repeat_count::DOUBLE/customers_count AS repeat_rate
FROM firsts WHERE first_date<=DATE '2025-12-01' GROUP BY 1 ORDER BY 1;
