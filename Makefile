SKILL_DIR := $(HOME)/.claude/skills
BIN_DIR   ?= $(HOME)/.local/bin

.PHONY: install uninstall

install:
	mkdir -p $(SKILL_DIR) $(BIN_DIR)
	ln -sfn $(shell pwd)/skills/expose-dev-server $(SKILL_DIR)/expose-dev-server
	ln -sfn $(shell pwd)/bin/dev-register   $(BIN_DIR)/dev-register
	ln -sfn $(shell pwd)/bin/dev-unregister $(BIN_DIR)/dev-unregister
	@echo "Done. Restart Claude Code to activate the skill."
	@echo "Make sure $(BIN_DIR) is in your PATH."

uninstall:
	rm -f $(SKILL_DIR)/expose-dev-server
	rm -f $(BIN_DIR)/dev-register $(BIN_DIR)/dev-unregister
	@echo "Uninstalled."
