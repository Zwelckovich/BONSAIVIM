-- Test conform.nvim formatter plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, conform = pcall(require, "conform")
if not ok then
	print("✗ Failed to require conform module")
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

-- Test conform functions
test("Conform has setup function", type(conform.setup) == "function")
test("Conform has format function", type(conform.format) == "function")
test("Conform has list_formatters function", type(conform.list_formatters) == "function")

-- Test conform is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "conform.nvim" then
		config_exists = plugin.config ~= nil
		break
	end
end
test("Conform plugin has config function", config_exists)

-- Test formatter configurations
local formatters = conform.list_all_formatters()
test("Conform has formatters configured", type(formatters) == "table")

-- Test format command exists
test("Format command exists", vim.fn.exists(":ConformInfo") > 0)

-- Summary
print("\n=== Conform Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
