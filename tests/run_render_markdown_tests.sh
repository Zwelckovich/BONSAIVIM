#!/bin/bash
# Test runner for render-markdown.nvim plugin tests

set -e

echo "=== Running render-markdown.nvim Tests ==="
echo

# Change to config directory for proper plugin loading
cd config/.config/nvim

# Run basic functionality test
echo "Running basic render-markdown test..."
nvim --headless -u init.lua -c "source ../../../tests/test_render_markdown.lua" 2>&1

echo
echo "Running comprehensive render-markdown test..."
nvim --headless -u init.lua -c "source ../../../tests/test_render_markdown_comprehensive.lua" 2>&1

# Check if results file was created
if [ -f "../../../tests/results/render_markdown_test_results.txt" ]; then
    echo
    echo "=== Test Results ==="
    cat ../../../tests/results/render_markdown_test_results.txt
fi

echo
echo "All render-markdown tests completed!"