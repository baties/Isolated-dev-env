#!/bin/bash
echo "Opening terminal in isolated browser..."
docker exec isolated-browser bash -c 'export DISPLAY=:0 && xterm &'