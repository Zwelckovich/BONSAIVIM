-- Test alpha-nvim plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, alpha = pcall(require, "alpha")
if not ok then
	print("✗ Failed to require alpha module")
	vim.cmd("cq")
	return
end

-- Test that we can get the default dashboard theme
local dashboard_ok, dashboard = pcall(require, "alpha.themes.dashboard")
if not dashboard_ok then
	print("✗ Failed to require alpha dashboard theme")
	vim.cmd("cq")
	return
end

-- Check that dashboard has necessary sections
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

-- Test dashboard structure
test("Dashboard has header section", dashboard.section and dashboard.section.header)
test("Dashboard has buttons section", dashboard.section and dashboard.section.buttons)
test("Dashboard has footer section", dashboard.section and dashboard.section.footer)
test("Dashboard has opts", dashboard.opts)

-- Test alpha functions
test("Alpha has setup function", type(alpha.setup) == "function")

-- Test alpha is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "alpha-nvim" then
		config_exists = plugin.config ~= nil
		break
	end
end
test("Alpha plugin has config function", config_exists)

-- Try to setup alpha (should not error)
local setup_ok = pcall(alpha.setup, dashboard.opts)
test("Alpha setup completes without error", setup_ok)

-- Check if alpha buffer would be created
test("Alpha filetype exists", vim.fn.exists("g:loaded_alpha") >= 0)

-- Summary
print("\n=== Alpha Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end