#!/bin/bash
# Comprehensive LSP and Formatting test runner for BONSAI Neovim

set -e  # Exit on error

# Change to project root
cd "$(dirname "$0")/.."

echo "=== BONSAI LSP & Formatting Test Suite ==="
echo "Testing Phase 4: Language Intelligence - LSP + Mason & Conform"
echo "================================================"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test results
TESTS_PASSED=0
TESTS_FAILED=0

# Function to run a test
run_test() {
    local test_name=$1
    local test_command=$2
    
    echo -e "\n${YELLOW}→ ${test_name}${NC}"
    if eval "$test_command"; then
        echo -e "${GREEN}✓ ${test_name} passed${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗ ${test_name} failed${NC}"
        ((TESTS_FAILED++))
    fi
}

# Test 1: Basic Neovim startup
run_test "Neovim startup" \
    "timeout 10 nvim --headless -u config/.config/nvim/init.lua -c 'lua print(\"Config loaded\")' -c 'qa' 2>&1 | grep -q 'Config loaded'"

# Test 2: Plugin installation
echo -e "\n${YELLOW}→ Installing/updating plugins...${NC}"
timeout 30 nvim --headless -u config/.config/nvim/init.lua -c "Lazy sync" -c "qa" 2>&1 > /dev/null

# Test 3: Run plugin verification
run_test "Plugin verification" \
    "timeout 15 nvim --headless -u config/.config/nvim/init.lua -l config/.config/nvim/verify_plugins.lua 2>&1"

# Test 4: Run comprehensive LSP tests
run_test "LSP and formatting tests" \
    "timeout 20 nvim --headless -u config/.config/nvim/init.lua -l tests/test_lsp_conform.lua 2>&1"

# Test 5: Check Mason installation
run_test "Mason installation" \
    "timeout 10 nvim --headless -u config/.config/nvim/init.lua -c 'lua if pcall(require, \"mason\") then vim.cmd(\"qa\") else vim.cmd(\"cq 1\") end' 2>&1"

# Test 6: Install LSP servers
echo -e "\n${YELLOW}→ Installing LSP servers via Mason (this may take a while)...${NC}"
timeout 90 nvim --headless -u config/.config/nvim/init.lua \
    -c "MasonInstall pyright typescript-language-server tailwindcss-language-server" \
    -c "qa" 2>&1 > /dev/null || true

# Test 7: Python file LSP test
echo -e "\n${YELLOW}→ Testing Python LSP functionality...${NC}"
cat > test_python_lsp.py << 'EOF'
def calculate_sum(a: int, b: int) -> int:
    """Calculate the sum of two integers."""
    return a + b

# This should trigger a diagnostic error
undefined_variable_error

result = calculate_sum(5, 3)
print(f"Result: {result}")
EOF

run_test "Python LSP activation" \
    "timeout 15 nvim --headless -u config/.config/nvim/init.lua test_python_lsp.py \
    -c 'lua vim.defer_fn(function() 
        local clients = vim.lsp.get_active_clients()
        if #clients > 0 then 
            print(\"LSP clients active: \" .. #clients)
            vim.cmd(\"qa\")
        else 
            print(\"No LSP clients active\")
            vim.cmd(\"cq 1\")
        end
    end, 5000)' 2>&1 | grep -q 'LSP clients active'"

# Test 8: JavaScript/TypeScript file test
echo -e "\n${YELLOW}→ Testing JavaScript/TypeScript LSP functionality...${NC}"
cat > test_typescript.ts << 'EOF'
interface User {
    name: string;
    age: number;
}

function greetUser(user: User): string {
    return `Hello, ${user.name}!`;
}

// This should trigger a type error
const invalidUser = { name: "John" };
greetUser(invalidUser);
EOF

run_test "TypeScript LSP activation" \
    "timeout 15 nvim --headless -u config/.config/nvim/init.lua test_typescript.ts \
    -c 'lua vim.defer_fn(function()
        local clients = vim.lsp.get_active_clients()
        if #clients > 0 then
            vim.cmd(\"qa\")
        else
            vim.cmd(\"cq 1\")
        end
    end, 5000)' 2>&1"

# Test 9: Formatting test
echo -e "\n${YELLOW}→ Testing code formatting...${NC}"
cat > test_format.py << 'EOF'
# Intentionally poorly formatted Python code
def messy_function(   x,y,   z ):
    result=x+y+z
    return    result

my_list=[1,2,3,4,5]
EOF

# Test if conform can format the file
run_test "Python formatting" \
    "timeout 10 nvim --headless -u config/.config/nvim/init.lua test_format.py \
    -c 'lua vim.defer_fn(function()
        local conform = require(\"conform\")
        local formatters = conform.list_formatters(0)
        if #formatters > 0 then
            print(\"Formatters available: \" .. table.concat(formatters, \", \"))
            vim.cmd(\"qa\")
        else
            print(\"No formatters available\")
            vim.cmd(\"cq 1\")
        end
    end, 2000)' 2>&1 | grep -q 'Formatters available'"

# Test 10: Keymap verification
echo -e "\n${YELLOW}→ Testing keymap registration...${NC}"
run_test "LSP keymaps" \
    "timeout 10 nvim --headless -u config/.config/nvim/init.lua \
    -c 'lua vim.defer_fn(function()
        local keymaps = vim.api.nvim_get_keymap(\"n\")
        local found_lsp_keymaps = false
        for _, map in ipairs(keymaps) do
            if string.match(map.lhs, \"gd\") or string.match(map.lhs, \"<leader>c\") then
                found_lsp_keymaps = true
                break
            end
        end
        if found_lsp_keymaps then
            print(\"LSP keymaps registered\")
            vim.cmd(\"qa\")
        else
            print(\"LSP keymaps not found\")
            vim.cmd(\"cq 1\")
        end
    end, 2000)' 2>&1 | grep -q 'LSP keymaps registered'"

# Cleanup test files
rm -f test_python_lsp.py test_typescript.ts test_format.py

# Summary
echo -e "\n================================================"
echo -e "${YELLOW}=== Test Summary ===${NC}"
echo -e "Total tests: $((TESTS_PASSED + TESTS_FAILED))"
echo -e "${GREEN}Passed: ${TESTS_PASSED}${NC}"
echo -e "${RED}Failed: ${TESTS_FAILED}${NC}"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "\n${GREEN}✓ All tests passed! LSP and formatting setup is working correctly.${NC}"
    exit 0
else
    echo -e "\n${RED}✗ Some tests failed. Please check the configuration.${NC}"
    exit 1
fi