# expose-dev-server

A Claude Code plugin that helps agents expose local dev/demo servers for public testing via dedicated subdomains.

## What it does

When you ask an agent to run or share a server, it will:

1. Start the server process in the background (if not already running)
2. Register it with `dev-register` to get a public subdomain
3. Reply with the live URL: `https://<name>.<your-domain>`
4. Clean up with `dev-unregister` when you're done

## Skills

### `expose-dev-server` (model-invoked)

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

The `<name>` becomes the subdomain: `https://<name>.<your-domain>`

## Installation

```bash
git clone git@github.com:ikaros-labs/expose-dev-server.git ~/projects/expose-dev-server
cd ~/projects/expose-dev-server
make install DOMAIN=demo.codex.so
```

- Scripts are symlinked into `~/.local/bin/` — changes to the checkout are reflected immediately.
- SKILL.md is copied into `~/.claude/skills/` with the domain substituted — re-run `make install DOMAIN=...` after editing.
- Domain is stored in `~/.config/expose-dev-server/domain` for runtime use.

Restart Claude Code to activate the skill.

To uninstall: `make uninstall`
