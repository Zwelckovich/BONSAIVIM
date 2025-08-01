#!/bin/bash

# Test runner for alpha-nvim startup screen

echo "=== Running Alpha-nvim Tests ==="
echo

# Create results directory if it doesn't exist
mkdir -p tests/results

# Basic plugin load test
echo "1. Running basic alpha test..."
nvim --headless -u config/.config/nvim/init.lua -c "source tests/test_alpha.lua" -c "qa"
BASIC_EXIT=$?
echo

# Comprehensive test
echo "2. Running comprehensive alpha test..."
nvim --headless -u config/.config/nvim/init.lua -c "source tests/test_alpha_comprehensive.lua" -c "qa"
COMPREHENSIVE_EXIT=$?
echo

# Check plugin verification
echo "3. Verifying alpha in plugin list..."
nvim --headless -u config/.config/nvim/init.lua -c "source config/.config/nvim/verify_plugins.lua" -c "qa" 2>&1 | grep -i "Alpha loaded successfully"
VERIFY_EXIT=$?
echo

# Calculate total result
TOTAL_FAILURES=$((BASIC_EXIT + COMPREHENSIVE_EXIT))

if [ $TOTAL_FAILURES -eq 0 ] && [ $VERIFY_EXIT -eq 0 ]; then
    echo "✅ All alpha tests passed!"
    exit 0
else
    echo "❌ Some alpha tests failed"
    echo "Basic test: $([ $BASIC_EXIT -eq 0 ] && echo 'PASS' || echo 'FAIL')"
    echo "Comprehensive test: $([ $COMPREHENSIVE_EXIT -eq 0 ] && echo 'PASS' || echo 'FAIL')"
    echo "Plugin verification: $([ $VERIFY_EXIT -eq 0 ] && echo 'PASS' || echo 'FAIL')"
    exit 1
fi