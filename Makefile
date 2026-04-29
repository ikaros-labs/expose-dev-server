REPO_DIR := $(shell pwd)
BIN_DIR  := /usr/local/bin
PLUGIN_DIR := $(HOME)/.claude/plugins/marketplaces/claude-plugins-official/plugins

.PHONY: install uninstall

install:
	ln -sf $(REPO_DIR)/bin/dev-register   $(BIN_DIR)/dev-register
	ln -sf $(REPO_DIR)/bin/dev-unregister $(BIN_DIR)/dev-unregister
	ln -sf $(REPO_DIR)                    $(PLUGIN_DIR)/expose-dev-server
	@echo "Done. Restart Claude Code to activate the plugin."

uninstall:
	rm -f $(BIN_DIR)/dev-register $(BIN_DIR)/dev-unregister
	rm -f $(PLUGIN_DIR)/expose-dev-server
	@echo "Uninstalled."
