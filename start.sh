#!/bin/bash

echo "Starting isolated development environments..."

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker is not running or permission denied."
    echo "Try: sudo systemctl start docker"
    echo "Or check if you're in docker group: groups \$USER"
    exit 1
fi

# Start containers
if docker-compose up -d; then
    echo ""
    echo "✅ Environments started successfully!"
    echo ""
    echo "Available environments:"
    echo "- Python: docker exec -it python-test-env bash"
    echo "- Node.js: docker exec -it node-test-env bash"  
    echo "- Multi: docker exec -it multi-test-env bash"
    echo ""
    echo "Web access:"
    echo "- Python apps: http://localhost:8000, :5000"
    echo "- Node.js apps: http://localhost:3000, :4200"
    echo "- Multi apps: http://localhost:3002 (Node), :8001 (Python)"
    echo ""
    echo "Check running containers:"
    docker ps
else
    echo "❌ Failed to start containers."
    echo "If you see permission errors, run: sudo systemctl restart docker"
fi