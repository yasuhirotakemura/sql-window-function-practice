# 応用編

共通ルールは [README](../README.md)、列定義は [データ定義](../reference/data_dictionary.md)。

## Q36 完了率を明細に付与

ordersの各行に顧客の全注文数、完了件数、完了率（0〜1）を付ける。出力: order_id, customer_id, total_count, completed_count, completed_rate。

作業ファイル: [q36.sql](../workspace/q36.sql)

## Q37 最新取引がキャンセルの顧客

ordersから顧客ごとに最新取引を1件決定し、それがcancelledの場合だけ出力。同時刻はorder_id昇順。出力: customer_id, order_id, status。

作業ファイル: [q37.sql](../workspace/q37.sql)

## Q38 同時刻を含む累積売上

salesで顧客ごとに、その注文時刻まで（同時刻の全取引を含む）の累積売上を付加。出力: customer_id, order_id, ordered_at, amount, cumulative_amount。

作業ファイル: [q38.sql](../workspace/q38.sql)

## Q39 連携重複グループの全明細

ordersでsource_refが2件以上出現するキーの全行を取得。出力: source_ref, order_id, customer_id, duplicate_count。

作業ファイル: [q39.sql](../workspace/q39.sql)

## Q40 前後を含む在庫の平滑化

inventoryで各商品・観測日に、前後各1観測行と当日を含む平均在庫を算出。端は存在する行のみ。出力: product_id, stock_date, smoothed_stock。

作業ファイル: [q40.sql](../workspace/q40.sql)

## Q41 過去3か月売上（当月除外）

product_monthlyで商品・月別に、当月を除く直前3か月の売上合計。1月はNULL、2〜3月は存在する月のみ。出力: product_id, month_start, amount, previous_3m。

作業ファイル: [q41.sql](../workspace/q41.sql)

## Q42 前年内最高月の更新

product_monthlyで商品別に、当月額がそれ以前の全月の最大額を厳密に超えた月だけ取得。1月は除外。出力: product_id, month_start, amount, previous_max。

作業ファイル: [q42.sql](../workspace/q42.sql)

## Q43 地域内のP90

customer_salesで顧客ごとに地域の売上90パーセンタイル（連続補間）と、その閾値との差を付ける。出力: region, customer_id, amount, p90, diff。

作業ファイル: [q43.sql](../workspace/q43.sql)

## Q44 給与平均との差の標準化

employeesで部署別に給与のzスコア（母標準偏差を使用）を算出。標準偏差0ならNULL。出力: department, employee_id, salary, z_score。

作業ファイル: [q44.sql](../workspace/q44.sql)

## Q45 前々回購入との比較

salesで顧客ごとに前々回購入額を取得し、差額を算出。時刻昇順・同時刻はorder_id昇順。存在しない場合NULL。出力: customer_id, order_id, amount, prev2_amount, diff。

作業ファイル: [q45.sql](../workspace/q45.sql)

## Q46 月別商品カテゴリ順位

salesとproductsを使い、実績のある商品・月の売上を集計。各月・カテゴリの上位2商品を固定件数で抽出（同額はproduct_id昇順）。出力: month_start, category, product_id, amount, rn。

作業ファイル: [q46.sql](../workspace/q46.sql)

## Q47 月間の売上目標達成率順位

sales_targetsの全従業員・月を対象に実績売上（未実績0）を付け、月ごとの達成率降順で同率同順位・欠番ありの順位を算出。目標0は達成率と順位をNULLにする（順位計算対象外）。出力: employee_id, month_start, target_amount, actual_amount, rate, rnk。

作業ファイル: [q47.sql](../workspace/q47.sql)

## Q48 顧客ごとの主要チャネル

salesで顧客・チャネル別売上を集計し、顧客ごとの最大売上チャネルを1件取得。同額はchannel辞書順。売上行のある顧客のみ。出力: customer_id, channel, amount。

作業ファイル: [q48.sql](../workspace/q48.sql)

## Q49 購入額の3回連続増加

salesの顧客別時系列で、前々回額 < 前回額 < 今回額となる取引を抽出。同時刻はorder_id昇順。出力: customer_id, order_id, prev2_amount, prev_amount, amount。

作業ファイル: [q49.sql](../workspace/q49.sql)

## Q50 在庫欠損日の検知

inventoryで商品別の直前観測日から2日以上離れている観測行を抽出。欠損日数も算出。出力: product_id, stock_date, previous_date, missing_days。

作業ファイル: [q50.sql](../workspace/q50.sql)

