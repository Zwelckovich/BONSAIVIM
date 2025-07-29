#!/bin/bash

# run_toggleterm_tests.sh - Test runner for toggleterm.nvim

echo "🧪 Running toggleterm tests..."
echo "================================"

# Set up paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../config/.config/nvim"

# Create results directory
mkdir -p "$SCRIPT_DIR/results"

# Run toggleterm tests
echo "Testing toggleterm plugin functionality..."
nvim --headless \
  -u "$CONFIG_DIR/init.lua" \
  -c "luafile $SCRIPT_DIR/test_toggleterm.lua" \
  > "$SCRIPT_DIR/results/toggleterm_test_results.txt" 2>&1

# Check results
if [ $? -eq 0 ]; then
  echo "✅ Toggleterm tests PASSED"
  cat "$SCRIPT_DIR/results/toggleterm_test_results.txt"
else
  echo "❌ Toggleterm tests FAILED"
  cat "$SCRIPT_DIR/results/toggleterm_test_results.txt"
  exit 1
fi

echo ""
echo "✨ All toggleterm tests completed successfully!"