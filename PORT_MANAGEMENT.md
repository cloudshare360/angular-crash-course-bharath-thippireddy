# Port Management Guide

## Gitpod Port Commands

### List All Active Ports
```bash
gitpod environment port list
```
Shows all forwarded ports with their names, URLs, and protocols.

**Output Example:**
```
PORT  NAME           URL                                                                         PROTOCOL 
8000  preview        https://8000--019a08fe-4baf-71e5-8cd0-0f8049b4eea5.us-east-1-01.gitpod.dev  HTTP     
50432 VS Code Server https://50432--019a08fe-4baf-71e5-8cd0-0f8049b4eea5.us-east-1-01.gitpod.dev HTTP     
61000 ona-swe-agent  https://61000--019a08fe-4baf-71e5-8cd0-0f8049b4eea5.us-east-1-01.gitpod.dev HTTP     
```

### Open a Port
```bash
gitpod environment port open <PORT_NUMBER>
```
Makes a port publicly accessible.

**Example:**
```bash
gitpod environment port open 8080
```

### Close a Port
```bash
gitpod environment port close <PORT_NUMBER>
```
Stops forwarding a specific port.

**Example:**
```bash
gitpod environment port close 8080
```

---

## System-Level Port Commands

### Check Listening Ports
```bash
# Using ss (modern)
ss -tlnp | grep LISTEN

# Using netstat (legacy)
netstat -tlnp | grep LISTEN
```

### Find Process Using a Port
```bash
# Find what's running on port 8000
lsof -i :8000

# Or using ss
ss -tlnp | grep :8000
```

### Kill Process on a Port
```bash
# Find the PID
lsof -ti :8000

# Kill the process
kill $(lsof -ti :8000)

# Force kill if needed
kill -9 $(lsof -ti :8000)
```

---

## Starting Servers with Port Forwarding

### Python HTTP Server
```bash
python3 -m http.server 8000
```

### Node.js HTTP Server
```bash
npx http-server -p 8080
```

### PHP Built-in Server
```bash
php -S 0.0.0.0:8000
```

### Angular Development Server
```bash
ng serve --host 0.0.0.0 --port 4200
```

---

## Port URL Pattern

In Gitpod, forwarded ports follow this pattern:
```
https://<PORT>--<WORKSPACE-ID>.<REGION>.gitpod.dev
```

**Example:**
- Port 8000: `https://8000--019a08fe-4baf-71e5-8cd0-0f8049b4eea5.us-east-1-01.gitpod.dev`

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| `gitpod environment port list` | List all forwarded ports |
| `gitpod environment port open <port>` | Open/forward a port |
| `gitpod environment port close <port>` | Close a forwarded port |
| `ss -tlnp \| grep LISTEN` | Show all listening ports |
| `lsof -i :<port>` | Find process using a port |
| `kill $(lsof -ti :<port>)` | Kill process on a port |

---

## Troubleshooting

### Port Already in Use
```bash
# Find what's using the port
lsof -i :8000

# Kill the process
kill $(lsof -ti :8000)

# Try starting your server again
```

### Port Not Accessible
```bash
# Ensure port is opened
gitpod environment port open 8000

# Check if service is listening on 0.0.0.0 (not just 127.0.0.1)
ss -tlnp | grep :8000
```

### Server Not Binding to Public Interface
Some servers only bind to localhost by default. Use:
- `--host 0.0.0.0` for most servers
- `-b 0.0.0.0` for some Python servers
- Check server documentation for binding options
