"""Run reference queries, export results, or compare learner SQL."""
import argparse
import csv
import os
from collections import Counter
from decimal import Decimal
from pathlib import Path
import duckdb

ROOT = Path(__file__).resolve().parents[1]
os.chdir(ROOT)

def normalize(v):
    if isinstance(v, (float, Decimal)):
        return round(float(v), 8)
    return v

def run(con, path):
    statements = con.extract_statements(path.read_text(encoding="utf-8"))
    if len(statements) != 1:
        raise ValueError(f"{path}: SELECTクエリを1文記述してください")
    cur = con.execute(statements[0].query)
    cols = [d[0] for d in cur.description]
    return cols, cur.fetchall()

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("question", type=int, nargs="?")
    parser.add_argument("--generate", action="store_true")
    args = parser.parse_args()
    if not args.generate and (args.question is None or not 1 <= args.question <= 60):
        parser.error("1〜60の問題番号または --generate を指定してください")
    con = duckdb.connect()
    con.execute(Path("setup.sql").read_text(encoding="utf-8"))
    counts = dict(customers=500, products=100, employees=100, orders=10000, access_logs=20000, inventory=15000, sales_targets=1200)
    for t, expected in counts.items():
        actual = con.execute(f"select count(*) from {t}").fetchone()[0]
        assert actual == expected, (t, actual, expected)
    def multiset(rows):
        return Counter(tuple(map(normalize, r)) for r in rows)
    if args.generate:
        Path("expected_results").mkdir(exist_ok=True)
        for n in range(1,61):
            name = f"q{n:02d}"
            cols, rows = run(con, Path("answers") / (name+".sql"))
            with (Path("expected_results") / (name+".csv")).open("w", encoding="utf-8", newline="") as f:
                writer = csv.writer(f)
                writer.writerow(cols)
                writer.writerows(rows)
            print(f"{name}: {len(rows)} rows")
        print("60/60 SQL実行完了")
    else:
        name = f"q{args.question:02d}"
        ec, er = run(con, Path("answers") / (name+".sql"))
        ac, ar = run(con, Path("workspace") / (name+".sql"))
        e, a = multiset(er), multiset(ar)
        if len(ec) == len(ac) and e == a:
            print(f"{name}: PASS ({len(ar)} rows)")
        else:
            print(f"{name}: FAIL, expected={len(er)} actual={len(ar)}, expected columns={len(ec)} actual columns={len(ac)}")
            print("不足行:", sum((e-a).values()), "余分行:", sum((a-e).values()))
            raise SystemExit(1)
    con.close()

if __name__ == "__main__":
    main()
