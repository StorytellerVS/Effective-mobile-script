#!/bin/bash

PROCESS_NAME="test"
LOG_FILE="/var/log/monitoring.log"
MONITOR_URL="https://test.com/monitoring/test/api"

PID=$(pgrep -f "$PROCESS_NAME")

if [ -n "$PID" ]; then
    LAST_PID_FILE="/tmp/last_${PROCESS_NAME}_pid"
    if [ -f "$LAST_PID_FILE" ]; then
        LAST_PID=$(cat "$LAST_PID_FILE")
        if [ "$LAST_PID" != "$PID" ]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Процесс $PROCESS_NAME был перезапущен (PID: $PID)" >> "$LOG_FILE"
        fi
    fi
    echo "$PID" > "$LAST_PID_FILE"

    curl -s --connect-timeout 5 "$MONITOR_URL" > /dev/null
    if [ $? -ne 0 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Сервер мониторинга недоступен" >> "$LOG_FILE"
    fi
fi
