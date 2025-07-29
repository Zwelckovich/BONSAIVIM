#!/bin/bash

echo "Testing which-key basic functionality..."
echo

# Test 1: Check if which-key loads
echo "1. Checking if which-key loads..."
nvim --headless -u config/.config/nvim/init.lua \
  -c "lua local ok, wk = pcall(require, 'which-key'); print(ok and 'which-key loaded successfully' or 'which-key failed to load')" \
  -c "qa" 2>&1

echo

# Test 2: Check leader key
echo "2. Checking leader key..."
nvim --headless -u config/.config/nvim/init.lua \
  -c "lua print('Leader key is: ' .. vim.inspect(vim.g.mapleader))" \
  -c "qa" 2>&1

echo

# Test 3: Check for errors
echo "3. Checking for errors in which-key config..."
nvim --headless -u config/.config/nvim/init.lua \
  -c "source config/.config/nvim/lua/plugins/which-key.lua" \
  -c "messages" \
  -c "qa" 2>&1 | grep -E "Error|error" || echo "No errors found"

echo
echo "If which-key loaded successfully and leader key is ' ' (space), try:"
echo "1. Open nvim normally"
echo "2. Press space and wait 500ms" 
echo "3. Run :WhichKey <space> if menu doesn't appear"