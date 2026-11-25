SELECT sale_date,amount,avg(amount) OVER (ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_3d
FROM daily_sales ORDER BY sale_date;
