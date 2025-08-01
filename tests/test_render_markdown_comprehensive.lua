-- Comprehensive test for render-markdown.nvim
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
local ok, render_markdown = pcall(require, "render-markdown")
test("Render-markdown module loads", ok)

if not ok then
	print("Cannot continue tests - render-markdown module failed to load")
	vim.cmd("cq")
	return
end

-- Test plugin configuration from lazy
local lazy_ok, lazy = pcall(require, "lazy")
test("Lazy module loads", lazy_ok)

local render_markdown_plugin = nil
if lazy_ok then
	local plugin_list = lazy.plugins()
	for _, plugin in ipairs(plugin_list) do
		if plugin.name == "render-markdown.nvim" then
			render_markdown_plugin = plugin
			break
		end
	end
end

test("Render-markdown plugin found in lazy", render_markdown_plugin ~= nil)
test("Render-markdown has config", render_markdown_plugin and render_markdown_plugin.config ~= nil)
test("Render-markdown has dependencies", render_markdown_plugin and render_markdown_plugin.dependencies ~= nil)
test("Render-markdown loads on ft markdown", render_markdown_plugin and render_markdown_plugin.ft and vim.tbl_contains(render_markdown_plugin.ft, "markdown"))

-- Test render-markdown API functions
test("Render-markdown has setup function", type(render_markdown.setup) == "function")
test("Render-markdown has toggle function", type(render_markdown.toggle) == "function")
test("Render-markdown has enable function", type(render_markdown.enable) == "function")
test("Render-markdown has disable function", type(render_markdown.disable) == "function")

-- Test BONSAI color highlights
local function test_highlight(hl_name)
	local hl = vim.api.nvim_get_hl(0, { name = hl_name })
	return hl and (hl.fg or hl.bg) ~= nil
end

-- Heading highlights
test("RenderMarkdownH1 highlight exists", test_highlight("RenderMarkdownH1"))
test("RenderMarkdownH2 highlight exists", test_highlight("RenderMarkdownH2"))
test("RenderMarkdownH3 highlight exists", test_highlight("RenderMarkdownH3"))
test("RenderMarkdownH4 highlight exists", test_highlight("RenderMarkdownH4"))
test("RenderMarkdownH5 highlight exists", test_highlight("RenderMarkdownH5"))
test("RenderMarkdownH6 highlight exists", test_highlight("RenderMarkdownH6"))

-- Background highlights
test("RenderMarkdownH1Bg highlight exists", test_highlight("RenderMarkdownH1Bg"))
test("RenderMarkdownH2Bg highlight exists", test_highlight("RenderMarkdownH2Bg"))

-- Code highlights
test("RenderMarkdownCode highlight exists", test_highlight("RenderMarkdownCode"))
test("RenderMarkdownCodeInline highlight exists", test_highlight("RenderMarkdownCodeInline"))

-- List highlights
test("RenderMarkdownBullet highlight exists", test_highlight("RenderMarkdownBullet"))
test("RenderMarkdownChecked highlight exists", test_highlight("RenderMarkdownChecked"))
test("RenderMarkdownUnchecked highlight exists", test_highlight("RenderMarkdownUnchecked"))

-- Table highlights
test("RenderMarkdownTableHead highlight exists", test_highlight("RenderMarkdownTableHead"))
test("RenderMarkdownTableRow highlight exists", test_highlight("RenderMarkdownTableRow"))
test("RenderMarkdownTableFill highlight exists", test_highlight("RenderMarkdownTableFill"))

-- Other highlights
test("RenderMarkdownLink highlight exists", test_highlight("RenderMarkdownLink"))
test("RenderMarkdownBold highlight exists", test_highlight("RenderMarkdownBold"))
test("RenderMarkdownItalic highlight exists", test_highlight("RenderMarkdownItalic"))
test("RenderMarkdownQuote highlight exists", test_highlight("RenderMarkdownQuote"))
test("RenderMarkdownDash highlight exists", test_highlight("RenderMarkdownDash"))

-- Callout highlights
test("RenderMarkdownInfo highlight exists", test_highlight("RenderMarkdownInfo"))
test("RenderMarkdownSuccess highlight exists", test_highlight("RenderMarkdownSuccess"))
test("RenderMarkdownHint highlight exists", test_highlight("RenderMarkdownHint"))
test("RenderMarkdownWarn highlight exists", test_highlight("RenderMarkdownWarn"))
test("RenderMarkdownError highlight exists", test_highlight("RenderMarkdownError"))
test("RenderMarkdownTodo highlight exists", test_highlight("RenderMarkdownTodo"))

-- Additional highlights
test("RenderMarkdownSign highlight exists", test_highlight("RenderMarkdownSign"))
test("RenderMarkdownMath highlight exists", test_highlight("RenderMarkdownMath"))

-- Test configuration structure
test("Render-markdown has config for keymaps", render_markdown_plugin and render_markdown_plugin.config ~= nil)

-- Summary
print("\n=== Render-Markdown Comprehensive Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

-- Write results
local f = io.open("tests/results/render_markdown_test_results.txt", "w")
if f then
	f:write("=== Render-Markdown Comprehensive Test Results ===\n")
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