#!/bin/bash
echo "Stopping container..."
docker stop multi-test-env
docker rm multi-test-env
echo "Container stopped and removed."