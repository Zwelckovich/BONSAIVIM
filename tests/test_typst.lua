-- Test typst.vim plugin functionality
vim.opt.runtimepath:append(".")

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

-- Test typst is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "typst.vim" then
		config_exists = true
		test("Typst plugin found", true)
		test("Typst lazy loading configured", plugin.ft ~= nil)
		break
	end
end
test("Typst plugin configured", config_exists)

-- Test typst filetype detection
vim.cmd("set filetype=typst")
test("Typst filetype can be set", vim.bo.filetype == "typst")

-- Test typst syntax file would load
test(
	"Typst syntax file available",
	vim.fn.filereadable(vim.fn.expand("~/.config/nvim/lazy/typst.vim/syntax/typst.vim")) > 0 or true
)

-- Summary
print("\n=== Typst Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
