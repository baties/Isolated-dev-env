#!/bin/bash
# clipboard-sync-host.sh

# Create shared directory
mkdir -p /tmp/clipboard-sync

echo "Starting clipboard synchronization..."
echo "Host -> Container: Press Ctrl+C to stop"

# Monitor host clipboard and send to container
while true; do
    current_clip=$(xclip -o -selection clipboard 2>/dev/null)
    if [ "$current_clip" != "$last_clip" ] && [ -n "$current_clip" ]; then
        echo "$current_clip" > /tmp/clipboard-sync/host-to-container
        last_clip="$current_clip"
    fi
    
    # Check if container has sent clipboard data
    if [ -f /tmp/clipboard-sync/container-to-host ]; then
        container_clip=$(cat /tmp/clipboard-sync/container-to-host 2>/dev/null)
        if [ -n "$container_clip" ] && [ "$container_clip" != "$last_container_clip" ]; then
            echo "$container_clip" | xclip -selection clipboard
            last_container_clip="$container_clip"
            # Clear the file after reading
            echo "" > /tmp/clipboard-sync/container-to-host
        fi
    fi
    
    sleep 0.3
done