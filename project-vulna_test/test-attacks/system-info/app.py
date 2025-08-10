#!/usr/bin/env python3
import os
import subprocess
import platform

print("🔴 TESTING: System information gathering...")

# Check what system info is visible
info_commands = [
    ("whoami", "Current user"),
    ("id", "User ID and groups"), 
    ("ps aux", "Running processes"),
    ("mount", "Mounted filesystems"),
    ("df -h", "Disk usage"),
    ("netstat -tulpn", "Network connections"),
    ("cat /proc/cpuinfo", "CPU info"),
    ("cat /proc/meminfo", "Memory info"),
    ("env", "Environment variables"),
]

for cmd, desc in info_commands:
    try:
        result = subprocess.run(cmd.split(), capture_output=True, text=True, timeout=5)
        if result.returncode == 0:
            output = result.stdout[:200] + "..." if len(result.stdout) > 200 else result.stdout
            print(f"ℹ️  {desc}: {output.strip()}")
        else:
            print(f"✅ BLOCKED: {desc}")
    except Exception as e:
        print(f"✅ BLOCKED: {desc} - {str(e)}")

print("🔴 System info test complete\n")
