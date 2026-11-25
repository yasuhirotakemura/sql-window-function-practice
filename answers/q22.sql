SELECT product_id,month_start,amount,lag(amount) OVER (PARTITION BY product_id ORDER BY month_start) AS prev_amount,amount-prev_amount AS diff
FROM product_monthly ORDER BY product_id,month_start;
