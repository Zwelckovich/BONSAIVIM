-- Test telescope.nvim fuzzy finder plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, telescope = pcall(require, "telescope")
if not ok then
	print("✗ Failed to require telescope module")
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

-- Test telescope functions
test("Telescope has setup function", type(telescope.setup) == "function")
test("Telescope has load_extension function", type(telescope.load_extension) == "function")
test("Telescope has extensions table", type(telescope.extensions) == "table")

-- Test telescope builtin
local builtin_ok, builtin = pcall(require, "telescope.builtin")
test("Telescope builtin module loads", builtin_ok)
if builtin_ok then
	test("Telescope has find_files", type(builtin.find_files) == "function")
	test("Telescope has live_grep", type(builtin.live_grep) == "function")
	test("Telescope has buffers", type(builtin.buffers) == "function")
	test("Telescope has help_tags", type(builtin.help_tags) == "function")
end

-- Test telescope is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "telescope.nvim" then
		config_exists = plugin.config ~= nil
		break
	end
end
test("Telescope plugin has config function", config_exists)

-- Test telescope commands
test("Telescope command exists", vim.fn.exists(":Telescope") > 0)

-- Summary
print("\n=== Telescope Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
