# ウィンドウ関数・構文

## 基本構造
```sql
SELECT order_id, customer_id,
       ROW_NUMBER() OVER (
           PARTITION BY customer_id
           ORDER BY ordered_at DESC, order_id ASC
       ) AS rn
FROM orders
QUALIFY rn = 1;
```
OVER は評価対象の範囲、PARTITION BY はグループ境界、ORDER BY はグループ内順序。PARTITION BY省略時は全行。SELECT末尾のORDER BYは結果表示順で別物。QUALIFYはウィンドウ計算後に絞り込む句。WHEREは計算前、HAVINGは集約後。GROUP BYは粒度を変えるがウィンドウ関数は通常変えない。

| 構文 | 用途 |
|---|---|
| ROW_NUMBER | 必ず異なる連番。タイブレーク必須 |
| RANK | 同率同順位、次順位に欠番（1,1,3） |
| DENSE_RANK | 同率同順位、欠番なし（1,1,2） |
| LAG / LEAD | 順序上の前後の値。オフセットと既定値を指定可能 |
| SUM / AVG / COUNT / MIN / MAX OVER | 明細を保持した集計、累積、移動集計 |
| FIRST_VALUE / LAST_VALUE / NTH_VALUE | フレーム内の先頭・末尾・n番目 |
| NTILE(n) | 行数がほぼ均等なn分割。同率を分けることがある |
| PERCENT_RANK | (rank-1)/(行数-1)、1行なら0 |
| CUME_DIST | 現在行以下（順序に従う）の累積割合 |
| MEDIAN / QUANTILE_CONT OVER | 中央値、連続パーセンタイル |
| WINDOW | 同一のウィンドウ定義を再利用 |
| FILTER | 集約関数で対象行を指定 |
| IGNORE NULLS | 対応する値関数でNULLを飛ばす |
| QUALIFY | ウィンドウ計算結果を抽出 |

## フレーム
- ROWS BETWEEN 6 PRECEDING AND CURRENT ROW: 現在行を含む直近7行。
- RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW: 現在日を含む直近7暦日（DATE/TIMESTAMP順）。
- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW: 累積。
- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING: パーティション全体。
- ORDER BY付きでフレーム省略時は通常RANGE UNBOUNDED PRECEDING〜CURRENT ROW（同じ順序値の行も含む）。LAST_VALUEに注意。
- COUNT(*)は全行、COUNT(column)は非NULL行。除算のゼロ対策はNULLIF(denominator,0)。

## 設計の手順
1. 出力粒度を決める。
2. 比較・集計するグループを決める。
3. グループ内順序と同率処理を決める。
4. 評価範囲（全体、累積、直近n行・n日）を決める。
5. 計算前に絞るのか、計算後に絞るのかを決める。
