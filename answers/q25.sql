SELECT product_id,stock_date,avg(stock_qty) OVER (PARTITION BY product_id ORDER BY stock_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS avg_stock
FROM inventory ORDER BY product_id,stock_date;
