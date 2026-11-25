SELECT product_id,stock_date,lag(stock_date) OVER (PARTITION BY product_id ORDER BY stock_date) AS previous_date,
date_diff('day',previous_date,stock_date)-1 AS missing_days
FROM inventory QUALIFY missing_days>0 ORDER BY product_id,stock_date;
