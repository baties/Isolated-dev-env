#!/bin/bash
CONTAINER=${1:-"isolated-browser-simple"}
DISPLAY_NUM=":1"
if [ "$CONTAINER" = "isolated-browser-desktop" ]; then
    DISPLAY_NUM=":2"
fi

echo "Opening terminal in $CONTAINER..."
docker exec "$CONTAINER" bash -c "export DISPLAY=$DISPLAY_NUM && xterm &"