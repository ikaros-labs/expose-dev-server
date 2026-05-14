SKILL_DIR := $(HOME)/.claude/skills
BIN_DIR   ?= $(HOME)/.local/bin
CONF_DIR  := $(HOME)/.config/expose-dev-server
DOMAIN    ?= demo.nikmel.dev

.PHONY: install uninstall

install:
	mkdir -p $(SKILL_DIR)/expose-dev-server $(BIN_DIR) $(CONF_DIR)
	ln -sfn $(shell pwd)/bin/dev-register   $(BIN_DIR)/dev-register
	ln -sfn $(shell pwd)/bin/dev-unregister $(BIN_DIR)/dev-unregister
	sed 's/_DOMAIN_/$(DOMAIN)/g' skills/expose-dev-server/SKILL.md \
		> $(SKILL_DIR)/expose-dev-server/SKILL.md
	echo '$(DOMAIN)' > $(CONF_DIR)/domain
	@echo ""
	@echo "Installed with domain: $(DOMAIN)"
	@echo "  skill   → $(SKILL_DIR)/expose-dev-server/SKILL.md"
	@echo "  scripts → $(BIN_DIR)/dev-{register,unregister}"
	@echo "  config  → $(CONF_DIR)/domain"
	@echo ""
	@echo "Restart Claude Code to activate the skill."
	@echo "Make sure $(BIN_DIR) is in your PATH."

uninstall:
	rm -rf $(SKILL_DIR)/expose-dev-server
	rm -f $(BIN_DIR)/dev-register $(BIN_DIR)/dev-unregister
	rm -rf $(CONF_DIR)
	@echo "Uninstalled."
