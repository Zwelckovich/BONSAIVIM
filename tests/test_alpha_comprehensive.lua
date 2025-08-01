-- Comprehensive test for alpha-nvim startup screen
vim.opt.runtimepath:append(".")

-- Test results tracking
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

-- Load required modules
local ok, alpha = pcall(require, "alpha")
test("Alpha module loads", ok)

if not ok then
	print("Cannot continue tests - alpha module failed to load")
	vim.cmd("cq")
	return
end

-- Test dashboard theme
local dashboard_ok, dashboard = pcall(require, "alpha.themes.dashboard")
test("Dashboard theme loads", dashboard_ok)

-- Test alpha configuration from plugin
local lazy_ok, lazy = pcall(require, "lazy")
test("Lazy module loads", lazy_ok)

if lazy_ok then
	local plugin_list = lazy.plugins()
	local alpha_plugin = nil
	for _, plugin in ipairs(plugin_list) do
		if plugin.name == "alpha-nvim" then
			alpha_plugin = plugin
			break
		end
	end

	test("Alpha plugin found in lazy", alpha_plugin ~= nil)
	test("Alpha plugin has config", alpha_plugin and alpha_plugin.config ~= nil)
	test("Alpha plugin has dependencies", alpha_plugin and alpha_plugin.dependencies ~= nil)
end

-- Test color highlights
local function test_highlight(hl_name)
	local hl = vim.api.nvim_get_hl(0, { name = hl_name })
	return hl and (hl.fg or hl.bg) ~= nil
end

test("AlphaHeader highlight exists", test_highlight("AlphaHeader"))
test("AlphaHeaderLabel highlight exists", test_highlight("AlphaHeaderLabel"))
test("AlphaButtons highlight exists", test_highlight("AlphaButtons"))
test("AlphaShortcut highlight exists", test_highlight("AlphaShortcut"))
test("AlphaFile highlight exists", test_highlight("AlphaFile"))
test("AlphaFileShortcut highlight exists", test_highlight("AlphaFileShortcut"))
test("AlphaEmpty highlight exists", test_highlight("AlphaEmpty"))
test("AlphaFooter highlight exists", test_highlight("AlphaFooter"))

-- Test startup time stats
local stats_ok, stats = pcall(require("lazy").stats)
test("Lazy stats available", stats_ok and stats ~= nil)
if stats_ok and stats then
	test("Startup time measured", stats.startuptime ~= nil and stats.startuptime >= 0)
	test("Plugin count available", stats.count ~= nil and stats.count > 0)
	test("Loaded plugins tracked", stats.loaded ~= nil and stats.loaded > 0)
end

-- Test dependencies
local telescope_ok = pcall(require, "telescope")
test("Telescope dependency available", telescope_ok)

local persistence_ok = pcall(require, "persistence")
test("Persistence dependency available", persistence_ok)

local devicons_ok = pcall(require, "nvim-web-devicons")
test("Devicons dependency available", devicons_ok)

-- Test alpha setup
local setup_ok = pcall(alpha.setup, dashboard.opts)
test("Alpha setup completes without error", setup_ok)

-- Test that quotes are defined
local alpha_config = vim.fn.expand("~/.config/nvim/lua/plugins/alpha.lua")
if vim.fn.filereadable(alpha_config) == 1 then
	local content = vim.fn.readfile(alpha_config)
	local has_quotes = false
	local has_ascii_art = false
	local has_buttons = false

	for _, line in ipairs(content) do
		if line:match("Grow purposefully") then
			has_quotes = true
		end
		if line:match("🌱") then
			has_ascii_art = true
		end
		if line:match("dashboard%.button") then
			has_buttons = true
		end
	end

	test("Zen quotes defined", has_quotes)
	test("BONSAI ASCII art defined", has_ascii_art)
	test("Dashboard buttons configured", has_buttons)
end

-- Summary
print("\n=== Alpha Comprehensive Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

-- Write results
local f = io.open("tests/results/alpha_test_results.txt", "w")
if f then
	f:write("=== Alpha Comprehensive Test Results ===\n")
	f:write("Passed: " .. tests_passed .. "\n")
	f:write("Failed: " .. tests_failed .. "\n")
	f:write("Total: " .. (tests_passed + tests_failed) .. "\n")
	f:close()
end

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end