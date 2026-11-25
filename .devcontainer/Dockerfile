FROM mcr.microsoft.com/devcontainers/python:1-3.12-bookworm

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install the official CLI release for the container architecture.
ARG DUCKDB_VERSION=1.4.3
RUN set -eux; \
    case "$(dpkg --print-architecture)" in \
      amd64) arch=amd64; checksum=7a9e36141a71a353f54dfbeed607a5218c3425ce2d417610da08443259a12f7c ;; \
      arm64) arch=arm64; checksum=6893c384ecd182bce637e18a715f750e8c79b8650504f5d61865c702ee523d9a ;; \
      *) echo "Unsupported architecture" >&2; exit 1 ;; \
    esac; \
    curl --fail --location --retry 3 "https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-${arch}.zip" -o /tmp/duckdb.zip; \
    echo "${checksum}  /tmp/duckdb.zip" | sha256sum -c -; \
    unzip -q /tmp/duckdb.zip -d /tmp/duckdb-cli; \
    install -m 0755 /tmp/duckdb-cli/duckdb /usr/local/bin/duckdb; \
    rm -rf /tmp/duckdb.zip /tmp/duckdb-cli; \
    duckdb --version

COPY requirements.txt /tmp/sql-window-requirements.txt
RUN python -m pip install --no-cache-dir -r /tmp/sql-window-requirements.txt \
    && python -c "import duckdb; print(duckdb.__version__)" \
    && rm /tmp/sql-window-requirements.txt

USER vscode
