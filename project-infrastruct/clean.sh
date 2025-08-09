#!/bin/bash
echo "Cleaning up containers and images..."
docker-compose down --rmi all --volumes --remove-orphans