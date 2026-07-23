#!/bin/sh
# Installation script for PROJECT_NAME
# KISS style, compatible with Linux and BSD

set -eu

## CONFIG
NAME="project-name"
PREFIX="/usr/local"
BIN_DIR="${PREFIX}/bin"
ETC_DIR="/etc"
SYSTEMD_DIR="${ETC_DIR}/systemd/system"
RCONF_DIR="${ETC_DIR}/rc.d"
INIT_DIR="${ETC_DIR}/init.d"

## FUNCTIONS
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "ERROR: This script must be run as root" >&2
        exit 1
    fi
}

install_files() {
    echo "Installing ${NAME}..."

    # Create directories
    mkdir -p "${BIN_DIR}"

    # Install main binary
    install -m 755 src/main.sh "${BIN_DIR}/${NAME}"
    echo "Installed binary to ${BIN_DIR}/${NAME}"
}

install_init() {
    # Try systemd first
    if [ -d "${SYSTEMD_DIR}" ]; then
        echo "Installing systemd service..."
        install -m 644 "${NAME}.service" "${SYSTEMD_DIR}/"
        systemctl daemon-reload
        echo "Run 'systemctl enable --now ${NAME}' to start the daemon"
        return
    fi

    # Try BSD-style init
    if [ -d "${RCONF_DIR}" ] && [ -d "${INIT_DIR}" ]; then
        echo "Installing BSD-style init script..."
        install -m 755 "${NAME}.init" "${INIT_DIR}/"
        echo "Run '/etc/rc.d/${NAME} start' to start the daemon"
        return
    fi

    echo "No init system detected"
    echo "To start manually: ${BIN_DIR}/${NAME}"
}

## MAIN
check_root
install_files
install_init
echo "Installation complete"
