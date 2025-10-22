#!/usr/bin/env bash
# Start the markdown server in background, write pid to markdown-server.pid
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

PORT=${PORT:-4000}
LOG_FILE="markdown-server.log"
PID_FILE="markdown-server.pid"
LOCK_FILE="markdown-server.lock"

# Ensure server.js exists
if [ ! -f server.js ]; then
  echo "server.js not found in $ROOT_DIR. Aborting." >&2
  exit 1
fi

# Use flock to avoid races when starting
exec 9>"$LOCK_FILE"
if ! flock -n 9; then
  echo "Another start is in progress. Exiting." >&2
  exit 1
fi

if [ -f "$PID_FILE" ]; then
  PID=$(cat "$PID_FILE" 2>/dev/null || true)
  if [ -n "$PID" ] && kill -0 "$PID" 2>/dev/null; then
    echo "Server already running (PID=$PID)." >&2
    exit 0
  else
    echo "Removing stale PID file." >&2
    rm -f "$PID_FILE"
  fi
fi

echo "Starting markdown server on port $PORT..."
PORT="$PORT" nohup node server.js > "$LOG_FILE" 2>&1 &
PID=$!
sleep 0.2
if kill -0 "$PID" 2>/dev/null; then
  echo "$PID" > "$PID_FILE"
  echo "Started (PID=$PID). Logs: $ROOT_DIR/$LOG_FILE"
else
  echo "Failed to start server. See $ROOT_DIR/$LOG_FILE" >&2
  exit 1
fi

# release lock
flock -u 9
exec 9>&-
