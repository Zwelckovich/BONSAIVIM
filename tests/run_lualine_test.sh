#!/bin/bash
# Run lualine tests with proper environment

export XDG_CONFIG_HOME="/home/zwelch/projects/BONSAIVIM/config/.config"
export XDG_DATA_HOME="/home/zwelch/projects/BONSAIVIM/config/.local/share"

nvim --headless -u config/.config/nvim/init.lua \
  -c "lua vim.wait(3000)" \
  -c "lua local lazy = require('lazy'); lazy.load({plugins = {'lualine.nvim'}})" \
  -c "lua vim.wait(1000)" \
  -c "lua local ok, lualine = pcall(require, 'lualine'); print('Lualine loads:', ok)" \
  -c "lua local config = require('lualine').get_config(); print('Config exists:', config ~= nil)" \
  -c "lua print('Sections configured:', config and config.sections and 'YES' or 'NO')" \
  -c "lua print('Theme configured:', config and config.options and config.options.theme and 'YES' or 'NO')" \
  -c "lua print('Globalstatus:', config and config.options and config.options.globalstatus and 'YES' or 'NO')" \
  -c "qa" 2>&1 | grep -E "(Lualine|Config|Sections|Theme|Globalstatus)" || echo "Test completed"