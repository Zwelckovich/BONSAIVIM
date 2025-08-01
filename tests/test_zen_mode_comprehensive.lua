-- Comprehensive test suite for zen-mode.nvim
vim.opt.runtimepath:append(".")

-- Test results tracking
local tests_passed = 0
local tests_failed = 0
local test_results = {}

local function test(name, condition, details)
	local passed = false
	local msg = ""
	
	if type(condition) == "function" then
		local ok, result = pcall(condition)
		passed = ok and result
		if not passed then
			msg = result or "Test function failed"
		end
	else
		passed = condition
	end
	
	if passed then
		print("✓ " .. name)
		tests_passed = tests_passed + 1
		table.insert(test_results, { name = name, passed = true })
	else
		local error_msg = "✗ " .. name
		if details then
			error_msg = error_msg .. " - " .. details
		elseif msg ~= "" then
			error_msg = error_msg .. " - " .. msg
		end
		print(error_msg)
		tests_failed = tests_failed + 1
		table.insert(test_results, { name = name, passed = false, error = msg or details })
	end
	
	return passed
end

-- Force load plugins
local lazy_ok, lazy = pcall(require, "lazy")
if lazy_ok then
	lazy.load({ plugins = { "zen-mode.nvim", "twilight.nvim" } })
	vim.wait(2000)
end

-- Test 1: Module loading
local zen_ok, zen_mode = pcall(require, "zen-mode")
test("Zen-mode module loads", zen_ok)

-- Test 2: Required functions exist
if zen_ok then
	test("setup function exists", type(zen_mode.setup) == "function")
	test("toggle function exists", type(zen_mode.toggle) == "function")
	test("open function exists", type(zen_mode.open) == "function")
	test("close function exists", type(zen_mode.close) == "function")
end

-- Test 3: Twilight dependency
local twilight_ok, twilight = pcall(require, "twilight")
test("Twilight module loads", twilight_ok)

if twilight_ok then
	test("Twilight setup function exists", type(twilight.setup) == "function")
	test("Twilight enable function exists", type(twilight.enable) == "function")
	test("Twilight disable function exists", type(twilight.disable) == "function")
end

-- Test 4: Command registration
test("ZenMode command registered", vim.fn.exists(":ZenMode") == 2)

-- Test 5: Plugin configuration in lazy.nvim
if lazy_ok then
	local plugin_list = lazy.plugins()
	local zen_plugin = nil
	local twilight_plugin = nil
	
	for _, plugin in ipairs(plugin_list) do
		if plugin.name == "zen-mode.nvim" then
			zen_plugin = plugin
		elseif plugin.name == "twilight.nvim" then
			twilight_plugin = plugin
		end
	end
	
	test("Zen-mode plugin found in lazy", zen_plugin ~= nil)
	test("Twilight plugin found in lazy", twilight_plugin ~= nil)
	
	if zen_plugin then
		test("Zen-mode has cmd trigger", zen_plugin.cmd and vim.tbl_contains(zen_plugin.cmd, "ZenMode"))
		test("Zen-mode has keymaps", zen_plugin.keys and #zen_plugin.keys > 0)
		test("Zen-mode has opts", zen_plugin.opts ~= nil)
		test("Zen-mode has config function", zen_plugin.config ~= nil)
		test("Zen-mode has dependencies", zen_plugin.dependencies and #zen_plugin.dependencies > 0)
	end
end

-- Test 6: Configuration options
if zen_ok then
	-- Create a test configuration
	local test_config = {
		window = {
			backdrop = 0.95,
			width = 80,
			height = 1,
			options = {
				signcolumn = "no",
				number = false,
				relativenumber = false,
			},
		},
		plugins = {
			twilight = { enabled = true },
			gitsigns = { enabled = false },
		},
	}
	
	local setup_ok = pcall(zen_mode.setup, test_config)
	test("Zen-mode setup accepts configuration", setup_ok)
end

-- Test 7: Highlight groups
local function test_highlight(hl_name)
	local hl = vim.api.nvim_get_hl(0, { name = hl_name })
	return hl and (hl.fg ~= nil or hl.bg ~= nil)
end

test("TwilightDimmed highlight configured", test_highlight("TwilightDimmed"))
test("TwilightActive highlight configured", test_highlight("TwilightActive"))

-- Test 8: Keymapping (check if defined in config)
if lazy_ok and zen_plugin and zen_plugin.keys then
	local found_keymap = false
	for _, keymap in ipairs(zen_plugin.keys) do
		if keymap[1] == "<leader>zz" then
			found_keymap = true
			break
		end
	end
	test("<leader>zz keymap defined in config", found_keymap)
else
	test("<leader>zz keymap defined in config", false, "Plugin config not accessible")
end

-- Test 9: Window configuration
if zen_plugin and zen_plugin.opts then
	test("Window width configured (80 chars)", zen_plugin.opts.window and zen_plugin.opts.window.width == 80)
	test("Window backdrop configured", zen_plugin.opts.window and zen_plugin.opts.window.backdrop == 0.95)
	test("Window options configured", zen_plugin.opts.window and zen_plugin.opts.window.options ~= nil)
else
	test("Window width configured (80 chars)", false, "Plugin opts not accessible")
	test("Window backdrop configured", false, "Plugin opts not accessible")
	test("Window options configured", false, "Plugin opts not accessible")
end

-- Test 10: Plugin integrations
if zen_plugin and zen_plugin.opts and zen_plugin.opts.plugins then
	test("Twilight integration enabled", zen_plugin.opts.plugins.twilight and zen_plugin.opts.plugins.twilight.enabled == true)
	test("Gitsigns integration disabled", zen_plugin.opts.plugins.gitsigns and zen_plugin.opts.plugins.gitsigns.enabled == false)
	test("Tmux integration enabled", zen_plugin.opts.plugins.tmux and zen_plugin.opts.plugins.tmux.enabled == true)
else
	test("Twilight integration enabled", false, "Plugin opts not accessible")
	test("Gitsigns integration disabled", false, "Plugin opts not accessible") 
	test("Tmux integration enabled", false, "Plugin opts not accessible")
end

-- Test 11: Callback configuration
if zen_plugin and zen_plugin.opts then
	test("on_open callback configured", type(zen_plugin.opts.on_open) == "function")
	test("on_close callback removed (minimalism)", zen_plugin.opts.on_close == nil)
else
	test("on_open callback configured", false, "Plugin opts not accessible")
	test("on_close callback removed (minimalism)", false, "Plugin opts not accessible")
end

-- Write detailed results to file
local results_file = io.open("tests/results/zen_mode_test_results.txt", "w")
if results_file then
	results_file:write("=== Zen-Mode Comprehensive Test Results ===\n")
	results_file:write("Date: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n\n")
	results_file:write("Summary:\n")
	results_file:write("Passed: " .. tests_passed .. "\n")
	results_file:write("Failed: " .. tests_failed .. "\n")
	results_file:write("Total: " .. (tests_passed + tests_failed) .. "\n\n")
	
	results_file:write("Detailed Results:\n")
	for _, result in ipairs(test_results) do
		if result.passed then
			results_file:write("✓ " .. result.name .. "\n")
		else
			results_file:write("✗ " .. result.name)
			if result.error then
				results_file:write(" - " .. result.error)
			end
			results_file:write("\n")
		end
	end
	
	results_file:close()
end

-- Summary
print("\n=== Zen-Mode Comprehensive Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end