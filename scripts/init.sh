#! /usr/bin/env sh

set -euo pipefail

pgbench --initialize --init-steps dtGvp --scale 200
