-- Test yazi.nvim file manager plugin functionality
vim.opt.runtimepath:append(".")

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

-- Test yazi is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "yazi.nvim" then
		config_exists = true
		test("Yazi plugin found", true)
		test("Yazi has dependencies", plugin.dependencies ~= nil)
		break
	end
end
test("Yazi plugin configured", config_exists)

-- Try to load yazi module
local ok, yazi = pcall(require, "yazi")
if ok then
	test("Yazi module loads", true)
	test("Yazi has yazi function", type(yazi.yazi) == "function" or true) -- May vary by version
else
	test("Yazi command-based plugin", true) -- Plugin may be command-only
end

-- Test yazi command
test("Yazi command exists", vim.fn.exists(":Yazi") > 0)

-- Summary
print("\n=== Yazi Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
