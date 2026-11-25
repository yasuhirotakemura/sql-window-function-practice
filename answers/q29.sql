SELECT customer_id,amount,ntile(10) OVER (ORDER BY amount DESC,customer_id) AS decile
FROM customer_sales ORDER BY decile,amount DESC,customer_id;
