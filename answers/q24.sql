SELECT sale_date,amount,sum(amount) OVER (PARTITION BY date_trunc('month',sale_date) ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS month_cumulative
FROM daily_sales ORDER BY sale_date;
