#!/usr/bin/env python3
import socket
import subprocess
import requests

print("🔴 TESTING: Network attack attempts...")

# Try to scan local network
def scan_port(host, port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(1)
        result = sock.connect_ex((host, port))
        sock.close()
        return result == 0
    except:
        return False

# Try to access host services
host_targets = [
    ("host.docker.internal", 22),    # SSH
    ("172.17.0.1", 22),             # Docker host SSH
    ("127.0.0.1", 22),              # Local SSH
    ("192.168.1.1", 22),            # Router
    ("10.0.0.1", 22),               # Another common gateway
]

for host, port in host_targets:
    if scan_port(host, port):
        print(f"⚠️  DANGER: Can reach {host}:{port}")
    else:
        print(f"✅ SAFE: Cannot reach {host}:{port}")

# Try to access host metadata (cloud environments)
metadata_urls = [
    "http://169.254.169.254/",          # AWS/Azure metadata
    "http://metadata.google.internal/", # Google Cloud metadata
]

for url in metadata_urls:
    try:
        response = requests.get(url, timeout=2)
        print(f"⚠️  DANGER: Can access {url}")
    except:
        print(f"✅ SAFE: Cannot access {url}")

print("🔴 Network test complete\n")
