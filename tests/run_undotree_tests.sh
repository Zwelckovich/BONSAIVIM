#!/bin/bash

# Test undotree functionality in BONSAI Neovim configuration

echo "=== Running Undotree Tests ==="
echo

# Set test config path
TEST_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# Check if Neovim is available
if ! command -v nvim &> /dev/null; then
    echo "ERROR: Neovim not found!"
    exit 1
fi

# Run tests
echo "Running undotree tests..."
nvim --headless -u "$TEST_CONFIG/init.lua" -c "lua require('lazy').load({ plugins = { 'undotree' } })" -c "luafile tests/test_undotree.lua" 2>&1

exit_code=$?

echo
if [ $exit_code -eq 0 ]; then
    echo "✅ All undotree tests passed!"
else
    echo "❌ Some tests failed. Exit code: $exit_code"
fi

exit $exit_code