-- Test which-key.nvim plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, which_key = pcall(require, "which-key")
if not ok then
	print("✗ Failed to require which-key module")
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

-- Test which-key functions
test("Which-key has setup function", type(which_key.setup) == "function")
test("Which-key has add function", type(which_key.add) == "function")
test("Which-key has show function", type(which_key.show) == "function")

-- Test which-key is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "which-key.nvim" then
		config_exists = plugin.config ~= nil
		break
	end
end
test("Which-key plugin has config function", config_exists)

-- Try to setup which-key (should not error)
local setup_ok = pcall(which_key.setup, {
	plugins = {
		spelling = { enabled = false },
	},
})
test("Which-key setup completes without error", setup_ok)

-- Test which-key commands
test("WhichKey command exists", vim.fn.exists(":WhichKey") > 0)

-- Summary
print("\n=== Which-key Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
