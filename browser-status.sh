#!/bin/bash
echo "Browser container processes:"
docker exec isolated-browser ps aux | grep -E "(firefox|xterm|fluxbox)"