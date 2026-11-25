SELECT customer_id,order_id,lag(amount,2) OVER w AS prev2_amount,
lag(amount) OVER w AS prev_amount,amount FROM sales
WINDOW w AS (PARTITION BY customer_id ORDER BY ordered_at,order_id)
QUALIFY prev2_amount<prev_amount AND prev_amount<amount ORDER BY customer_id,order_id;
