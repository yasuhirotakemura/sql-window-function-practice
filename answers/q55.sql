WITH zero_days AS (
 SELECT product_id,stock_date,stock_date-CAST(row_number() OVER (PARTITION BY product_id ORDER BY stock_date) AS INTEGER) AS island
 FROM inventory WHERE stock_qty=0
), periods AS (
 SELECT product_id,min(stock_date) AS start_date,max(stock_date) AS end_date,count(*) AS days FROM zero_days GROUP BY product_id,island
)
SELECT * FROM periods QUALIFY row_number() OVER (PARTITION BY product_id ORDER BY days DESC,start_date)=1 ORDER BY product_id;
