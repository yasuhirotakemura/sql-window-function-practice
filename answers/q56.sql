WITH lagged AS (
 SELECT *,lag(amount) OVER (PARTITION BY product_id ORDER BY month_start) AS prev_amount FROM product_monthly
), falling AS (
 SELECT product_id,month_start,date_diff('month',DATE '2025-01-01',month_start)-row_number() OVER (PARTITION BY product_id ORDER BY month_start) AS island
 FROM lagged WHERE amount<prev_amount
), periods AS (
 SELECT product_id,min(month_start) AS start_month,max(month_start) AS end_month,count(*) AS months FROM falling GROUP BY product_id,island
)
SELECT * FROM periods QUALIFY row_number() OVER (PARTITION BY product_id ORDER BY months DESC,start_month)=1 ORDER BY product_id;
