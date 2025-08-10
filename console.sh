#!/bin/bash
PROJECT_NAME=${1:-""}

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: ./console.sh [project-name] [environment]"
    echo "Environments: python, node, multi (default)"
    echo "Example: ./console.sh my-test-project multi"
    exit 1
fi

CONTAINER=${2:-"multi-test-env"}

echo "Connecting to $CONTAINER..."
echo "Project: $PROJECT_NAME"
echo "Commands available:"
echo "  cd projects/$PROJECT_NAME"
echo "  npm install && npm start"
echo "  pip install -r requirements.txt && python app.py"
echo ""

docker exec -it $CONTAINER bash -c "cd projects/$PROJECT_NAME 2>/dev/null || cd /workspace; bash"