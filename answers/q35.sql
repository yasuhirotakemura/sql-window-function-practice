SELECT region,customer_id,amount,median(amount) OVER (PARTITION BY region) AS region_median
FROM customer_sales
QUALIFY amount>region_median ORDER BY region,customer_id;
