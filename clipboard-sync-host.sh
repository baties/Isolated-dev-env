#!/bin/bash
# Simple two-way clipboard sync for host

mkdir -p /tmp/clipboard-sync
chmod 777 /tmp/clipboard-sync

echo "Clipboard sync started - Press Ctrl+C to stop"

last_host_clip=""
last_container_clip=""

# Clean up any existing files
> "/tmp/clipboard-sync/host-to-container"
> "/tmp/clipboard-sync/container-to-host"

while true; do
    # Host to container
    current_clip=$(xclip -o -selection clipboard 2>/dev/null)
    if [ -n "$current_clip" ] && [ "$current_clip" != "$last_host_clip" ]; then
        echo "$current_clip" > "/tmp/clipboard-sync/host-to-container"
        last_host_clip="$current_clip"
    fi
    
    # Container to host
    if [ -f "/tmp/clipboard-sync/container-to-host" ]; then
        container_clip=$(cat "/tmp/clipboard-sync/container-to-host" 2>/dev/null)
        if [ -n "$container_clip" ] && [ "$container_clip" != "$last_container_clip" ]; then
            echo "$container_clip" | xclip -selection clipboard
            last_container_clip="$container_clip"
            # Clear to avoid re-processing
            echo "" > "/tmp/clipboard-sync/container-to-host"
        fi
    fi
    
    sleep 0.3
done