SELECT customer_id,amount,amount::DOUBLE/nullif(sum(amount) OVER (),0) AS share
FROM customer_sales ORDER BY customer_id;
