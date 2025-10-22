#!/bin/bash

# Port Monitoring Script
# Usage: ./watch-ports.sh [interval_seconds]

INTERVAL=${1:-2}

echo "==================================="
echo "   Port Monitoring Dashboard"
echo "==================================="
echo "Refreshing every ${INTERVAL} seconds"
echo "Press Ctrl+C to exit"
echo ""

while true; do
    clear
    echo "==================================="
    echo "   Port Monitoring Dashboard"
    echo "==================================="
    echo "Last updated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    
    echo "📡 GITPOD FORWARDED PORTS:"
    echo "-----------------------------------"
    gitpod environment port list
    echo ""
    
    echo "🔌 SYSTEM LISTENING PORTS:"
    echo "-----------------------------------"
    ss -tlnp 2>/dev/null | grep LISTEN | awk '{print $4}' | sort -u
    echo ""
    
    echo "Press Ctrl+C to exit"
    sleep $INTERVAL
done
