#!/bin/bash
# Test runner for Phase 7: UI Enhancement (Lualine & Undotree)

echo "Running Phase 7 UI Tests..."
echo "=========================="

# Track test results
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to run a test and track results
run_test() {
    local test_name="$1"
    local test_file="$2"
    
    echo ""
    echo "Running $test_name..."
    echo "--------------------------"
    
    if nvim -l "$test_file" 2>&1; then
        echo "✓ $test_name PASSED"
        ((PASSED_TESTS++))
    else
        echo "✗ $test_name FAILED"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
}

# Run plugin verification first
echo "1. Plugin Verification"
echo "--------------------------"
nvim --headless -u config/.config/nvim/init.lua -c "source config/.config/nvim/verify_plugins.lua" -c "qa" 2>&1 | grep -E "(Lualine|Undotree|SUMMARY|✓|✗)"

# Run individual plugin tests
run_test "Lualine Tests" "tests/test_lualine.lua"
run_test "Undotree Tests" "tests/test_undotree_plugin.lua"

# Summary
echo ""
echo "=========================="
echo "Phase 7 Test Summary"
echo "=========================="
echo "Total tests run: $TOTAL_TESTS"
echo "Passed: $PASSED_TESTS"
echo "Failed: $FAILED_TESTS"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    echo "✅ All Phase 7 tests passed!"
    exit 0
else
    echo "❌ Some tests failed!"
    exit 1
fi