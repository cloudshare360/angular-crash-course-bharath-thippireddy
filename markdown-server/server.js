const express = require('express');
const fs = require('fs');
const path = require('path');
const marked = require('marked');
const sanitizeHtml = require('sanitize-html');

const app = express();
const PORT = process.env.PORT || 4000;

// Root directory to serve markdown from
const NOTES_DIR = path.resolve(__dirname, '..', 'Couser_Notes');

app.get('/', (req, res) => {
  // list markdown files under Couser_Notes
  function walk(dir) {
    const items = [];
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    for (const e of entries) {
      const full = path.join(dir, e.name);
      if (e.isDirectory()) {
        items.push(...walk(full));
      } else if (/\.md$/i.test(e.name)) {
        items.push(path.relative(NOTES_DIR, full));
      }
    }
    return items;
  }

  const files = walk(NOTES_DIR);
  const list = files
    .map(f => `<li><a href="/view/${encodeURIComponent(f)}">${f}</a></li>`)
    .join('');
  res.send(`<h1>Markdown Server — Couser_Notes</h1><ul>${list}</ul>`);
});

app.get('/view/:file(*)', (req, res) => {
  const rel = req.params.file;
  const filePath = path.join(NOTES_DIR, rel);
  if (!filePath.startsWith(NOTES_DIR)) return res.status(400).send('Invalid path');
  if (!fs.existsSync(filePath)) return res.status(404).send('File not found');
  const md = fs.readFileSync(filePath, 'utf8');
  const html = marked.parse(md);
  const safe = sanitizeHtml(html, { allowedTags: sanitizeHtml.defaults.allowedTags.concat([ 'img' ]) });
  res.send(`<html><head><meta charset="utf-8"><title>${rel}</title></head><body><a href="/">← Back</a><hr/>${safe}</body></html>`);
});

app.use('/static', express.static(NOTES_DIR));

app.listen(PORT, () => {
  console.log(`Markdown server listening on http://localhost:${PORT}/`);
});
