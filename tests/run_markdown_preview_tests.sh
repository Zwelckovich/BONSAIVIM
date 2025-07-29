#!/bin/bash

echo "Testing markdown-preview.nvim..."

cd /home/zwelch/projects/BONSAIVIM

# Run the test in headless Neovim
NVIM_APPNAME=BONSAIVIM nvim --headless -c "source tests/test_markdown_preview.lua" 2>&1

# Check if the results file was created and contains SUCCESS
if [ -f "tests/results/markdown_preview_test_results.txt" ]; then
    RESULT=$(cat tests/results/markdown_preview_test_results.txt)
    if [ "$RESULT" = "SUCCESS" ]; then
        echo "✓ All markdown-preview tests passed!"
        exit 0
    else
        echo "✗ Some markdown-preview tests failed!"
        exit 1
    fi
else
    echo "✗ Test results file not found!"
    exit 1
fi