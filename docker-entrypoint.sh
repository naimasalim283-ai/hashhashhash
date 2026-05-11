#!/usr/bin/env sh
set -eu

if [ -n "${HASH256_PRIVATE_KEY:-}" ]; then
  printf '%s\n' "$HASH256_PRIVATE_KEY" > /app/accounts.txt
fi

if [ ! -s /app/accounts.txt ]; then
  echo "Missing HASH256_PRIVATE_KEY or mounted /app/accounts.txt" >&2
  exit 1
fi

MODE="${1:-mine}"
shift || true

exec node src/miner.js --mode="$MODE" "$@"
