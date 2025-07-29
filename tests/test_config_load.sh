#!/bin/bash
# Test if Neovim loads without errors

# Change to project root
cd "$(dirname "$0")/.."

echo "Testing Neovim configuration..."

# Test loading Neovim and running a simple command
nvim --headless -u config/.config/nvim/init.lua -c 'echo "Config loaded successfully"' -c 'qa' 2>&1

# Check exit code
if [ $? -eq 0 ]; then
    echo "✅ Configuration loads without errors"
else
    echo "❌ Configuration has errors"
fi

# Test specific plugins
echo -e "\nTesting plugin loading..."
nvim --headless -u config/.config/nvim/init.lua -c 'lua print("Which-key loaded:", pcall(require, "which-key"))' -c 'qa' 2>&1
nvim --headless -u config/.config/nvim/init.lua -c 'lua print("Telescope loaded:", pcall(require, "telescope"))' -c 'qa' 2>&1
nvim --headless -u config/.config/nvim/init.lua -c 'lua print("Flash loaded:", pcall(require, "flash"))' -c 'qa' 2>&1