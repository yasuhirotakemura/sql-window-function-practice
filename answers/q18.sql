SELECT category,product_id,amount,row_number() OVER (PARTITION BY category ORDER BY amount DESC,product_id) AS rn
FROM product_sales
QUALIFY rn<=3 ORDER BY category,rn;
