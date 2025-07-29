-- Test markdown-preview.nvim functionality
-- Wait for plugins to load
vim.wait(2000)

-- Force load markdown-preview plugin since it's lazy loaded on ft
local lazy = require("lazy")
lazy.load({ plugins = { "markdown-preview.nvim" } })

-- Additional wait for plugin to fully load
vim.wait(1000)

local function test_markdown_preview()
	print("=== markdown-preview.nvim Tests ===\n")

	local passed = 0
	local failed = 0

	-- Test 1: Check if commands exist
	if vim.fn.exists(":MarkdownPreview") == 2 then
		print("✓ MarkdownPreview command exists")
		passed = passed + 1
	else
		print("✗ MarkdownPreview command not found")
		failed = failed + 1
	end

	if vim.fn.exists(":MarkdownPreviewToggle") == 2 then
		print("✓ MarkdownPreviewToggle command exists")
		passed = passed + 1
	else
		print("✗ MarkdownPreviewToggle command not found")
		failed = failed + 1
	end

	if vim.fn.exists(":MarkdownPreviewStop") == 2 then
		print("✓ MarkdownPreviewStop command exists")
		passed = passed + 1
	else
		print("✗ MarkdownPreviewStop command not found")
		failed = failed + 1
	end

	-- Test 2: Check configuration variables
	if vim.g.mkdp_auto_start == 0 then
		print("✓ Auto-start disabled as configured")
		passed = passed + 1
	else
		print("✗ Auto-start configuration incorrect")
		failed = failed + 1
	end

	if vim.g.mkdp_auto_close == 1 then
		print("✓ Auto-close enabled as configured")
		passed = passed + 1
	else
		print("✗ Auto-close configuration incorrect")
		failed = failed + 1
	end

	-- Test 3: Check preview options
	if vim.g.mkdp_preview_options and vim.g.mkdp_preview_options.disable_sync_scroll == 0 then
		print("✓ Synchronized scrolling enabled")
		passed = passed + 1
	else
		print("✗ Synchronized scrolling not configured")
		failed = failed + 1
	end

	if vim.g.mkdp_preview_options and vim.g.mkdp_preview_options.sync_scroll_type == "middle" then
		print("✓ Sync scroll type set to 'middle'")
		passed = passed + 1
	else
		print("✗ Sync scroll type not configured correctly")
		failed = failed + 1
	end

	-- Test 4: Check keymapping
	local mp_map = vim.fn.mapcheck("<leader>mp", "n")
	if mp_map ~= "" then
		print("✓ <leader>mp keymapping is set")
		passed = passed + 1
	else
		print("✗ <leader>mp keymapping not found")
		failed = failed + 1
	end

	-- Test 5: Check filetype restriction
	if vim.g.mkdp_filetypes and vim.tbl_contains(vim.g.mkdp_filetypes, "markdown") then
		print("✓ Restricted to markdown files only")
		passed = passed + 1
	else
		print("✗ Filetype restriction not configured")
		failed = failed + 1
	end

	-- Test 6: Check theme configuration
	if vim.g.mkdp_theme == "dark" then
		print("✓ Dark theme configured")
		passed = passed + 1
	else
		print("✗ Dark theme not configured")
		failed = failed + 1
	end

	-- Test 7: Check custom BONSAI CSS theme
	if vim.g.mkdp_theme_css and string.find(vim.g.mkdp_theme_css, "BONSAI Dark Theme") then
		print("✓ Custom BONSAI CSS theme configured")
		passed = passed + 1
	else
		print("✗ Custom BONSAI CSS theme not configured")
		failed = failed + 1
	end

	print("\n=== Summary ===")
	print("Passed: " .. passed)
	print("Failed: " .. failed)
	print("Total: " .. (passed + failed))

	return failed == 0
end

-- Run tests
local success = test_markdown_preview()

-- Write results
local f = io.open("tests/results/markdown_preview_test_results.txt", "w")
if f then
	f:write(success and "SUCCESS" or "FAILURE")
	f:close()
end

-- Exit
vim.cmd(success and "qa!" or "cq!")


