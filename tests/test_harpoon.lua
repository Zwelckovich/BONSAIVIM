-- Test harpoon plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, harpoon = pcall(require, "harpoon")
if not ok then
	print("✗ Failed to require harpoon module")
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

-- Test harpoon functions
test("Harpoon has setup function", type(harpoon.setup) == "function")

-- Test harpoon UI
local ui_ok, ui = pcall(require, "harpoon.ui")
test("Harpoon UI module loads", ui_ok)
if ui_ok then
	test("Harpoon UI has toggle_quick_menu", type(ui.toggle_quick_menu) == "function")
	test("Harpoon UI has nav_next", type(ui.nav_next) == "function")
	test("Harpoon UI has nav_prev", type(ui.nav_prev) == "function")
end

-- Test harpoon mark
local mark_ok, mark = pcall(require, "harpoon.mark")
test("Harpoon mark module loads", mark_ok)
if mark_ok then
	test("Harpoon mark has add_file", type(mark.add_file) == "function")
end

-- Test harpoon is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "harpoon" then
		config_exists = plugin.config ~= nil
		break
	end
end
test("Harpoon plugin has config function", config_exists)

-- Summary
print("\n=== Harpoon Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
