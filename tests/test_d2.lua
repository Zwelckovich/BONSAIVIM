-- Test for d2 plugin configuration
-- Tests that d2.vim plugin is properly configured

local function test_d2_plugin()
	-- Test that plugin spec exists
	local config = require("lazy.core.config")
	local plugin = config.plugins["d2-vim"]

	if not plugin then
		print("✗ D2 plugin not found in lazy.nvim config")
		return false
	end

	-- Verify basic configuration
	local ft = plugin.ft
	if type(ft) == "string" then
		assert(ft == "d2", "D2 filetype not configured")
	elseif type(ft) == "table" then
		assert(vim.tbl_contains(ft, "d2"), "D2 filetype not configured")
	end
	assert(plugin.lazy == true, "D2 plugin not set to lazy load")

	-- Verify config function exists
	assert(plugin.config ~= nil, "D2 plugin config function not defined")

	print("✓ D2 plugin configuration verified")
	return true
end

-- Run test
local success = test_d2_plugin()
vim.cmd("qa!")
os.exit(success and 0 or 1)
