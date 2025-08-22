#!/bin/bash
# Simple two-way clipboard sync

echo "Clipboard sync started"

last_host_clip=""
last_container_clip=""

while true; do
    # Host to container
    if [ -f "/tmp/clipboard-sync/host-to-container" ]; then
        new_clip=$(cat "/tmp/clipboard-sync/host-to-container" 2>/dev/null)
        if [ -n "$new_clip" ] && [ "$new_clip" != "$last_host_clip" ]; then
            echo "$new_clip" | xclip -selection clipboard
            last_host_clip="$new_clip"
            # Clear to avoid re-processing
            echo "" > "/tmp/clipboard-sync/host-to-container"
        fi
    fi
    
    # Container to host
    current_clip=$(xclip -o -selection clipboard 2>/dev/null)
    if [ -n "$current_clip" ] && [ "$current_clip" != "$last_container_clip" ]; then
        echo "$current_clip" > "/tmp/clipboard-sync/container-to-host"
        last_container_clip="$current_clip"
    fi
    
    sleep 0.3
done