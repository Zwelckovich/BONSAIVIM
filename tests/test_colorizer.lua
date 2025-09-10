-- Test nvim-colorizer plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, colorizer = pcall(require, "colorizer")
if not ok then
	print("✗ Failed to require colorizer module")
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

-- Test colorizer functions
test("Colorizer has setup function", type(colorizer.setup) == "function")
test("Colorizer has attach_to_buffer function", type(colorizer.attach_to_buffer) == "function")
test("Colorizer has detach_from_buffer function", type(colorizer.detach_from_buffer) == "function")
test("Colorizer has reload_all_buffers function", type(colorizer.reload_all_buffers) == "function")

-- Test colorizer is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "nvim-colorizer.lua" then
		config_exists = plugin.config ~= nil or plugin.opts ~= nil
		break
	end
end
test("Colorizer plugin has config", config_exists)

-- Try to setup colorizer (should not error)
local setup_ok = pcall(colorizer.setup, {
	filetypes = { "*" },
	user_default_options = {
		RGB = true,
		RRGGBB = true,
		names = true,
		css = true,
	},
})
test("Colorizer setup completes without error", setup_ok)

-- Summary
print("\n=== Colorizer Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
