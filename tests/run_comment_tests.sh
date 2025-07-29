#!/bin/bash
# BONSAI Comment.nvim test runner

echo "=== Running Comment.nvim Plugin Tests ==="

# Create results directory if it doesn't exist
mkdir -p tests/results

# Run Comment.nvim tests
nvim --headless -u config/.config/nvim/init.lua -c "lua dofile('tests/test_comment.lua')"

# Check exit code
if [ $? -eq 0 ]; then
    echo -e "\n✓ All Comment.nvim tests passed!"
    exit 0
else
    echo -e "\n✗ Some Comment.nvim tests failed!"
    exit 1
fi