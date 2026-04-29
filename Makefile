REPO_DIR     := $(shell pwd)
MARKETPLACE  := $(HOME)/.claude/plugins/marketplaces/local
PLUGIN_LINK  := $(MARKETPLACE)/plugins/expose-dev-server
REGISTRY     := $(HOME)/.claude/plugins/known_marketplaces.json

.PHONY: install uninstall

install:
	@# Register the local marketplace in Claude's registry (idempotent)
	@if ! grep -q '"local"' $(REGISTRY) 2>/dev/null; then \
		tmp=$$(mktemp); \
		jq '. + {"local": {"source": {"source": "local"}, "installLocation": "$(MARKETPLACE)"}}' \
			$(REGISTRY) > $$tmp && mv $$tmp $(REGISTRY); \
		echo "Registered local marketplace."; \
	fi
	@# Create marketplace structure if needed
	mkdir -p $(MARKETPLACE)/.claude-plugin $(MARKETPLACE)/plugins
	@# Write marketplace manifest
	cp $(REPO_DIR)/.claude-plugin/marketplace.json $(MARKETPLACE)/.claude-plugin/marketplace.json 2>/dev/null || \
		echo '{"name":"local","description":"Personal plugins","plugins":[]}' \
		> $(MARKETPLACE)/.claude-plugin/marketplace.json
	@# Symlink the plugin
	ln -sf $(REPO_DIR) $(PLUGIN_LINK)
	@echo "Done. Restart Claude Code to activate the plugin."
	@echo "Note: bin/ is auto-added to PATH by the plugin — no manual symlinking needed."

uninstall:
	rm -f $(PLUGIN_LINK)
	@echo "Uninstalled. Run 'make install' to reinstall."
