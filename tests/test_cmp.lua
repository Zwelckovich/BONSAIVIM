-- Test nvim-cmp completion plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, cmp = pcall(require, "cmp")
if not ok then
	print("✗ Failed to require cmp module")
	vim.cmd("cq")
	return
end

-- Test variables
local tests_passed = 0
local tests_failed = 0

local function test(name, condition)
	if condition then
		print("✓ " .. name)
		tests_passed = tests_passed + 1
	else
		print("✗ " .. name)
		tests_failed = tests_failed + 1
	end
end

-- Test cmp functions
test("Cmp has setup function", type(cmp.setup) == "function")
test("Cmp has mapping functions", type(cmp.mapping) == "table")
test("Cmp has config functions", type(cmp.config) == "table")

-- Test cmp sources
local lspconfig_ok = pcall(require, "cmp_nvim_lsp")
test("Cmp LSP source available", lspconfig_ok)

local luasnip_ok = pcall(require, "cmp_luasnip")
test("Cmp LuaSnip source available", luasnip_ok)

-- Test cmp is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "nvim-cmp" then
		config_exists = plugin.config ~= nil
		break
	end
end
test("Cmp plugin has config function", config_exists)

-- Test completion mappings
test("Cmp mapping.select_next_item exists", type(cmp.mapping.select_next_item) == "function")
test("Cmp mapping.select_prev_item exists", type(cmp.mapping.select_prev_item) == "function")
test("Cmp mapping.confirm exists", type(cmp.mapping.confirm) == "function")

-- Summary
print("\n=== Cmp Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
