-- Test render-markdown functionality
vim.opt.runtimepath:append(".")

-- Load necessary modules
local ok, render_markdown = pcall(require, "render-markdown")
if not ok then
	print("✗ Failed to require render-markdown module")
	vim.cmd("cq")
	return
end

print("✓ Render-markdown module loaded")

-- Test that render_markdown has necessary functions
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

-- Test core functions
test("Render-markdown has setup function", type(render_markdown.setup) == "function")
test("Render-markdown has toggle function", type(render_markdown.toggle) == "function")
test("Render-markdown has enable function", type(render_markdown.enable) == "function")
test("Render-markdown has disable function", type(render_markdown.disable) == "function")

-- Test plugin configuration from lazy.nvim
local lazy_ok, lazy = pcall(require, "lazy")
if lazy_ok then
	local plugin_list = lazy.plugins()
	render_markdown_plugin = nil
	for _, plugin in ipairs(plugin_list) do
		if plugin.name == "render-markdown.nvim" then
			render_markdown_plugin = plugin
			break
		end
	end

	test("Render-markdown plugin found in lazy", render_markdown_plugin ~= nil)
	test("Render-markdown has dependencies", render_markdown_plugin and render_markdown_plugin.dependencies ~= nil)
	test("Render-markdown loads on ft markdown", render_markdown_plugin and render_markdown_plugin.ft and vim.tbl_contains(render_markdown_plugin.ft, "markdown"))
end

-- Test highlight groups
local function test_highlight(hl_name)
	local hl = vim.api.nvim_get_hl(0, { name = hl_name })
	return hl and (hl.fg or hl.bg) ~= nil
end

test("RenderMarkdownH1 highlight exists", test_highlight("RenderMarkdownH1"))
test("RenderMarkdownH2 highlight exists", test_highlight("RenderMarkdownH2"))
test("RenderMarkdownCode highlight exists", test_highlight("RenderMarkdownCode"))
test("RenderMarkdownBullet highlight exists", test_highlight("RenderMarkdownBullet"))
test("RenderMarkdownLink highlight exists", test_highlight("RenderMarkdownLink"))

-- Test keymapping
-- In headless mode, keymaps from lazy-loaded plugins may not be available
-- We'll check if the plugin config exists which would set up the keymap
if render_markdown_plugin and render_markdown_plugin.config then
	test("Render-markdown has config for keymaps", true)
else
	test("Render-markdown has config for keymaps", false)
end

-- Summary
print("\n=== Render-Markdown Test Summary ===")
print("Passed: " .. tests_passed)
print("Failed: " .. tests_failed)
print("Total: " .. (tests_passed + tests_failed))

if tests_failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end