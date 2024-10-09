#! /usr/bin/env sh

set -euo pipefail

pgbench --builtin simple-update --client $(expr $(psql $PGDATABASE -c 'show max_connections' -t -A) / 4) --jobs $(getconf _NPROCESSORS_ONLN) --progress 10 --protocol prepared --time 180
