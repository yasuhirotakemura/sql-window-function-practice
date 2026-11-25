CREATE OR REPLACE TABLE customers AS
SELECT * FROM read_csv('data/customers.csv', header=true, auto_detect=false, columns={'customer_id':'INTEGER', 'region':'VARCHAR', 'signup_date':'DATE', 'tier':'VARCHAR', 'age':'INTEGER'});

CREATE OR REPLACE TABLE products AS
SELECT * FROM read_csv('data/products.csv', header=true, auto_detect=false, columns={'product_id':'INTEGER', 'product_name':'VARCHAR', 'category':'VARCHAR', 'list_price':'INTEGER'});

CREATE OR REPLACE TABLE employees AS
SELECT * FROM read_csv('data/employees.csv', header=true, auto_detect=false, columns={'employee_id':'INTEGER', 'department':'VARCHAR', 'region':'VARCHAR', 'hire_date':'DATE', 'salary':'INTEGER'});

CREATE OR REPLACE TABLE orders AS
SELECT * FROM read_csv('data/orders.csv', header=true, auto_detect=false, columns={'order_id':'INTEGER', 'source_ref':'VARCHAR', 'customer_id':'INTEGER', 'product_id':'INTEGER', 'employee_id':'INTEGER', 'ordered_at':'TIMESTAMP', 'quantity':'INTEGER', 'unit_price':'INTEGER', 'discount_pct':'INTEGER', 'channel':'VARCHAR', 'status':'VARCHAR', 'rating':'INTEGER'});

CREATE OR REPLACE TABLE access_logs AS
SELECT * FROM read_csv('data/access_logs.csv', header=true, auto_detect=false, columns={'log_id':'INTEGER', 'customer_id':'INTEGER', 'event_at':'TIMESTAMP', 'event_type':'VARCHAR', 'device':'VARCHAR', 'product_id':'INTEGER'});

CREATE OR REPLACE TABLE inventory AS
SELECT * FROM read_csv('data/inventory.csv', header=true, auto_detect=false, columns={'product_id':'INTEGER', 'stock_date':'DATE', 'stock_qty':'INTEGER', 'received_qty':'INTEGER', 'shipped_qty':'INTEGER'});

CREATE OR REPLACE TABLE sales_targets AS
SELECT * FROM read_csv('data/sales_targets.csv', header=true, auto_detect=false, columns={'employee_id':'INTEGER', 'month_start':'DATE', 'target_amount':'INTEGER'});

-- 売上集計用。source_ref は連携重複キーで、売上問題では重複除外を要求しない限り各 order_id を独立取引として扱う。
CREATE OR REPLACE VIEW sales AS
SELECT *, CAST(ordered_at AS DATE) AS sale_date,
       CAST(date_trunc('month', ordered_at) AS DATE) AS month_start,
       quantity * unit_price * (100 - discount_pct) // 100 AS amount
FROM orders WHERE status = 'completed';

CREATE OR REPLACE VIEW daily_sales AS
SELECT CAST(d.day AS DATE) AS sale_date, coalesce(sum(s.amount),0) AS amount
FROM generate_series(DATE '2025-01-01', DATE '2025-12-31', INTERVAL 1 DAY) AS d(day)
LEFT JOIN sales s ON s.sale_date = CAST(d.day AS DATE)
GROUP BY 1;

CREATE OR REPLACE VIEW product_monthly AS
SELECT p.product_id, CAST(m.month AS DATE) AS month_start, coalesce(sum(s.amount),0) AS amount
FROM products p CROSS JOIN generate_series(DATE '2025-01-01', DATE '2025-12-01', INTERVAL 1 MONTH) AS m(month)
LEFT JOIN sales s ON s.product_id=p.product_id AND s.month_start=CAST(m.month AS DATE)
GROUP BY 1,2;

CREATE OR REPLACE VIEW customer_sales AS
SELECT c.customer_id, c.region, coalesce(sum(s.amount),0) AS amount
FROM customers c LEFT JOIN sales s USING(customer_id)
GROUP BY 1,2;

CREATE OR REPLACE VIEW product_sales AS
SELECT p.product_id, p.category, coalesce(sum(s.amount),0) AS amount
FROM products p LEFT JOIN sales s USING(product_id)
GROUP BY 1,2;
