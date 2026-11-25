# データ定義

CSVはUTF-8、カンマ区切り。空欄はNULL。IDは整数。

## customers

```text
customer_id INTEGER
region VARCHAR
signup_date DATE
tier VARCHAR
age INTEGER
```

## products

```text
product_id INTEGER
product_name VARCHAR
category VARCHAR
list_price INTEGER
```

## employees

```text
employee_id INTEGER
department VARCHAR
region VARCHAR
hire_date DATE
salary INTEGER
```

## orders

```text
order_id INTEGER
source_ref VARCHAR
customer_id INTEGER
product_id INTEGER
employee_id INTEGER
ordered_at TIMESTAMP
quantity INTEGER
unit_price INTEGER
discount_pct INTEGER
channel VARCHAR
status VARCHAR
rating INTEGER
```

## access_logs

```text
log_id INTEGER
customer_id INTEGER
event_at TIMESTAMP
event_type VARCHAR
device VARCHAR
product_id INTEGER
```

## inventory

```text
product_id INTEGER
stock_date DATE
stock_qty INTEGER
received_qty INTEGER
shipped_qty INTEGER
```

## sales_targets

```text
employee_id INTEGER
month_start DATE
target_amount INTEGER
```

## 粒度・意味

| テーブル | 粒度・キー | 件数 |
|---|---|---:|
| customers | 顧客、customer_id | 500 |
| products | 商品、product_id | 100 |
| employees | 従業員、employee_id | 100 |
| orders | 取引、order_id。一部source_ref重複（後着IDが大きい） | 10000 |
| access_logs | 操作、log_id。同時刻あり | 20000 |
| inventory | 商品×在庫観測日、product_id + stock_date。日付欠損あり | 15000 |
| sales_targets | 従業員×月、employee_id + month_start | 1200 |

orders: quantity=数量、unit_price=単価、discount_pct=割引率（0–100）、channel=販売チャネル、status=completed/returned/cancelled、rating=評価（0–5、NULLは未評価）。source_refは外部連携キー。重複排除問題以外は各order_idを独立取引とする。employees.salary=月給（円）。inventory.stock_qty=観測日時点在庫、received_qty=入荷数、shipped_qty=出荷数。access_logs.product_id はNULLの場合あり。

## 補助ビュー
- sales: orders の completed のみ。sale_date, month_start, amount（数量×単価×割引後割合、整数円）を追加。
- daily_sales: 2025年の全365日、sale_date, amount。売上のない日も0。
- product_monthly: 全商品×2025年12か月、product_id, month_start, amount。売上なしは0。
- customer_sales: 全顧客、customer_id, region, amount。売上なしは0。
- product_sales: 全商品、product_id, category, amount。売上なしは0。

マスタはIDでJOIN。日付はDATE、時刻はTIMESTAMP（タイムゾーンなし）。
