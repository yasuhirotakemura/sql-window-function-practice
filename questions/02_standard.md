# 標準編

共通ルールは [README](../README.md)、列定義は [データ定義](../reference/data_dictionary.md)。

## Q16 連携キー重複排除

ordersのsource_refごとに後着レコード（order_id最大）を1件残す。出力: source_ref, order_id, customer_id。

作業ファイル: [q16.sql](../workspace/q16.sql)

## Q17 顧客ごと直近3注文

ordersから顧客別最新3件（3件未満は全件）。同時刻はorder_id昇順。出力: customer_id, order_id, ordered_at, rn。

作業ファイル: [q17.sql](../workspace/q17.sql)

## Q18 カテゴリ別売上トップ3

product_salesからカテゴリ内で売上上位3商品。固定3件、同額はproduct_id昇順。出力: category, product_id, amount, rn。

作業ファイル: [q18.sql](../workspace/q18.sql)

## Q19 給与上位3順位

employeesの部署別給与上位3順位の全員。同額同順位・欠番あり。出力: department, employee_id, salary, rnk。

作業ファイル: [q19.sql](../workspace/q19.sql)

## Q20 給与上位3水準

employeesの部署別に高い方から異なる給与額3水準に属する全員。出力: department, employee_id, salary, rnk。

作業ファイル: [q20.sql](../workspace/q20.sql)

## Q21 購入間隔

salesの顧客ごとに直前購入からの日数（暦日差）を求める。同時刻はorder_id昇順。初回NULL。出力: customer_id, order_id, days_since_prev。

作業ファイル: [q21.sql](../workspace/q21.sql)

## Q22 前月売上比較

product_monthlyの各商品・月で前月売上と差額を算出。1月はNULL。出力: product_id, month_start, amount, prev_amount, diff。

作業ファイル: [q22.sql](../workspace/q22.sql)

## Q23 前月割れ商品

product_monthlyで前月比売上が減少した商品・月のみ抽出。出力: product_id, month_start, amount, prev_amount。

作業ファイル: [q23.sql](../workspace/q23.sql)

## Q24 月内累積売上

daily_salesで月初から各日までの累積を算出。出力: sale_date, amount, month_cumulative。

作業ファイル: [q24.sql](../workspace/q24.sql)

## Q25 観測7行の在庫平均

inventoryで商品別に当日を含む直近7観測行の平均在庫。出力: product_id, stock_date, avg_stock。

作業ファイル: [q25.sql](../workspace/q25.sql)

## Q26 暦日7日の在庫平均

inventoryで商品別に当日を含む直近7暦日内の観測値だけで平均在庫。出力: product_id, stock_date, avg_stock。

作業ファイル: [q26.sql](../workspace/q26.sql)

## Q27 顧客売上構成比

customer_salesで年間総売上に占める各顧客の割合（0〜1）。出力: customer_id, amount, share。

作業ファイル: [q27.sql](../workspace/q27.sql)

## Q28 カテゴリ内売上構成比

product_salesでカテゴリ総売上に占める商品の割合（0〜1）。出力: category, product_id, amount, share。

作業ファイル: [q28.sql](../workspace/q28.sql)

## Q29 顧客デシル

customer_salesの全顧客を売上降順・customer_id昇順で人数がほぼ均等な10群に分類。1が最高。出力: customer_id, amount, decile。

作業ファイル: [q29.sql](../workspace/q29.sql)

## Q30 地域内の相対順位

customer_salesで地域別に売上昇順の相対順位（最小0、最大は同率でなければ1）。出力: region, customer_id, amount, relative_rank。

作業ファイル: [q30.sql](../workspace/q30.sql)

## Q31 売上累積分布

customer_salesで売上が自分以下の顧客の割合（全顧客を分母、同額を含む）。出力: customer_id, amount, cumulative_dist。

作業ファイル: [q31.sql](../workspace/q31.sql)

## Q32 初回・最終注文ID

ordersの全行に顧客の最古・最新の注文IDを付加。時刻昇順・同時刻はorder_id昇順の先頭と末尾。出力: order_id, customer_id, first_id, last_id。

作業ファイル: [q32.sql](../workspace/q32.sql)

## Q33 2回目購入の金額

salesの全行に顧客の2回目購入額を付加。時刻昇順・同時刻はorder_id昇順。2回未満NULL。出力: customer_id, order_id, second_amount。

作業ファイル: [q33.sql](../workspace/q33.sql)

## Q34 直近の有効評価

ordersで顧客の各取引に、その取引以前の直近非NULL評価を付加。時刻昇順・同時刻はorder_id昇順。出力: customer_id, order_id, rating, latest_rating。

作業ファイル: [q34.sql](../workspace/q34.sql)

## Q35 地域中央値超え

customer_salesで地域内の売上中央値を超える顧客を抽出。出力: region, customer_id, amount, region_median。

作業ファイル: [q35.sql](../workspace/q35.sql)

