SELECT region,customer_id,amount,quantile_cont(amount,0.9) OVER (PARTITION BY region) AS p90,amount-p90 AS diff
FROM customer_sales ORDER BY region,customer_id;
