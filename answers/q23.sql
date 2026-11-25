SELECT product_id,month_start,amount,lag(amount) OVER (PARTITION BY product_id ORDER BY month_start) AS prev_amount
FROM product_monthly
QUALIFY amount<prev_amount ORDER BY product_id,month_start;
