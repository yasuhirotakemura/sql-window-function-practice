SELECT product_id,month_start,amount,
sum(amount) OVER (PARTITION BY product_id ORDER BY month_start ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING) AS previous_3m
FROM product_monthly ORDER BY product_id,month_start;
