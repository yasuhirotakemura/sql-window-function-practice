SELECT product_id, stock_date, stock_qty, min(stock_qty) OVER (PARTITION BY product_id) AS min_stock
FROM inventory ORDER BY product_id,stock_date;
