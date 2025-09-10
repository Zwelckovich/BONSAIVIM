-- Test nvim-web-devicons plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, devicons = pcall(require, "nvim-web-devicons")
if not ok then
	print("✗ Failed to require nvim-web-devicons module")
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

-- Test devicons functions
test("Devicons has setup function", type(devicons.setup) == "function")
test("Devicons has get_icon function", type(devicons.get_icon) == "function")
test("Devicons has get_icon_by_filetype function", type(devicons.get_icon_by_filetype) == "function")
test("Devicons has get_icons function", type(devicons.get_icons) == "function")

-- Test icon retrieval
local icon, color = devicons.get_icon("test.lua", "lua")
test("Can get icon for lua files", icon ~= nil)

-- Test devicons is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "nvim-web-devicons" then
		config_exists = plugin.config ~= nil or plugin.opts ~= nil
		break
	end
end
test("Devicons plugin has config", config_exists)

-- Try to setup devicons (should not error)
local setup_ok = pcall(devicons.setup, {
	default = true,
})
test("Devicons setup completes without error", setup_ok)

-- Summary
print("\n=== Icons Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
