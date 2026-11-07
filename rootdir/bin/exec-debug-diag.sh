#! /vendor/bin/sh

log -p i -t "exec-debug-diag.sh" "start"

LOGS_DIR="/sdcard/MIUI/debug_log/common/diag_debug"
LOG_FILE="$LOGS_DIR/diag_debug_info"
MAX_SIZE_KB=1024

if [ ! -d "$LOGS_DIR" ]; then
    mkdir -p "$LOGS_DIR"
    chmod 770 "$LOGS_DIR"
    log -p i -t "exec-debug-diag.sh" "Created directory: $LOGS_DIR"
fi


if [ -f "$LOG_FILE" ]; then
    file_bytes=$(ls -l "$LOG_FILE" | cut -d' ' -f5)
    file_size_kb=$((file_bytes / 1024))

    if [ "$file_size_kb" -gt "$MAX_SIZE_KB" ]; then
        : > "$LOG_FILE"
        log -p i -t "exec-debug-diag.sh" "Cleared oversized log file (${file_size_kb}KB)"
    fi
fi

{
    echo "===== Collection started: $(date +'%Y-%m-%d %H:%M:%S %Z') ====="
    /vendor/bin/debug-diag -m 0
    echo -e "\n--------------------------------------------"
    /vendor/bin/debug-diag -s
    echo -e "\n===== Collection ended: $(date +'%Y-%m-%d %H:%M:%S %Z') ====="
    echo -e "\n\n\n"
} >> "$LOG_FILE" 2>&1

log -p i -t "exec-debug-diag.sh" "end"