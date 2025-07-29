#!/bin/bash

# BONSAI Phase 9 Test Runner
# Tests colorscheme and autocommands

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../config/.config/nvim"

echo "🌱 BONSAI Phase 9 Tests - Colorscheme & Final Polish"
echo "=================================================="
echo ""

# Function to run a test
run_test() {
    local test_name="$1"
    local test_file="$2"
    
    echo -n "🧪 Running $test_name... "
    
    # Set runtime path and run test
    NVIM_OUTPUT=$(nvim --headless \
        --cmd "set rtp+=$CONFIG_DIR" \
        -c "lua dofile('$test_file')" \
        2>&1)
    
    if [ $? -eq 0 ]; then
        echo "✅ PASSED"
        return 0
    else
        echo "❌ FAILED"
        echo "$NVIM_OUTPUT" | grep -E "(FAILED|Error|error)" | head -10
        return 1
    fi
}

# Track overall results
TOTAL_TESTS=0
PASSED_TESTS=0

# Test 1: Colorscheme Tests
echo "📦 Testing BONSAI Colorscheme..."
echo "--------------------------------"
if run_test "Colorscheme functionality" "$SCRIPT_DIR/test_colorscheme.lua"; then
    ((PASSED_TESTS++))
fi
((TOTAL_TESTS++))

echo ""

# Test 2: Autocommands Tests
echo "📦 Testing Autocommands..."
echo "-------------------------"
if run_test "Autocommands functionality" "$SCRIPT_DIR/test_autocommands.lua"; then
    ((PASSED_TESTS++))
fi
((TOTAL_TESTS++))

echo ""

# Test 3: Startup Performance Test
echo "📦 Testing Startup Performance..."
echo "--------------------------------"
echo -n "🧪 Measuring startup time... "

# Measure startup time
START_TIME=$(date +%s%N)
nvim --headless \
    --cmd "let g:startup_time = reltime()" \
    --cmd "set rtp+=$CONFIG_DIR" \
    -c "lua require('config.options')" \
    -c "lua require('config.lazy')" \
    -c "lua require('config.keymaps')" \
    -c "lua require('config.autocommands')" \
    -c "echo reltimefloat(reltime(g:startup_time)) * 1000" \
    -c "qa" 2>&1 | tail -1 > /tmp/nvim_startup_time.txt

STARTUP_MS=$(cat /tmp/nvim_startup_time.txt | grep -o '[0-9.]\+' | head -1)
rm -f /tmp/nvim_startup_time.txt

if [ -n "$STARTUP_MS" ]; then
    # Check if under 50ms (convert to integer comparison)
    STARTUP_INT=$(echo "$STARTUP_MS" | cut -d. -f1)
    if [ -z "$STARTUP_INT" ]; then
        STARTUP_INT=0
    fi
    
    if [ "$STARTUP_INT" -lt 50 ]; then
        echo "✅ PASSED (${STARTUP_MS}ms < 50ms)"
        ((PASSED_TESTS++))
    else
        echo "❌ FAILED (${STARTUP_MS}ms > 50ms)"
    fi
else
    echo "❌ FAILED (could not measure)"
fi
((TOTAL_TESTS++))

echo ""

# Test 4: Integration Test - Load everything and verify
echo "📦 Testing Full Integration..."
echo "-----------------------------"
echo -n "🧪 Loading complete configuration... "

INTEGRATION_OUTPUT=$(nvim --headless \
    --cmd "set rtp+=$CONFIG_DIR" \
    -c "lua require('config.options')" \
    -c "lua require('config.lazy')" \
    -c "lua require('config.keymaps')" \
    -c "lua require('config.autocommands')" \
    -c "lua require('bonsai.colors').setup()" \
    -c "echo 'SUCCESS'" \
    -c "qa" 2>&1)

if echo "$INTEGRATION_OUTPUT" | grep -q "SUCCESS"; then
    echo "✅ PASSED"
    ((PASSED_TESTS++))
else
    echo "❌ FAILED"
    echo "$INTEGRATION_OUTPUT" | grep -E "(Error|error)" | head -5
fi
((TOTAL_TESTS++))

echo ""

# Final Summary
echo "=================================================="
echo "📊 Phase 9 Test Summary"
echo "=================================================="
echo "✅ Passed: $PASSED_TESTS"
echo "❌ Failed: $((TOTAL_TESTS - PASSED_TESTS))"
echo "📋 Total:  $TOTAL_TESTS"
echo ""

if [ $PASSED_TESTS -eq $TOTAL_TESTS ]; then
    echo "🎉 All Phase 9 tests passed!"
    exit 0
else
    echo "❌ Some tests failed. Please review the output above."
    exit 1
fi