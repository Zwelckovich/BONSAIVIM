-- Test nvim-treesitter plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	print("✗ Failed to require nvim-treesitter.configs module")
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

-- Test treesitter functions
test("Treesitter configs has setup function", type(configs.setup) == "function")

-- Test treesitter modules
local ts_ok = pcall(require, "nvim-treesitter")
test("Treesitter main module loads", ts_ok)

local install_ok, install = pcall(require, "nvim-treesitter.install")
test("Treesitter install module loads", install_ok)
if install_ok then
	test("Treesitter has update function", type(install.update) == "function")
end

-- Test treesitter is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "nvim-treesitter" then
		config_exists = plugin.config ~= nil
		break
	end
end
test("Treesitter plugin has config function", config_exists)

-- Test treesitter commands
test("TSInstall command exists", vim.fn.exists(":TSInstall") > 0)
test("TSUpdate command exists", vim.fn.exists(":TSUpdate") > 0)

-- Summary
print("\n=== Treesitter Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
