#!/usr/bin/env bash
# Start the markdown server in background, write pid to markdown-server.pid
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

PORT=${PORT:-4000}
LOG_FILE="markdown-server.log"
PID_FILE="markdown-server.pid"

if [ -f "$PID_FILE" ]; then
  PID=$(cat "$PID_FILE")
  if kill -0 "$PID" 2>/dev/null; then
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
echo "$PID" > "$PID_FILE"
echo "Started (PID=$PID). Logs: $ROOT_DIR/$LOG_FILE"
