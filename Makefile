# Development targets for testing the formula. See README.md for usage.

TAP = nirs/vmnet-helper
TAP_DIR = $(shell brew --repo $(TAP) 2>/dev/null)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
.PHONY: tap untap sync install uninstall test audit

tap:
	brew tap $(TAP) $(CURDIR)

untap:
	-brew uninstall vmnet-helper
	-brew untap $(TAP)

sync:
	cd $(TAP_DIR) && git fetch origin && git checkout $(BRANCH) && git reset --hard origin/$(BRANCH)

install: sync
	brew install --verbose vmnet-helper

uninstall:
	brew uninstall --verbose vmnet-helper

test: sync
	brew test --verbose vmnet-helper

audit: sync
	brew audit --strict vmnet-helper
