-- Test for quarto plugin configuration
-- Tests that quarto-nvim plugin is properly configured

local function test_quarto_plugin()
	-- Test that plugin spec exists
	local config = require("lazy.core.config")
	local plugin = config.plugins["quarto-nvim"]

	if not plugin then
		print("✗ Quarto plugin not found in lazy.nvim config")
		return false
	end

	-- Verify basic configuration
	local ft = plugin.ft
	local has_quarto = false
	local has_markdown = false

	if type(ft) == "table" then
		has_quarto = vim.tbl_contains(ft, "quarto")
		has_markdown = vim.tbl_contains(ft, "markdown")
	end

	assert(has_quarto or has_markdown, "Quarto filetypes not configured")
	assert(plugin.lazy == true, "Quarto plugin not set to lazy load")

	-- Check for dependencies
	local otter_plugin = config.plugins["otter.nvim"]
	assert(otter_plugin ~= nil, "Otter.nvim dependency not configured")

	-- Verify opts configuration
	if plugin.opts then
		assert(plugin.opts.lspFeatures, "LSP features not configured")
		assert(plugin.opts.codeRunner, "Code runner not configured")
	end

	-- Verify config function exists
	assert(plugin.config ~= nil, "Quarto plugin config function not defined")

	print("✓ Quarto plugin configuration verified")
	return true
end

-- Run test
local success = test_quarto_plugin()
vim.cmd("qa!")
os.exit(success and 0 or 1)
