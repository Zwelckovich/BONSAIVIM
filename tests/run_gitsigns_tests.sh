#!/bin/bash

# Test script for Gitsigns functionality

# Change to project root
cd "$(dirname "$0")/.."

echo "=== Testing Gitsigns ==="
echo

# Run the tests
nvim --headless \
  -u config/.config/nvim/init.lua \
  -c "lua require('lazy').load({ plugins = { 'gitsigns.nvim' } })" \
  -c "lua dofile('tests/test_gitsigns.lua')" \
  2>&1

# Capture exit code
exit_code=$?

if [ $exit_code -eq 0 ]; then
  echo
  echo "✅ All gitsigns tests passed!"
else
  echo
  echo "❌ Some gitsigns tests failed"
fi

exit $exit_code