.PHONY: install uninstall dev

# Register the marketplace and install the plugin via Claude Code CLI
install:
	claude plugin marketplace add ikaros-labs/expose-dev-server
	claude plugin install expose-dev-server@nikmel
	@echo ""
	@echo "Done. Run /reload-plugins inside Claude Code to activate."

# Remove the plugin and marketplace
uninstall:
	claude plugin uninstall expose-dev-server@nikmel
	claude plugin marketplace remove nikmel
	@echo "Uninstalled."

# Load directly from local checkout — useful while iterating on the skill
dev:
	claude --plugin-dir $(shell pwd)
