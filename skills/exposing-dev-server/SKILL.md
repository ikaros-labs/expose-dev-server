---
name: exposing-dev-server
description: Exposes a local dev or demo server publicly for testing and sharing via a dedicated subdomain at <name>.demo.nikmel.dev. Use whenever the user asks to "run the server", "start the server", "start a dev server", "expose the app", "give me a link to test", "share the server", "I want to test this in the browser", wants a public URL for a local service, or explicitly says to expose a port. Registers the server using dev-register and unregisters with dev-unregister when done.
allowed-tools: [Bash]
---

## Exposing a Dev/Demo Server

Follow this workflow whenever the user wants to run or access a local service via a public URL.

## Workflow

### Step 1 — Start the server (skip if already running)

Run the server in the background and wait for it to be ready:

```bash
<start-command> &
sleep 3
curl -sf http://localhost:<port>/ > /dev/null && echo "up" || echo "not yet ready"
```

If the process isn't up after 3 seconds, wait a bit longer or check for errors before proceeding.

### Step 2 — Choose a name

The name becomes the subdomain, so make it meaningful at a glance. Use **`<project>-<feature>`** — a short project identifier plus what's being tested.

- Format: `<project>-<feature>`, kebab-case, lowercase letters/numbers/hyphens only
- Keep it under ~30 characters total so URLs stay readable
- Derive the project slug from the directory/repo name visible in context (shorten if needed)
- Derive the feature slug from the task description or what's being tested — make it up from context, do not run git commands

| ✅ Good                       | ❌ Avoid           |
|------------------------------|--------------------|
| `shop-redesign-checkout`     | `my-app`           |
| `api-fix-search-bug`         | `frontend`         |
| `dashboard-add-auth`         | `dev`              |
| `site-onboarding-v2`         | `test`             |
| `admin-payment-flow`         | `app-3000`         |

### Step 3 — Register the subdomain

```bash
dev-register <name> <port> [ttl]
```

- `ttl` defaults to `4h` if omitted — choose based on the expected session length (see TTL guide below)

### Step 4 — Report the URL

Reply with:

```
Your server is live at: https://<name>.demo.nikmel.dev
```

Include the TTL so the user knows when the tunnel expires.

### Step 5 — Cleanup when done

When the user is finished testing or asks to stop:

```bash
dev-unregister <name>
```

Also terminate the server process if you started it.

## TTL Guidelines

| Session type      | TTL      |
|-------------------|----------|
| Quick test        | `1h`     |
| Normal dev        | `4h` (default) |
| All-day work      | `8h`     |
| Overnight / long  | `24h`    |

## Server Already Running?

If the server is already up on a known port, skip Step 1 and go straight to `dev-register`.

## Example

User: "Start the Next.js dev server and give me a link to test."

```bash
# 1. Start
npm run dev &
sleep 3

# 2. Pick a name from context
# project = "shop" (from directory name), feature = "redesign-checkout" (from task)
# → name: "shop-redesign-checkout"

# 3. Register
dev-register shop-redesign-checkout 3000 4h
```

Reply: "Your app is live at: https://shop-redesign-checkout.demo.nikmel.dev (expires in 4h)"
