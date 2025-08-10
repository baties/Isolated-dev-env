#!/bin/bash

echo "Building and starting containers directly with Docker..."

# Create network
docker network create --driver bridge --subnet=172.20.0.0/16 isolated-network 2>/dev/null || echo "Network exists"

# Build multi-language image
docker build -f dockerfiles/Dockerfile.multi -t multi-dev-env .

# Start container
docker run -d \
    --name multi-test-env \
    --network isolated-network \
    --restart unless-stopped \
    -p 127.0.0.1:3002:3000 \
    -p 127.0.0.1:8001:8000 \
    -p 127.0.0.1:5001:5000 \
    -p 127.0.0.1:4201:4200 \
    -v "$(pwd)/projects:/workspace/projects" \
    -v "$(pwd)/shared:/workspace/shared" \
    -w /workspace \
    --security-opt no-new-privileges:true \
    --cap-drop ALL \
    --cap-add SETUID \
    --cap-add SETGID \
    -it \
    multi-dev-env \
    tail -f /dev/null

echo "✅ Container started successfully!"
echo ""
echo "Connect to container:"
echo "docker exec -it multi-test-env bash"
echo ""
echo "Web access:"
echo "- Node.js: http://localhost:3002"
echo "- Python: http://localhost:8001"
echo ""
echo "Status:"
docker ps --filter name=multi-test-env