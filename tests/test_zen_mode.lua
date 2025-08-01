-- Test zen-mode functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, zen_mode = pcall(require, "zen-mode")
if not ok then
	print("✗ Failed to require zen-mode module")
	vim.cmd("cq")
	return
end

print("✓ Zen-mode module loaded")

-- Test that zen_mode has necessary functions
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

-- Test core functions
test("Zen-mode has setup function", type(zen_mode.setup) == "function")
test("Zen-mode has toggle function", type(zen_mode.toggle) == "function")
test("Zen-mode has open function", type(zen_mode.open) == "function")
test("Zen-mode has close function", type(zen_mode.close) == "function")

-- Test plugin configuration from lazy.nvim
local lazy_ok, lazy = pcall(require, "lazy")
if lazy_ok then
	local plugin_list = lazy.plugins()
	local zen_mode_plugin = nil
	for _, plugin in ipairs(plugin_list) do
		if plugin.name == "zen-mode.nvim" then
			zen_mode_plugin = plugin
			break
		end
	end

	test("Zen-mode plugin found in lazy", zen_mode_plugin ~= nil)
	if zen_mode_plugin then
		test("Zen-mode has cmd trigger", zen_mode_plugin.cmd and vim.tbl_contains(zen_mode_plugin.cmd, "ZenMode"))
		test("Zen-mode has key mappings", zen_mode_plugin.keys ~= nil and #zen_mode_plugin.keys > 0)
		test("Zen-mode has dependencies (twilight)", zen_mode_plugin.dependencies ~= nil)
	end
end

-- Test command existence
test("ZenMode command exists", vim.fn.exists(":ZenMode") == 2)

-- Test twilight integration
local twilight_ok = pcall(require, "twilight")
test("Twilight module available", twilight_ok)

-- Test highlight groups
local function test_highlight(hl_name)
	local hl = vim.api.nvim_get_hl(0, { name = hl_name })
	return hl and (hl.fg or hl.bg) ~= nil
end

test("TwilightDimmed highlight exists", test_highlight("TwilightDimmed"))
test("TwilightActive highlight exists", test_highlight("TwilightActive"))

-- Summary
print("\n=== Zen-Mode Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end