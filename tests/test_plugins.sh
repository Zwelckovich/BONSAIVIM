#!/bin/bash
# Test runner for BONSAI plugins

echo "Testing BONSAI Neovim plugins..."

# Change to project root
cd "$(dirname "$0")/.."

# Run the verification
/usr/bin/env nvim --headless -u config/.config/nvim/init.lua +'source config/.config/nvim/verify_plugins.lua' 2>&1 | tee tests/results/plugin_test_output.txt

# Check if results file was created
if [ -f "tests/results/plugin_test_results.txt" ]; then
    echo -e "\nTest results:"
    cat tests/results/plugin_test_results.txt
else
    echo "No results file created - tests may have failed to run"
fi