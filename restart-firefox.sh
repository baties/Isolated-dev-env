#!/bin/bash
echo "Restarting Firefox in isolated browser..."
docker exec isolated-browser pkill firefox 2>/dev/null
docker exec isolated-browser bash -c 'export DISPLAY=:0 && firefox --new-instance --no-remote &'
echo "Firefox restarted!"