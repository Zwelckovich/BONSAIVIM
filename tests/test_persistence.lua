-- Test persistence.nvim session management plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, persistence = pcall(require, "persistence")
if not ok then
	print("✗ Failed to require persistence module")
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

-- Test persistence functions
test("Persistence has setup function", type(persistence.setup) == "function")
test("Persistence has load function", type(persistence.load) == "function")
test("Persistence has save function", type(persistence.save) == "function")
test("Persistence has start function", type(persistence.start) == "function")
test("Persistence has stop function", type(persistence.stop) == "function")

-- Test persistence is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "persistence.nvim" then
		config_exists = plugin.config ~= nil or plugin.opts ~= nil
		break
	end
end
test("Persistence plugin has config", config_exists)

-- Try to setup persistence (should not error)
local setup_ok = pcall(persistence.setup, {
	dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
	options = { "buffers", "curdir", "tabpages", "winsize" },
})
test("Persistence setup completes without error", setup_ok)

-- Summary
print("\n=== Persistence Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
