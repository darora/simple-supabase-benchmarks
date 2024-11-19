#! /usr/bin/env sh

set -euo pipefail

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
RUN_DESCRIPTION=${RUN_DESCRIPTION:-pgbench}
OUTPUT_DIR=${OUTPUT_DIR:-/mnt/benchmark_output}
FL_NAME="${OUTPUT_DIR}/${RUN_DESCRIPTION}/${HOSTNAME}_${TIMESTAMP}"

mkdir -p "$(dirname "$FL_NAME")"

pgbench --builtin simple-update --client $(expr $(psql $PGDATABASE -c 'show max_connections' -t -A) / 4) --jobs $(getconf _NPROCESSORS_ONLN) --progress 10 --protocol prepared --time 60 | tee -a "${FL_NAME}"
