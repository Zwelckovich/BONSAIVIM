#!/bin/bash
# BONSAI Neovim test runner

cd "$(dirname "$0")"
nvim --headless -u init.lua +'lua dofile("test_config.lua"); require("test_config").run()' 2>&1