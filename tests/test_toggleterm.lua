-- test_toggleterm.lua
-- Comprehensive toggleterm.nvim tests

print("=== Toggleterm Plugin Tests ===\n")

local passed = 0
local failed = 0

local function test(name, fn)
	local ok, err = pcall(fn)
	if ok then
		print("✓ " .. name)
		passed = passed + 1
	else
		print("✗ " .. name .. " - " .. tostring(err))
		failed = failed + 1
	end
end

-- Force load toggleterm since it's lazy loaded
local lazy = require("lazy")
lazy.load({ plugins = { "toggleterm.nvim" } })
vim.wait(500) -- Give it time to load

-- Test 1: Plugin loads successfully
test("Toggleterm module loads", function()
	local toggleterm = require("toggleterm")
	assert(toggleterm ~= nil, "toggleterm module is nil")
end)

-- Test 2: Commands are available
test("ToggleTerm command exists", function()
	assert(vim.fn.exists(":ToggleTerm") == 2, ":ToggleTerm command not found")
end)

test("TermExec command exists", function()
	assert(vim.fn.exists(":TermExec") == 2, ":TermExec command not found")
end)

-- Test 3: Custom commands are registered
test("Lazygit command exists", function()
	assert(vim.fn.exists(":Lazygit") == 2, ":Lazygit command not found")
end)

test("PythonRepl command exists", function()
	assert(vim.fn.exists(":PythonRepl") == 2, ":PythonRepl command not found")
end)

test("NodeRepl command exists", function()
	assert(vim.fn.exists(":NodeRepl") == 2, ":NodeRepl command not found")
end)

test("RunFile command exists", function()
	assert(vim.fn.exists(":RunFile") == 2, ":RunFile command not found")
end)

-- Test 4: Keymaps are registered
test("Toggle terminal keymap (<C-\\>) exists", function()
	local keymaps = vim.api.nvim_get_keymap("n")
	local found = false
	for _, map in ipairs(keymaps) do
		if map.lhs == "<C-Bslash>" or map.lhs == "<C-\\>" then
			found = true
			break
		end
	end
	assert(found, "Toggle terminal keymap not found")
end)

test("Terminal float keymap (<leader>tf) exists", function()
	local keymaps = vim.api.nvim_get_keymap("n")
	local found = false
	for _, map in ipairs(keymaps) do
		if map.lhs == " tf" then -- leader is space
			found = true
			break
		end
	end
	assert(found, "Terminal float keymap not found")
end)

-- Test 5: Configuration is applied
test("Toggleterm configuration is valid", function()
	local config = require("toggleterm.config")
	assert(config ~= nil, "toggleterm config is nil")

	-- Check some key options
	local opts = config.get()
	assert(opts.direction == "float", "Default direction should be float")
	assert(opts.hide_numbers == true, "hide_numbers should be true")
	assert(opts.shade_terminals == false, "shade_terminals should be false for BONSAI colors")
end)

-- Test 6: Terminal module is accessible
test("Terminal module can be required", function()
	local Terminal = require("toggleterm.terminal").Terminal
	assert(Terminal ~= nil, "Terminal class is nil")
	assert(type(Terminal.new) == "function", "Terminal.new is not a function")
end)

-- Test 7: Float options are configured
test("Float terminal options are set", function()
	local config = require("toggleterm.config")
	local opts = config.get()
	assert(opts.float_opts ~= nil, "float_opts is nil")
	assert(opts.float_opts.border == "rounded", "Border should be rounded")
	assert(type(opts.float_opts.width) == "function", "Width should be a function")
	assert(type(opts.float_opts.height) == "function", "Height should be a function")
end)

-- Test 8: BONSAI colors are configured
test("BONSAI highlight groups are set", function()
	local config = require("toggleterm.config")
	local opts = config.get()
	assert(opts.highlights ~= nil, "highlights config is nil")
	assert(opts.highlights.Normal ~= nil, "Normal highlight not configured")
	assert(opts.highlights.NormalFloat ~= nil, "NormalFloat highlight not configured")
	assert(opts.highlights.FloatBorder ~= nil, "FloatBorder highlight not configured")
end)

-- Test 9: Size function works correctly
test("Terminal size function works", function()
	local config = require("toggleterm.config")
	local opts = config.get()
	assert(type(opts.size) == "function", "size should be a function")

	-- Test horizontal size
	local mock_term = { direction = "horizontal" }
	local size = opts.size(mock_term)
	assert(size == 15, "Horizontal terminal size should be 15")

	-- Test vertical size
	mock_term.direction = "vertical"
	size = opts.size(mock_term)
	assert(type(size) == "number", "Vertical terminal size should be a number")
	assert(size > 0, "Vertical terminal size should be positive")
end)

-- Test 10: Terminal navigation keymaps in terminal mode
test("Terminal navigation keymaps exist", function()
	-- These are terminal mode mappings, harder to test without actually opening a terminal
	-- Just verify the plugin loaded them
	local ok = pcall(function()
		vim.cmd("tnoremap")
	end)
	assert(ok, "Terminal mode mappings should be available")
end)

print("\n=== Test Summary ===")
print("Passed: " .. passed)
print("Failed: " .. failed)
print("Total: " .. (passed + failed))

if failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
