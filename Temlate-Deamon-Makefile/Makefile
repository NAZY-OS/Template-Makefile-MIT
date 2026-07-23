# Makefile for PROJECT_NAME
# KISS style, compatible with Linux and BSD

PREFIX ?= /usr/local
BIN_DIR ?= $(PREFIX)/bin

NAME = project-name

all: install

install:
	@echo "Running installation script..."
	@chmod +x install.sh
	@./install.sh

uninstall:
	@echo "Uninstalling ${NAME}..."
	@rm -f $(BIN_DIR)/$(NAME)
	@echo "Uninstall complete"

clean:
	@echo "Cleaning..."

.PHONY: all install uninstall clean
