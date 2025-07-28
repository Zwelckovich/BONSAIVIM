#!/bin/bash
# Sync plugins for BONSAI Neovim configuration

cd "$(dirname "$0")"
nvim --headless -c 'Lazy sync' -c 'qa' 2>&1
echo "Plugin sync complete"