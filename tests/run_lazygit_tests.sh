#!/bin/bash
# BONSAI LazyGit plugin test runner

echo "Running LazyGit plugin tests..."

# Run tests in headless Neovim
nvim --headless -u config/.config/nvim/init.lua -c "source tests/test_lazygit.lua" 2>&1

# Check exit code
if [ $? -eq 0 ]; then
	echo "✓ All LazyGit tests passed!"
	exit 0
else
	echo "✗ Some LazyGit tests failed!"
	exit 1
fi
