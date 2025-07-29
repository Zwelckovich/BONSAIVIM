#!/bin/bash

echo "Testing nvim-spectre plugin..."

# Change to config directory
cd "$(dirname "$0")/../config/.config/nvim" || exit 1

# Run the test
nvim --headless -u NONE -c "luafile ../../../tests/test_spectre.lua" 2>&1

# Check exit code
if [ $? -eq 0 ]; then
    echo "✅ nvim-spectre tests passed!"
    exit 0
else
    echo "❌ nvim-spectre tests failed!"
    exit 1
fi