SELECT region,customer_id,amount,percent_rank() OVER (PARTITION BY region ORDER BY amount) AS relative_rank
FROM customer_sales ORDER BY region,amount,customer_id;
