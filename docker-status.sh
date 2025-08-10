#!/bin/bash
echo "Container status:"
docker ps --filter name=multi-test-env

echo -e "\nContainer logs (last 20 lines):"
docker logs --tail 20 multi-test-env 2>/dev/null || echo "Container not running"