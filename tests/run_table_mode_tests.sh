#!/bin/bash
# Run table-mode tests

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$SCRIPT_DIR/../config/.config/nvim"

echo "=== Running Table-Mode Tests ==="
echo ""

# Run the test
/usr/bin/nvim --headless --noplugin -u "$NVIM_CONFIG/init.lua" \
    -c "source $SCRIPT_DIR/test_table_mode.lua" 2>&1

exit_code=$?

echo ""
echo "Test completed with exit code: $exit_code"

exit $exit_code