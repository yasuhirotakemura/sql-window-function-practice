SELECT customer_id,amount,cume_dist() OVER (ORDER BY amount) AS cumulative_dist
FROM customer_sales ORDER BY amount,customer_id;
