#!/bin/bash

# Test script for LuaSnip and nvim-cmp functionality

# Change to project root
cd "$(dirname "$0")/.."

echo "=== Testing LuaSnip and nvim-cmp ==="
echo

# Run the tests
nvim --headless \
  -u config/.config/nvim/init.lua \
  -c "lua require('lazy').load({ plugins = { 'nvim-cmp', 'LuaSnip' } })" \
  -c "lua dofile('tests/test_snippets.lua')" \
  2>&1

# Capture exit code
exit_code=$?

if [ $exit_code -eq 0 ]; then
  echo
  echo "✅ All snippet tests passed!"
else
  echo
  echo "❌ Some snippet tests failed"
fi

exit $exit_code