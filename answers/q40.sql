SELECT product_id,stock_date,avg(stock_qty) OVER (PARTITION BY product_id ORDER BY stock_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS smoothed_stock
FROM inventory ORDER BY product_id,stock_date;
