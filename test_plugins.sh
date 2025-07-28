#!/bin/bash
# Test runner for BONSAI plugins

echo "Testing BONSAI Neovim plugins..."

# Use explicit path to avoid shell issues
cd /home/zwelch/projects/BONSAIVIM/config/.config/nvim

# Run the verification
/usr/bin/env nvim --headless -u init.lua +'source verify_plugins.lua' 2>&1 | tee plugin_test_output.txt

# Check if results file was created
if [ -f "plugin_test_results.txt" ]; then
    echo -e "\nTest results:"
    cat plugin_test_results.txt
else
    echo "No results file created - tests may have failed to run"
fi