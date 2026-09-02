#!/bin/bash
CONTAINER=${1:-"isolated-browser-simple"}
DISPLAY_NUM=":1"
if [ "$CONTAINER" = "isolated-browser-desktop" ]; then
    DISPLAY_NUM=":2"
fi

echo "Restarting Firefox in $CONTAINER..."
docker exec "$CONTAINER" pkill firefox 2>/dev/null
docker exec "$CONTAINER" bash -c "export DISPLAY=$DISPLAY_NUM && firefox --new-instance --no-remote &"
echo "Firefox restarted!"