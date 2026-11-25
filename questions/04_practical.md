# 実務編

共通ルールは [README](../README.md)、列定義は [データ定義](../reference/data_dictionary.md)。

## Q51 Pareto分析：80%到達まで

customer_salesを売上降順、customer_id昇順に並べ、全売上の累積80%に初めて達する行まで取得（到達行を含む）。総額0なら0行。出力: customer_id, amount, cumulative_amount, cumulative_share。

作業ファイル: [q51.sql](../workspace/q51.sql)

## Q52 ABC分析：商品分類

product_salesを全商品売上降順、product_id昇順で並べ、直前行までの累積構成比が70%未満ならA、90%未満ならB、それ以外C。総額0ならC。出力: product_id, amount, abc_class。

作業ファイル: [q52.sql](../workspace/q52.sql)

## Q53 アクセスのセッション採番

access_logsを顧客別・時刻昇順、同時刻はlog_id昇順に並べる。初回または直前との間隔が30分超の場合に新セッション開始。顧客内で1始まりの番号を付与。出力: customer_id, log_id, event_at, session_no。

作業ファイル: [q53.sql](../workspace/q53.sql)

## Q54 購入セッションの集計

Q53と同じセッション定義で、purchase操作を含むセッションのみ集計。出力: customer_id, session_no, started_at, ended_at, event_count, purchase_count。

作業ファイル: [q54.sql](../workspace/q54.sql)

## Q55 最長連続欠品

inventoryでstock_qty=0が暦日で連続する最長期間を商品ごとに1件抽出。欠損日は連続を切る。同日数なら開始日が早い方。欠品なしは除外。出力: product_id, start_date, end_date, days。

作業ファイル: [q55.sql](../workspace/q55.sql)

## Q56 連続売上減少の最長期間

product_monthlyで前月より売上が厳密に減少した月が連続する最長期間を商品ごとに1件出す（減少した月のみ数える、1月は対象外、同期間長なら早い開始月、減少なしは除外）。出力: product_id, start_month, end_month, months。

作業ファイル: [q56.sql](../workspace/q56.sql)

## Q57 30日以内のリピート購入率

salesで初回購入のある顧客を初回購入月別に集計し、2回目購入が初回から30日以内（暦日差0〜30）の顧客数と割合を求める。観測期間末の打ち切りを避けるため初回購入日が2025-12-01以前の顧客のみ対象。出力: cohort_month, customers_count, repeat_count, repeat_rate。

作業ファイル: [q57.sql](../workspace/q57.sql)

## Q58 地域別デシル集計

customer_salesの顧客を地域ごとに売上降順、customer_id昇順で10分割し、各地域・デシルの人数、合計額、地域売上に対する累積構成比（0〜1）を算出。出力: region, decile, customer_count, amount, cumulative_share。

作業ファイル: [q58.sql](../workspace/q58.sql)

## Q59 カテゴリ別売上順位の変動

product_monthlyとproductsで、全商品・月（ゼロ売上を含む）をカテゴリ内・月別売上降順で順位付け（同率同順位・欠番あり）。前月から順位が改善した商品・月のみ抽出。出力: month_start, category, product_id, amount, current_rank, previous_rank, improvement。

作業ファイル: [q59.sql](../workspace/q59.sql)

## Q60 連携データの最新化と売上再集計

ordersでsource_refごとに後着ID最大の行を残し、その後completedのみを売上として、顧客別の全期間合計を算出。全customersを含め、実績なし0。各地域で上位5顧客（同額はcustomer_id昇順）を取得。出力: region, customer_id, amount, rn。

作業ファイル: [q60.sql](../workspace/q60.sql)

