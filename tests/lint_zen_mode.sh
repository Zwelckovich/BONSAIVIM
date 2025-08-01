#!/bin/bash

# BONSAI Phase 19 Zen-Mode Linting Script
# Uses Neovim's built-in Lua parser to check syntax

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../config/.config/nvim"

echo "🧪 BONSAI Phase 19 Zen-Mode Formatting & Linting"
echo "==============================================="
echo ""

# Track results
TOTAL_FILES=0
PASSED_FILES=0
FAILED_FILES=0
ISSUES_FOUND=0

# Function to check a Lua file
check_lua_file() {
    local file="$1"
    local filename=$(basename "$file")
    
    echo -n "Checking $filename... "
    
    # Check if file can be loaded without syntax errors
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
echo "📦 Checking Zen-Mode Lua files..."
echo "--------------------------------"

FILES=(
    "$CONFIG_DIR/lua/plugins/zen-mode.lua"
)

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        check_lua_file "$file"
        ((TOTAL_FILES++))
    fi
done

echo ""

# Check for common issues
echo "📦 Checking for common issues..."
echo "-------------------------------"

# Check for trailing whitespace
echo -n "Checking for trailing whitespace... "
TRAILING_WS=$(grep -n '[[:space:]]$' "${FILES[@]}" 2>/dev/null | wc -l)
if [ "$TRAILING_WS" -eq 0 ]; then
    echo "✅ PASSED (no trailing whitespace)"
else
    echo "❌ FAILED ($TRAILING_WS lines with trailing whitespace)"
    grep -n '[[:space:]]$' "${FILES[@]}" 2>/dev/null
    ((ISSUES_FOUND++))
fi

# Check for tabs vs spaces consistency
echo -n "Checking indentation consistency... "
TAB_LINES=$(grep -n $'\t' "${FILES[@]}" 2>/dev/null | wc -l)
if [ "$TAB_LINES" -eq 0 ]; then
    echo "✅ PASSED (spaces only)"
else
    echo "❌ FAILED ($TAB_LINES lines contain tabs - should use spaces)"
    grep -n $'\t' "${FILES[@]}" 2>/dev/null | head -5
    ((ISSUES_FOUND++))
fi

# Check for very long lines
echo -n "Checking line length (<120 chars)... "
LONG_LINES=$(awk 'length > 120' "${FILES[@]}" 2>/dev/null | wc -l)
if [ "$LONG_LINES" -eq 0 ]; then
    echo "✅ PASSED"
else
    echo "⚠️  WARNING ($LONG_LINES lines exceed 120 characters)"
    awk 'length > 120 { print FILENAME ":" NR ": " $0 }' "${FILES[@]}" 2>/dev/null | head -5
fi

# Check for unused local variables (simple check)
echo -n "Checking for unused locals... "
UNUSED_LOCALS=$(grep -n "^local.*=.*--.*unused" "${FILES[@]}" 2>/dev/null | wc -l)
if [ "$UNUSED_LOCALS" -eq 0 ]; then
    echo "✅ PASSED"
else
    echo "⚠️  WARNING ($UNUSED_LOCALS potential unused locals)"
fi

echo ""

# Summary
echo "==============================================="
echo "📊 Zen-Mode Linting Summary"
echo "==============================================="
echo "✅ Files passed: $PASSED_FILES"
echo "❌ Files failed: $FAILED_FILES"
echo "📋 Total files:  $TOTAL_FILES"
echo "🔍 Issues found: $ISSUES_FOUND"
echo ""

if [ $FAILED_FILES -eq 0 ] && [ $ISSUES_FOUND -eq 0 ]; then
    echo "🎉 All linting checks passed!"
    exit 0
else
    echo "❌ Some checks failed. Please review the output above."
    exit 1
fi