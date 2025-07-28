#!/bin/bash
# Test Neovim health check after fixes

echo "Running Neovim health check to verify fixes..."
echo "=============================================="

cd /home/zwelch/projects/BONSAIVIM/config/.config/nvim

# Run health check and filter for relevant sections
nvim --headless +'checkhealth lazy which-key' +'qa' 2>&1 | grep -E "(lazy:|which-key:|WARNING|ERROR|OK)" | head -100

echo -e "\n=============================================="
echo "Summary of fixes applied:"
echo "1. Updated which-key to use new configuration format"
echo "2. Disabled luarocks in lazy.nvim (not needed)"
echo "3. Updated all which-key mappings to new spec format"
echo ""
echo "Optional improvements:"
echo "- Could install nvim-web-devicons for better icon support"
echo "- The vim.validate deprecation warning is in treesitter plugin code (not user code)"