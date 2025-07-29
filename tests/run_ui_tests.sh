#!/bin/bash
# Test runner for UI plugins (lualine and undotree)

echo "Testing UI plugins (lualine and undotree)..."
echo "=========================================="

# Set up paths
NVIM_CONFIG="/home/zwelch/projects/BONSAIVIM/config/.config/nvim"
export XDG_CONFIG_HOME="/home/zwelch/projects/BONSAIVIM/config/.config"
export XDG_DATA_HOME="/home/zwelch/projects/BONSAIVIM/config/.local/share"

# Run simple loading test
echo "1. Testing basic plugin loading..."
nvim --headless \
  -u "$NVIM_CONFIG/init.lua" \
  -c "lua vim.wait(3000)" \
  -c "lua local ok_lualine = pcall(require, 'lualine'); print('  Lualine loaded:', ok_lualine)" \
  -c "lua print('  Undotree command:', vim.fn.exists(':UndotreeToggle') == 2 and 'exists' or 'missing')" \
  -c "qa" 2>&1

echo ""
echo "2. Testing configuration values..."
nvim --headless \
  -u "$NVIM_CONFIG/init.lua" \
  -c "lua vim.wait(3000)" \
  -c "lua print('  Undotree window layout:', vim.g.undotree_WindowLayout)" \
  -c "lua print('  Undotree split width:', vim.g.undotree_SplitWidth)" \
  -c "lua print('  Undotree auto-focus:', vim.g.undotree_SetFocusWhenToggle)" \
  -c "lua print('  Persistent undo enabled:', vim.o.undofile)" \
  -c "qa" 2>&1

echo ""
echo "3. Testing keymappings..."
nvim --headless \
  -u "$NVIM_CONFIG/init.lua" \
  -c "lua vim.wait(3000)" \
  -c "lua local map = vim.fn.mapcheck('<leader>u', 'n'); print('  <leader>u mapping:', map ~= '' and 'configured' or 'missing')" \
  -c "qa" 2>&1

echo ""
echo "4. Testing visual presence..."
nvim --headless \
  -u "$NVIM_CONFIG/init.lua" \
  -c "lua vim.wait(3000)" \
  -c "lua print('  Statusline configured:', vim.o.statusline ~= '' and 'yes' or 'no')" \
  -c "lua print('  Lualine sections:', vim.fn.exists('*lualine#get_config') == 1 and 'available' or 'checking...')" \
  -c "qa" 2>&1

echo ""
echo "=========================================="
echo "UI plugin tests completed"