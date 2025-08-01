#!/bin/bash
# Run all zen-mode tests for Phase 19

echo "=== Phase 19: Zen-Mode Tests ==="
echo ""

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
NVIM_CONFIG="$PROJECT_ROOT/config/.config/nvim"

# Create results directory if it doesn't exist
mkdir -p "$SCRIPT_DIR/results"

# Function to run a test
run_test() {
    local test_name="$1"
    local test_file="$2"
    
    echo "Running $test_name..."
    
    # Run the test
    (cd "$NVIM_CONFIG" && /usr/bin/nvim --headless \
        -c "lua require('lazy').load({ plugins = { 'zen-mode.nvim', 'twilight.nvim' } })" \
        -c "lua vim.wait(2000)" \
        -c "source $test_file" 2>&1)
    
    local exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        echo "✓ $test_name passed"
    else
        echo "✗ $test_name failed (exit code: $exit_code)"
    fi
    
    echo ""
    return $exit_code
}

# Track overall results
total_tests=0
passed_tests=0

# Run basic zen-mode test
total_tests=$((total_tests + 1))
if run_test "Basic Zen-Mode Test" "$SCRIPT_DIR/test_zen_mode.lua"; then
    passed_tests=$((passed_tests + 1))
fi

# Run verification test
total_tests=$((total_tests + 1))
if run_test "Zen-Mode Verification" "$SCRIPT_DIR/verify_zen_mode.lua"; then
    passed_tests=$((passed_tests + 1))
fi

# Run comprehensive test
total_tests=$((total_tests + 1))
if run_test "Comprehensive Zen-Mode Test" "$SCRIPT_DIR/test_zen_mode_comprehensive.lua"; then
    passed_tests=$((passed_tests + 1))
fi

# Summary
echo "=== Phase 19 Test Summary ==="
echo "Total tests: $total_tests"
echo "Passed: $passed_tests"
echo "Failed: $((total_tests - passed_tests))"

# Write summary to results file
cat > "$SCRIPT_DIR/results/phase19_zen_mode_summary.txt" << EOF
Phase 19: Zen-Mode Test Summary
Date: $(date)

Total tests: $total_tests
Passed: $passed_tests
Failed: $((total_tests - passed_tests))

Test Files:
- test_zen_mode.lua
- verify_zen_mode.lua  
- test_zen_mode_comprehensive.lua
EOF

# Exit with appropriate code
if [ $passed_tests -eq $total_tests ]; then
    echo ""
    echo "✓ All Phase 19 tests passed!"
    exit 0
else
    echo ""
    echo "✗ Some Phase 19 tests failed"
    exit 1
fi