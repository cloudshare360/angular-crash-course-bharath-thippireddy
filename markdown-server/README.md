# Markdown Server

Simple Node/Express server to browse and render Markdown files under the `Couser_Notes` directory.

How to run:

1. From the repository root, install dependencies for the server:

```bash
cd markdown-server
npm install
```

2. Start the server:

```bash
npm start
```

3. Open http://localhost:4000/ in your browser and click any markdown file to view it rendered as HTML.

Security: This is a simple local utility. Don't expose it to the internet without adding proper access controls.

Start, stop and view

- Start (foreground):

```bash
cd markdown-server
npm start
```

- Start (background):

```bash
cd markdown-server
nohup npm start > markdown-server.log 2>&1 &
echo $! > markdown-server.pid
```

- Stop (when started in background):

```bash
kill $(cat markdown-server.pid) && rm markdown-server.pid
# or, if that fails, find the PID and kill it:
ps aux | grep "node server.js" | grep -v grep
```

- View files in browser:

Open http://localhost:4000/ and click any file listed. Example: http://localhost:4000/view/Sec01-Introduction%2Fch-01%2Freadme.md

Troubleshooting

- If port 4000 is in use, set the PORT env var before starting: `PORT=5000 npm start`.
- If you prefer not to commit `node_modules`, remove it and add `markdown-server/node_modules` to `.gitignore`.
