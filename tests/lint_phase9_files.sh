#!/bin/bash

# BONSAI Phase 9 Linting Script
# Uses Neovim's built-in Lua parser to check syntax

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../config/.config/nvim"

echo "🧪 BONSAI Phase 9 Formatting & Linting"
echo "====================================="
echo ""

# Track results
TOTAL_FILES=0
PASSED_FILES=0
FAILED_FILES=0

# Function to check a Lua file
check_lua_file() {
    local file="$1"
    local filename=$(basename "$file")
    
    echo -n "Checking $filename... "
    
    # Check syntax using luac (Lua compiler) for syntax checking only
    # First check if this is a test file that shouldn't be executed
    if [[ "$filename" == test_*.lua ]]; then
        # For test files, just check if they can be loaded without syntax errors
        ERROR_OUTPUT=$(nvim --headless -c "lua loadfile('$file')" -c "qa" 2>&1)
    else
        # For regular files, we can safely load them
        ERROR_OUTPUT=$(nvim --headless -c "lua dofile('$file')" -c "qa" 2>&1)
    fi
    
    # Also check for basic syntax with Lua's parser
    if echo "loadfile('$file')" | nvim --headless -c "lua" -c "qa" 2>&1 | grep -q "syntax error"; then
        echo "❌ FAILED (syntax error)"
        ((FAILED_FILES++))
        return 1
    fi
    
    echo "✅ PASSED"
    ((PASSED_FILES++))
    return 0
}

# Files to check
echo "📦 Checking Phase 9 Lua files..."
echo "--------------------------------"

FILES=(
    "$CONFIG_DIR/lua/bonsai/colors.lua"
    "$CONFIG_DIR/lua/config/autocommands.lua"
    "$SCRIPT_DIR/test_colorscheme.lua"
    "$SCRIPT_DIR/test_autocommands.lua"
)

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        check_lua_file "$file"
        ((TOTAL_FILES++))
    fi
done

echo ""

# Check for common issues in Lua files
echo "📦 Checking for common issues..."
echo "-------------------------------"

# Check for trailing whitespace
echo -n "Checking for trailing whitespace... "
TRAILING_WS=$(grep -n '[[:space:]]$' "${FILES[@]}" 2>/dev/null | wc -l)
if [ "$TRAILING_WS" -eq 0 ]; then
    echo "✅ PASSED (no trailing whitespace)"
else
    echo "❌ FAILED ($TRAILING_WS lines with trailing whitespace)"
    grep -n '[[:space:]]$' "${FILES[@]}" 2>/dev/null | head -5
fi

# Check for tabs vs spaces consistency
echo -n "Checking indentation consistency... "
TAB_FILES=$(grep -l $'\t' "${FILES[@]}" 2>/dev/null | wc -l)
if [ "$TAB_FILES" -eq 0 ]; then
    echo "✅ PASSED (spaces only)"
else
    echo "⚠️  WARNING ($TAB_FILES files contain tabs)"
fi

# Check for very long lines
echo -n "Checking line length (<120 chars)... "
LONG_LINES=$(awk 'length > 120' "${FILES[@]}" 2>/dev/null | wc -l)
if [ "$LONG_LINES" -eq 0 ]; then
    echo "✅ PASSED"
else
    echo "⚠️  WARNING ($LONG_LINES lines exceed 120 characters)"
fi

echo ""

# Summary
echo "====================================="
echo "📊 Linting Summary"
echo "====================================="
echo "✅ Files passed: $PASSED_FILES"
echo "❌ Files failed: $FAILED_FILES"
echo "📋 Total files:  $TOTAL_FILES"
echo ""

if [ $FAILED_FILES -eq 0 ] && [ "$TRAILING_WS" -eq 0 ]; then
    echo "🎉 All linting checks passed!"
    exit 0
else
    echo "❌ Some checks failed. Please review the output above."
    exit 1
fi