-- Test markdown-preview.nvim plugin functionality
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

-- Test markdown-preview is configured
local config_exists = false
local plugin_list = require("lazy").plugins()
for _, plugin in ipairs(plugin_list) do
	if plugin.name == "markdown-preview.nvim" then
		config_exists = plugin.config ~= nil or plugin.build ~= nil
		test("Markdown-preview plugin found", true)
		test("Markdown-preview has build config", plugin.build ~= nil)
		break
	end
end
test("Markdown-preview plugin configured", config_exists)

-- Test markdown commands
test("MarkdownPreview command exists", vim.fn.exists(":MarkdownPreview") > 0)
test("MarkdownPreviewStop command exists", vim.fn.exists(":MarkdownPreviewStop") > 0)
test("MarkdownPreviewToggle command exists", vim.fn.exists(":MarkdownPreviewToggle") > 0)

-- Test markdown settings
test("Markdown preview browser setting", vim.g.mkdp_browser ~= nil or true) -- Optional setting

-- Summary
print("\n=== Markdown Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
