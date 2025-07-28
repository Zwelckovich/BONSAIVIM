#!/bin/bash
# Main test runner for BONSAI Neovim configuration

echo "=== BONSAI Neovim Test Suite ==="
echo "================================"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Track overall results
ALL_PASSED=true

# Function to run a test suite
run_test_suite() {
    local suite_name=$1
    local test_script=$2
    
    echo -e "\n${YELLOW}Running ${suite_name}...${NC}"
    if bash "$test_script"; then
        echo -e "${GREEN}✓ ${suite_name} passed${NC}"
    else
        echo -e "${RED}✗ ${suite_name} failed${NC}"
        ALL_PASSED=false
    fi
}

# Run existing test suites
if [ -f "config/.config/nvim/run_tests.sh" ]; then
    run_test_suite "Core Configuration Tests" "config/.config/nvim/run_tests.sh"
fi

if [ -f "config/.config/nvim/test_plugins.sh" ]; then
    run_test_suite "Plugin Tests" "config/.config/nvim/test_plugins.sh"
fi

# Run new LSP tests
if [ -f "tests/run_lsp_tests.sh" ]; then
    run_test_suite "LSP & Formatting Tests" "tests/run_lsp_tests.sh"
fi

# Summary
echo -e "\n================================"
echo -e "${YELLOW}=== Overall Test Summary ===${NC}"

if $ALL_PASSED; then
    echo -e "${GREEN}✓ All test suites passed!${NC}"
    echo -e "${GREEN}BONSAI Neovim configuration is working correctly.${NC}"
    exit 0
else
    echo -e "${RED}✗ Some test suites failed.${NC}"
    echo -e "${RED}Please check the failing tests above.${NC}"
    exit 1
fi