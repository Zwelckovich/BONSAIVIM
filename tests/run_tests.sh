#!/bin/bash
# BONSAI Neovim test runner

cd "$(dirname "$0")/.."
nvim --headless -u config/.config/nvim/init.lua -c "lua dofile('tests/test_config.lua')" 2>&1