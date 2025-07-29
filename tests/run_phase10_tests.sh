#!/bin/bash

echo "=== Phase 10: nvim-spectre Test Suite ==="
echo ""

# Store the project root
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Create results directory if it doesn't exist
mkdir -p "$PROJECT_ROOT/tests/results"

# Run comprehensive Phase 10 tests
echo "Running Phase 10 spectre tests..."
cd "$PROJECT_ROOT" || exit 1

# Run the comprehensive test suite
lua tests/test_phase10_spectre.lua 2>&1 | tee tests/results/phase10_results.txt

# Check if tests passed
if [ ${PIPESTATUS[0]} -eq 0 ]; then
    echo ""
    echo "✅ All Phase 10 tests passed!"
    
    # Also run plugin verification in neovim
    echo ""
    echo "Verifying spectre plugin in Neovim environment..."
    cd config/.config/nvim || exit 1
    nvim --headless -u init.lua -c "luafile verify_plugins.lua" 2>&1 | grep -E "(Spectre|Summary)"
    
    exit 0
else
    echo ""
    echo "❌ Some Phase 10 tests failed!"
    exit 1
fi