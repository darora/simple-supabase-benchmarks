#! /usr/bin/env sh

set -euo pipefail

RETRY_COUNT=0
RETRY_MAX=10
RETRY_INTERVAL=3

while ! pg_isready -h "${HOSTNAME}" -d "postgres" -U "supabase_admin" 2>/dev/null; do
  RETRY_COUNT=$(($RETRY_COUNT + 1))
  if [ $RETRY_COUNT -ge $RETRY_MAX ]; then
    echo "PostgreSQL not ready after ${RETRY_MAX} attempts. Exiting."
    exit 1
  fi
  echo "Waiting for PostgreSQL to be ready... Attempt: ${RETRY_COUNT}"
  sleep "${RETRY_INTERVAL}"
done

pgbench --initialize --init-steps dtGvp --scale 200
