# 基礎編

共通ルールは [README](../README.md)、列定義は [データ定義](../reference/data_dictionary.md)。

## Q01 全取引の新しい順

ordersの全行に、新しい注文から1始まりの連番を付ける。同時刻はorder_id昇順。出力: order_id, ordered_at, seq。

作業ファイル: [q01.sql](../workspace/q01.sql)

## Q02 顧客別の注文順

ordersで顧客ごとに古い順の注文番号を付ける。同時刻はorder_id昇順。出力: customer_id, order_id, seq。

作業ファイル: [q02.sql](../workspace/q02.sql)

## Q03 顧客別最新注文

ordersから顧客ごとに最新注文を1件取得。同時刻はorder_id昇順。出力: customer_id, order_id, ordered_at。

作業ファイル: [q03.sql](../workspace/q03.sql)

## Q04 地域別の給与順位

employeesの給与を地域内で高い順に順位付け。同額同順位、欠番あり。出力: region, employee_id, salary, salary_rank。

作業ファイル: [q04.sql](../workspace/q04.sql)

## Q05 部署別の給与階級

employeesの部署内で給与が高い順に同額同順位・欠番なしの順位を付ける。出力: department, employee_id, salary, salary_rank。

作業ファイル: [q05.sql](../workspace/q05.sql)

## Q06 明細と顧客注文数

ordersの各行に当該顧客の全注文数を付加。出力: order_id, customer_id, order_count。

作業ファイル: [q06.sql](../workspace/q06.sql)

## Q07 売上明細と顧客累計額

salesの各明細に顧客の年間売上総額を付加。出力: order_id, customer_id, amount, customer_total。

作業ファイル: [q07.sql](../workspace/q07.sql)

## Q08 部署平均給与

employeesの各行に所属部署の平均給与と平均との差を追加。出力: employee_id, salary, dept_avg, diff。

作業ファイル: [q08.sql](../workspace/q08.sql)

## Q09 商品最低在庫

inventoryの全行に商品ごとの観測期間中の最低在庫を付加。出力: product_id, stock_date, stock_qty, min_stock。

作業ファイル: [q09.sql](../workspace/q09.sql)

## Q10 前回購入額

salesで顧客ごとに直前の購入額を付加。古い順、同時刻はorder_id昇順。初回NULL。出力: customer_id, order_id, amount, prev_amount。

作業ファイル: [q10.sql](../workspace/q10.sql)

## Q11 次のアクセス時刻

access_logsで顧客ごとの次回操作時刻を付加。時刻昇順、同時刻はlog_id昇順。出力: customer_id, log_id, event_at, next_event_at。

作業ファイル: [q11.sql](../workspace/q11.sql)

## Q12 最初の購入時刻

sales各行に顧客の初回購入時刻を付ける。出力: customer_id, order_id, first_purchase_at。

作業ファイル: [q12.sql](../workspace/q12.sql)

## Q13 日別累積売上

daily_salesの各日に年初から当日までの累積売上を付加。出力: sale_date, amount, cumulative_amount。

作業ファイル: [q13.sql](../workspace/q13.sql)

## Q14 直近3日平均

daily_salesで当日を含む直近3日間の平均売上。最初の2日も存在する日だけで計算。出力: sale_date, amount, avg_3d。

作業ファイル: [q14.sql](../workspace/q14.sql)

## Q15 評価済み件数

ordersの全行に顧客の全注文数とrating非NULLの件数を付加。出力: order_id, customer_id, total_count, rated_count。

作業ファイル: [q15.sql](../workspace/q15.sql)

