SKILL_DIR := $(HOME)/.claude/skills
BIN_DIR   ?= $(HOME)/.local/bin

.PHONY: install uninstall

install:
	mkdir -p $(SKILL_DIR) $(BIN_DIR)
	ln -sf $(shell pwd)/skills/exposing-dev-server $(SKILL_DIR)/exposing-dev-server
	ln -sf $(shell pwd)/bin/dev-register   $(BIN_DIR)/dev-register
	ln -sf $(shell pwd)/bin/dev-unregister $(BIN_DIR)/dev-unregister
	@echo "Done. Restart Claude Code to activate the skill."
	@echo "Make sure $(BIN_DIR) is in your PATH."

uninstall:
	rm -f $(SKILL_DIR)/exposing-dev-server
	rm -f $(BIN_DIR)/dev-register $(BIN_DIR)/dev-unregister
	@echo "Uninstalled."
