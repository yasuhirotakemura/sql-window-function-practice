SELECT sale_date,amount,sum(amount) OVER (ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_amount
FROM daily_sales ORDER BY sale_date;
