#!/usr/bin/env bash
# Stop the markdown server started by start-server.sh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

PID_FILE="markdown-server.pid"

if [ ! -f "$PID_FILE" ]; then
  echo "PID file not found; server may not be running." >&2
  exit 0
fi

PID=$(cat "$PID_FILE")
if kill -0 "$PID" 2>/dev/null; then
  echo "Stopping server (PID=$PID)..."
  kill "$PID"
  sleep 1
  if kill -0 "$PID" 2>/dev/null; then
    echo "PID still running; sending SIGKILL..."
    kill -9 "$PID" || true
  fi
else
  echo "Process $PID not running; removing PID file." >&2
fi

rm -f "$PID_FILE"
echo "Stopped."
