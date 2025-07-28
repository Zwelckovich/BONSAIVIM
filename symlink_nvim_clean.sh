#!/bin/bash
# Clean symlink script - removes existing files and creates fresh symlinks

cd "$(dirname "$0")"

echo "🌱 BONSAI Neovim Configuration - Clean Install"
echo

# Clean existing Neovim files
echo "🧹 Cleaning existing Neovim files..."
rm -rf "$HOME/.cache/nvim"
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.local/state/nvim"
rm -rf "$HOME/.config/nvim"
echo "✓ Cleaned existing files"

# Create symlinks
echo "🔗 Creating symlinks..."
if stow -v -t "$HOME" config; then
    echo "✅ Successfully linked BONSAI Neovim configuration!"
    echo
    echo "You can now run Neovim with your BONSAI configuration:"
    echo "  nvim"
else
    echo "❌ Failed to create symlinks"
    exit 1
fi