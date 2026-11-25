SELECT product_id,month_start,amount,
max(amount) OVER (PARTITION BY product_id ORDER BY month_start ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS previous_max
FROM product_monthly QUALIFY amount>previous_max ORDER BY product_id,month_start;
