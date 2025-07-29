#!/bin/bash
# Interactive test to check which-key functionality

echo "Interactive Which-Key Test"
echo "========================="
echo ""
echo "This will open Neovim. Once open:"
echo "1. Press <space> and wait 500ms"
echo "2. You should see the which-key menu with groups like:"
echo "   +buffer  +code  +find  +git  +toggle  +window"
echo "3. Press 'q' or <Esc> to close the menu"
echo "4. Type :q to exit Neovim"
echo ""
echo "Troubleshooting commands to try in Neovim:"
echo "  :WhichKey               - Show all mappings"
echo "  :WhichKey <space>       - Show leader mappings"
echo "  :verbose map <space>    - Show what's mapped to space"
echo "  :echo mapleader         - Check leader key value"
echo ""
echo "Press Enter to continue..."
read

# Change to project root
cd "$(dirname "$0")/.."

nvim -u config/.config/nvim/init.lua -c "echo 'Ready! Press <space> to test which-key menu'"