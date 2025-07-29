#!/bin/bash
# Run undotree tests with proper environment

export XDG_CONFIG_HOME="/home/zwelch/projects/BONSAIVIM/config/.config"
export XDG_DATA_HOME="/home/zwelch/projects/BONSAIVIM/config/.local/share"

nvim --headless -u config/.config/nvim/init.lua \
  -c "lua vim.wait(3000)" \
  -c "lua local lazy = require('lazy'); lazy.load({plugins = {'undotree'}})" \
  -c "lua vim.wait(1000)" \
  -c "lua print('UndotreeToggle exists:', vim.fn.exists(':UndotreeToggle') == 2 and 'YES' or 'NO')" \
  -c "lua print('Window layout:', vim.g.undotree_WindowLayout or 'NOT SET')" \
  -c "lua print('Split width:', vim.g.undotree_SplitWidth or 'NOT SET')" \
  -c "lua print('Auto focus:', vim.g.undotree_SetFocusWhenToggle or 'NOT SET')" \
  -c "lua print('Undo enabled:', vim.o.undofile and 'YES' or 'NO')" \
  -c "lua print('Undo levels:', vim.o.undolevels)" \
  -c "qa" 2>&1 | grep -E "(UndotreeToggle|Window|Split|Auto|Undo)" || echo "Test completed"