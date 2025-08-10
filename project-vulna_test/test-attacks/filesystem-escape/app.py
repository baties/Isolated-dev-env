#!/usr/bin/env python3
import os
import subprocess

print("🔴 TESTING: File system escape attempts...")

# Try to access host system files
attack_paths = [
    "/etc/passwd",           # Host system users
    "/home",                 # Host home directories  
    "/root",                 # Host root directory
    "../../../../../../etc/passwd",  # Directory traversal
    "/proc/version",         # Host kernel info
    "/var/run/docker.sock",  # Docker socket (would allow container escape)
]

for path in attack_paths:
    try:
        if os.path.exists(path):
            print(f"⚠️  DANGER: Can access {path}")
            if path == "/etc/passwd":
                with open(path, 'r') as f:
                    print(f"   Content preview: {f.readline().strip()}")
        else:
            print(f"✅ SAFE: Cannot access {path}")
    except Exception as e:
        print(f"✅ BLOCKED: {path} - {str(e)}")

# Try to write to host system
try:
    with open("/tmp/host-write-test.txt", "w") as f:
        f.write("If you see this file on your HOST system, container escaped!")
    print("⚠️  WARNING: Successfully wrote to /tmp (check if this appears on host)")
except:
    print("✅ SAFE: Cannot write to /tmp")

print("🔴 File system test complete\n")
