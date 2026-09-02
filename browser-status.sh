#!/bin/bash
echo "isolated-browser-simple processes:"
docker exec isolated-browser-simple ps aux | grep -E "(firefox|xterm|fluxbox)"

echo ""
echo "isolated-browser-desktop processes:"
docker exec isolated-browser-desktop ps aux | grep -E "(firefox|xterm|xfce4|x11vnc)"