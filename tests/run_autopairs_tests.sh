#!/bin/bash

echo "Running nvim-autopairs tests..."

# Create results directory if it doesn't exist
mkdir -p tests/results

# Run the autopairs test
nvim --headless -u config/.config/nvim/init.lua -c "luafile tests/test_autopairs.lua" 2>&1

# Check if the test passed
if [ -f "tests/results/autopairs_test_results.txt" ]; then
    result=$(cat tests/results/autopairs_test_results.txt)
    if [ "$result" = "SUCCESS" ]; then
        echo "✓ All nvim-autopairs tests passed!"
        exit 0
    else
        echo "✗ Some nvim-autopairs tests failed!"
        exit 1
    fi
else
    echo "✗ Test results file not found!"
    exit 1
fi