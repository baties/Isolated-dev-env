# Isolated Development Environment

Safe environment for testing suspicious code using Docker containers.

## Quick Start

1. **Setup:**
   ```bash
   chmod +x *.sh
   ./start.sh
   ```

2. Test a project:
    ```bash
    # Copy project to projects folder
    cp -r /path/to/suspicious-project ./projects/

    # Enter appropriate container
    docker exec -it multi-test-env bash
    cd projects/suspicious-project

    # Install and run
    npm install && npm start
    # OR
    pip install -r requirements.txt && python app.py
    ```

3. VS Code Integration:

    - Install "Dev Containers" extension
    - Open project folder in projects/
    - Command Palette → "Dev Containers: Reopen in Container"



## Available Environments

* python-env: Python 3.11 with common packages
* node-env: Node.js 18 with TypeScript support
* multi-env: Both Python and Node.js (recommended)

## Security Features

* Isolated network (containers can't access host network)
* Non-root user inside containers
* Limited capabilities
* Only shared folder and projects folder mounted
* All ports bound to localhost only

## Commands

* ```./start.sh``` - Start all environments
* ```./stop.sh``` - Stop all containers
* ```./clean.sh``` - Remove containers and images


## Usage Workflow:

1. **Initial Setup:**

```bash
mkdir isolated-dev-env
cd isolated-dev-env
# Copy all the files above
chmod +x *.sh
./start.sh
```

2. **Test a Project:**

```bash
# Copy suspicious project
cp -r /path/to/test-project ./projects/

# Enter multi-language container
docker exec -it multi-test-env bash

# Navigate and test
cd projects/test-project
npm install  # for Node.js projects
pip install -r requirements.txt  # for Python projects
```

3. **Access via Browser:**

* Node.js apps: ```http://localhost:3002```
* Python apps: ```http://localhost:8001```


   