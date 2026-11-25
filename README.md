# SQLウィンドウ関数 練習教材（DuckDB）

実務のデータ抽出・加工依頼を、自分でSQLに変換するための60問。関数名は原則として問題文に書かず、ヒント・解答・解説を分離しています。

## 開始方法
```bash
git clone https://github.com/yasuhirotakemura/sql-window-function-practice.git
cd sql-window-function-practice
duckdb practice.duckdb
```

DuckDB CLIで次を実行します。
```sql
.read setup.sql
.tables
SELECT * FROM orders LIMIT 10;
```

DuckDB 1.x を想定。CLIがなければ Python 3 と `python -m pip install -r requirements.txt` でも利用可能です。DuckDB CLIは https://duckdb.org/docs/stable/clients/cli/overview.html を参照。

## 問題集
- [基礎編 Q01–15](questions/01_basic.md)
- [標準編 Q16–35](questions/02_standard.md)
- [応用編 Q36–50](questions/03_advanced.md)
- [実務編 Q51–60](questions/04_practical.md)

最初に [データ定義](reference/data_dictionary.md) を確認。各問題のSQLは workspace/qXX.sql に記述し、CLIで `.read workspace/q01.sql` を実行します。詰まった場合は [ヒント](hints/hints.md)、答え合わせは answers/qXX.sql と [解説](answers/explanations.md) を参照してください。

## 答え合わせ
Python環境で `python scripts/check.py --generate` を実行すると、全60問の模範SQLを実行し expected_results/qXX.csv を生成します。模範解答を開かずに、`python scripts/check.py 1` で workspace/q01.sql と模範結果を比較できます。列名と行順は比較せず、列順・値・重複件数を比較します（数値は小数点以下8桁に丸めます）。出力順も問題に指定されている場合は目視確認してください。チェックは空のインメモリDBで行います。

## 共通ルール
- 金額は円。売上は sales ビュー（完了取引のみ、割引適用済み）。orders は全ステータス。
- 同率順位を残す指定と、件数を固定する指定を区別する。固定件数の場合はID昇順を最後の比較キーとする（問題に別指定があればそちらを優先）。
- 出力項目は記載順。日付・期間の境界は問題に従う。丸めの指定がなければ丸め不要。
- すべて架空データ。7テーブル・合計46,900件。2025年の取引を中心に、NULL、同時刻、同額、欠損日、連携キー重複を含む。
- 模範解答の実行検証は環境制約により未実施。上記スクリプトで検証できる。

[構文リファレンス](reference/window_functions.md) | [DuckDB公式 Window Functions](https://duckdb.org/docs/stable/sql/functions/window_functions.html)
