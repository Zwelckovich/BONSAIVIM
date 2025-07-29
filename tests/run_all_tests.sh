#!/bin/bash
# Main test runner for BONSAI Neovim configuration

# Change to project root
cd "$(dirname "$0")/.."

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

# Run test suites
if [ -f "tests/run_tests.sh" ]; then
	run_test_suite "Core Configuration Tests" "tests/run_tests.sh"
fi

if [ -f "tests/test_plugins.sh" ]; then
	run_test_suite "Plugin Tests" "tests/test_plugins.sh"
fi

if [ -f "tests/run_lsp_tests.sh" ]; then
	run_test_suite "LSP & Formatting Tests" "tests/run_lsp_tests.sh"
fi

if [ -f "tests/run_snippet_tests.sh" ]; then
	run_test_suite "Snippet Tests" "tests/run_snippet_tests.sh"
fi

if [ -f "tests/run_gitsigns_tests.sh" ]; then
	run_test_suite "Gitsigns Tests" "tests/run_gitsigns_tests.sh"
fi

if [ -f "tests/run_lazygit_tests.sh" ]; then
	run_test_suite "LazyGit Tests" "tests/run_lazygit_tests.sh"
fi

if [ -f "tests/run_phase7_tests.sh" ]; then
	run_test_suite "Phase 7: Lualine & Undotree Tests" "tests/run_phase7_tests.sh"
fi

if [ -f "tests/run_phase8_tests.sh" ]; then
	run_test_suite "Phase 8: Session & File Management Tests" "tests/run_phase8_tests.sh"
fi

if [ -f "tests/run_phase9_tests.sh" ]; then
	run_test_suite "Phase 9: Colorscheme & Final Polish Tests" "tests/run_phase9_tests.sh"
fi

# Additional test scripts
if [ -f "tests/test_config.sh" ]; then
	run_test_suite "Config Load Tests" "tests/test_config.sh"
fi

if [ -f "tests/test_health.sh" ]; then
	run_test_suite "Health Check Tests" "tests/test_health.sh"
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
