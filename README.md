# expose-dev-server

A Claude Code plugin that helps agents expose local dev/demo servers for public testing via dedicated subdomains.

## What it does

When you ask an agent to run or share a server, it will:

1. Start the server process in the background (if not already running)
2. Register it with `dev-register` to get a public subdomain
3. Reply with the live URL: `https://<name>.demo.nikmel.dev`
4. Clean up with `dev-unregister` when you're done

## Skills

### `exposing-dev-server` (model-invoked)

Triggers automatically when you say things like:
- "run the server and give me a link"
- "start the dev server"
- "I want to test this in the browser"
- "expose port 3000 as my-app"

## Commands

```bash
# Expose a local port under a public subdomain (optional ttl, default 4h)
dev-register <name> <port> [ttl]

# Remove the subdomain registration
dev-unregister <name>
```

The `<name>` becomes the subdomain: `https://<name>.demo.nikmel.dev`

## Installation

```bash
# Clone the repo
git clone git@github.com:ikaros-labs/expose-dev-server.git ~/projects/expose-dev-server

# Install the CLI scripts
ln -s ~/projects/expose-dev-server/bin/dev-register /usr/local/bin/dev-register
ln -s ~/projects/expose-dev-server/bin/dev-unregister /usr/local/bin/dev-unregister

# Install the Claude Code plugin
ln -s ~/projects/expose-dev-server \
  ~/.claude/plugins/marketplaces/claude-plugins-official/plugins/expose-dev-server
```

Then fill in the implementation in `bin/dev-register` and `bin/dev-unregister`, and restart Claude Code.
