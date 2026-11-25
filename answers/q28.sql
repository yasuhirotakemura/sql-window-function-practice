SELECT category,product_id,amount,amount::DOUBLE/nullif(sum(amount) OVER (PARTITION BY category),0) AS share
FROM product_sales ORDER BY category,product_id;
