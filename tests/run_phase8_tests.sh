#!/usr/bin/env bash
# Test runner for Phase 8: Session & File Management plugins

set -e

echo "=== Running Phase 8 Tests: Persistence & Yazi ==="
echo "Testing session management and file manager plugins..."
echo ""

# Set up test environment
export HOME=/home/zwelch
export XDG_CONFIG_HOME=/home/zwelch/projects/BONSAIVIM/config/.config

# Run the Phase 8 plugin tests
echo "Testing plugin loading and functionality..."
nvim --headless -u config/.config/nvim/init.lua +'luafile tests/test_phase8_plugins.lua' 2>&1 || {
    echo "❌ Phase 8 plugin tests failed!"
    exit 1
}

echo ""
echo "✅ All Phase 8 tests passed!"
echo ""
echo "Summary:"
echo "- Persistence plugin loads and configures correctly"
echo "- Session directory is created"
echo "- All persistence keymaps are registered"
echo "- Yazi command is available"
echo "- All yazi keymaps are registered"
echo ""
echo "Phase 8 implementation complete!"