#!/bin/bash
# Test which-key functionality

echo "Testing which-key functionality..."
cd /home/zwelch/projects/BONSAIVIM/config/.config/nvim

# Sync plugins first
echo "Syncing plugins..."
nvim --headless -c 'Lazy sync' -c 'qa' 2>&1 | grep -E "(Installed|Updated|Cloning)" || echo "Plugins already up to date"

# Test if which-key is loaded and configured
echo -e "\nChecking which-key plugin status..."
nvim --headless -c 'lua local ok, wk = pcall(require, "which-key"); print("Which-key loaded:", ok); if ok then print("Version:", vim.inspect(wk.version or "unknown")) end' -c 'qa' 2>&1

# Test leader key setup
echo -e "\nChecking leader key configuration..."
nvim --headless -c 'lua print("Leader key is:", vim.g.mapleader or "default")' -c 'qa' 2>&1

# Test registered mappings
echo -e "\nChecking registered mappings..."
nvim --headless -c 'lua 
  local ok, wk = pcall(require, "which-key")
  if ok then
    -- Try to get mappings info
    print("Which-key module loaded successfully")
    
    -- Check if setup was called
    local setup_called = wk.setup ~= nil
    print("Setup function exists:", setup_called)
    
    -- Check key mappings
    local keymaps = vim.api.nvim_get_keymap("n")
    local leader_maps = 0
    for _, map in ipairs(keymaps) do
      if map.lhs:match("^<Space>") or map.lhs:match("^<leader>") then
        leader_maps = leader_maps + 1
      end
    end
    print("Leader mappings found:", leader_maps)
  else
    print("Failed to load which-key:", wk)
  end
' -c 'qa' 2>&1

# Check for errors in messages
echo -e "\nChecking for errors..."
nvim --headless -c 'messages' -c 'qa' 2>&1 | grep -i "error" || echo "No errors found"

echo -e "\nManual testing instructions:"
echo "=========================================="
echo "1. Open Neovim: nvim"
echo "2. Press <space> (leader key) and wait ~500ms"
echo "3. You should see the which-key popup menu with groups:"
echo "   - +buffer, +code, +find, +git, +toggle, etc."
echo "4. Try these specific commands:"
echo "   - <space>e    -> Should open file explorer"
echo "   - <space>ff   -> Should open Telescope find files"
echo "   - <space>tn   -> Should toggle relative numbers"
echo "   - <space>qq   -> Should quit all windows"
echo ""
echo "If the menu doesn't appear, try:"
echo "1. :WhichKey <space>  -> to manually trigger the menu"
echo "2. :checkhealth which-key -> to see detailed diagnostics"