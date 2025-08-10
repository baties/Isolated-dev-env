const express = require('express');
const { exec } = require('child_process');
const fs = require('fs');
const app = express();

console.log('🔴 TESTING: Node.js malicious server attacks...');

app.get('/', (req, res) => {
    res.send(`
        <h1>🔴 Node.js Malicious Test Server</h1>
        <a href="/file-access">Test file system access</a><br>
        <a href="/execute/whoami">Test command execution</a><br>
        <a href="/env-vars">Show environment variables</a>
    `);
});

app.get('/file-access', (req, res) => {
    const dangerousFiles = [
        '/etc/passwd',
        '/home',
        '../../../../../../etc/passwd',
        '/proc/version'
    ];
    
    let results = '🔴 File access test results:\n';
    
    dangerousFiles.forEach(file => {
        try {
            if (fs.existsSync(file)) {
                const content = fs.readFileSync(file, 'utf8').substring(0, 200);
                results += `⚠️ DANGER: Can read ${file}: ${content}\n`;
            } else {
                results += `✅ SAFE: Cannot access ${file}\n`;
            }
        } catch (error) {
            results += `✅ BLOCKED: ${file} - ${error.message}\n`;
        }
    });
    
    res.send(`<pre>${results}</pre>`);
});

app.get('/execute/:cmd', (req, res) => {
    const cmd = req.params.cmd;
    exec(cmd, (error, stdout, stderr) => {
        if (error) {
            res.send(`<pre>✅ BLOCKED: ${error.message}</pre>`);
        } else {
            res.send(`<pre>🔴 Command executed: ${stdout}\n${stderr}</pre>`);
        }
    });
});

app.get('/env-vars', (req, res) => {
    res.send(`<pre>🔴 Environment variables:\n${JSON.stringify(process.env, null, 2)}</pre>`);
});

app.listen(3000, '0.0.0.0', () => {
    console.log('Malicious Node.js server running on port 3000');
    console.log('Access via: http://localhost:3002');  // Remember port mapping
});
