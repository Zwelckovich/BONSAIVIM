#!/bin/bash
# Test LSP and formatting setup

echo "=== Testing LSP and Formatting Configuration ==="

# Test Neovim loads without errors
echo "→ Testing Neovim startup..."
timeout 10 nvim --headless -u config/.config/nvim/init.lua -c "lua print('Config loaded successfully')" -c "qa" 2>&1

if [ $? -eq 0 ]; then
    echo "✓ Neovim started successfully"
else
    echo "✗ Neovim startup failed"
    exit 1
fi

# Install plugins
echo ""
echo "→ Installing plugins via Lazy..."
timeout 30 nvim --headless -u config/.config/nvim/init.lua -c "Lazy sync" -c "qa" 2>&1

# Check if Mason is installed
echo ""
echo "→ Checking Mason installation..."
timeout 10 nvim --headless -u config/.config/nvim/init.lua -c "lua if pcall(require, 'mason') then print('✓ Mason installed') else print('✗ Mason not found') end" -c "qa" 2>&1

# Check if conform is installed
echo ""
echo "→ Checking conform.nvim installation..."
timeout 10 nvim --headless -u config/.config/nvim/init.lua -c "lua if pcall(require, 'conform') then print('✓ conform.nvim installed') else print('✗ conform.nvim not found') end" -c "qa" 2>&1

# Check if lspconfig is installed
echo ""
echo "→ Checking nvim-lspconfig installation..."
timeout 10 nvim --headless -u config/.config/nvim/init.lua -c "lua if pcall(require, 'lspconfig') then print('✓ nvim-lspconfig installed') else print('✗ nvim-lspconfig not found') end" -c "qa" 2>&1

# Install LSP servers via Mason
echo ""
echo "→ Installing LSP servers via Mason (this may take a while)..."
timeout 60 nvim --headless -u config/.config/nvim/init.lua \
    -c "MasonInstall pyright ts_ls tailwindcss" \
    -c "qa" 2>&1

# Create test Python file
echo ""
echo "→ Testing Python LSP configuration..."
cat > test_python.py << 'EOF'
def greet(name: str) -> str:
    """Return a greeting message."""
    return f"Hello, {name}!"

# Test hover and diagnostics
undefined_variable
EOF

# Test Python LSP
timeout 10 nvim --headless -u config/.config/nvim/init.lua test_python.py \
    -c "lua vim.defer_fn(function() if #vim.lsp.get_active_clients() > 0 then print('✓ LSP client active') else print('✗ No LSP client') end vim.cmd('qa!') end, 3000)" 2>&1

# Cleanup
rm -f test_python.py

echo ""
echo "=== LSP Setup Test Complete ==="