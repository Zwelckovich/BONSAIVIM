-- Test flash.nvim navigation plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, flash = pcall(require, "flash")
if not ok then
	print("✗ Failed to require flash module")
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

-- Test flash functions
test("Flash has setup function", type(flash.setup) == "function")
test("Flash has jump function", type(flash.jump) == "function")
test("Flash has treesitter function", type(flash.treesitter) == "function")
test("Flash has treesitter_search function", type(flash.treesitter_search) == "function")

-- Test flash is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "flash.nvim" then
		config_exists = plugin.config ~= nil or plugin.opts ~= nil
		break
	end
end
test("Flash plugin has config", config_exists)

-- Try to setup flash (should not error)
local setup_ok = pcall(flash.setup, {
	modes = {
		search = { enabled = true },
		char = { enabled = true },
	},
})
test("Flash setup completes without error", setup_ok)

-- Summary
print("\n=== Flash Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
