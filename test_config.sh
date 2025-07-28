#!/bin/bash
# BONSAI Neovim configuration test script

echo "🌱 Testing BONSAI Neovim Configuration"
echo "======================================"

# Test 1: Startup time
echo -n "1. Testing startup time... "
nvim --headless --startuptime /tmp/nvim-startup.log -c 'qa' >/dev/null 2>&1
START_TIME=$(grep "NVIM STARTED" /tmp/nvim-startup.log | tail -1 | awk '{print $1}')
if [ -n "$START_TIME" ]; then
    echo "✓ ${START_TIME}ms"
    # Check if under 50ms target (using integer comparison)
    START_TIME_INT=$(echo "$START_TIME" | cut -d. -f1)
    if [ "$START_TIME_INT" -lt 50 ]; then
        echo "   ✓ Meets <50ms target!"
    else
        echo "   ⚠ Above 50ms target"
    fi
else
    echo "✗ Failed to measure"
fi

# Test 2: Configuration loads without errors
echo -n "2. Testing configuration loads... "
if nvim --headless -c 'qa' 2>&1 | grep -q "Error"; then
    echo "✗ Errors found"
    nvim --headless -c 'qa' 2>&1
else
    echo "✓ No errors"
fi

# Test 3: Leader key is set
echo -n "3. Testing leader key... "
LEADER=$(nvim --headless -c 'lua print(vim.g.mapleader or "not set")' -c 'qa' 2>&1 | tail -1)
if [ "$LEADER" = " " ]; then
    echo "✓ Space"
else
    echo "✗ Not set correctly: '$LEADER'"
fi

# Test 3b: :Lazy command works
echo -n "3b. Testing :Lazy command... "
if nvim --headless -c 'Lazy' -c 'qa' 2>&1 | grep -q "Error"; then
    echo "✗ :Lazy command failed"
else
    echo "✓ :Lazy command works"
fi

# Test 4: Lazy.nvim is installed
echo -n "4. Testing lazy.nvim installation... "
if [ -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
    echo "✓ Installed"
else
    echo "✗ Not found"
fi

# Test 5: Key mappings work
echo -n "5. Testing key mappings... "
# Check if jk mapping exists
if nvim --headless -c 'imap jk' -c 'qa' 2>&1 | grep -q "jk.*<Esc>"; then
    echo "✓ jk escape mapping works"
else
    echo "✗ jk mapping not found"
fi

# Test 6: Options are set correctly
echo -n "6. Testing core options... "
RELATIVENUMBER=$(nvim --headless -c 'lua print(vim.opt.relativenumber:get())' -c 'qa' 2>&1 | tail -1)
if [ "$RELATIVENUMBER" = "true" ]; then
    echo "✓ Options set"
else
    echo "✗ Options not set correctly"
fi

echo
echo "======================================"
echo "Test complete!"