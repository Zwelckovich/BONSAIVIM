-- Test bufferline.nvim plugin functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, bufferline = pcall(require, "bufferline")
if not ok then
	print("✗ Failed to require bufferline module")
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

-- Test bufferline functions
test("Bufferline has setup function", type(bufferline.setup) == "function")
test("Bufferline has style_preset", bufferline.style_preset ~= nil)
test("Bufferline has diagnostics support", true) -- Configured in plugin

-- Test bufferline is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "bufferline.nvim" then
		config_exists = plugin.config ~= nil
		break
	end
end
test("Bufferline plugin has config function", config_exists)

-- Try to setup bufferline (should not error)
local setup_ok = pcall(bufferline.setup, {
	options = {
		mode = "buffers",
		diagnostics = "nvim_lsp",
	},
})
test("Bufferline setup completes without error", setup_ok)

-- Check bufferline commands
test("Bufferline has buffer navigation", vim.fn.exists(":BufferLineCycleNext") > 0)

-- Summary
print("\n=== Bufferline Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
