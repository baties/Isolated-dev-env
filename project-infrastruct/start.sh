#!/bin/bash
echo "Starting isolated development environments..."
docker-compose up -d

echo "Environments started:"
echo "- Python: docker exec -it python-test-env bash"
echo "- Node.js: docker exec -it node-test-env bash"  
echo "- Multi: docker exec -it multi-test-env bash"
echo ""
echo "Web access:"
echo "- Python apps: http://localhost:8000, :5000"
echo "- Node.js apps: http://localhost:3000, :4200"
echo "- Multi apps: http://localhost:3002 (Node), :8001 (Python)"