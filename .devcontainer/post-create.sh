#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

duckdb --version
python -c 'import duckdb; print("Python DuckDB:", duckdb.__version__)'

if [[ ! -f practice.duckdb ]]; then
    # Build a temporary DB first so a failed initialization can be retried.
    tmp_dir="$(mktemp -d)"
    trap 'rm -rf "$tmp_dir"' EXIT
    duckdb -bail "$tmp_dir/practice.duckdb" -c ".read setup.sql"
    mv "$tmp_dir/practice.duckdb" practice.duckdb
    echo "Sample database initialized."
else
    echo "Existing practice.duckdb preserved."
fi
