-- Simple plugin verification script
local function test_plugin(name, module)
	local ok, err = pcall(require, module)
	if ok then
		print("✓ " .. name .. " loaded successfully")
		return true
	else
		print("✗ " .. name .. " failed to load: " .. tostring(err))
		return false
	end
end

print("=== BONSAI Plugin Verification ===\n")

local passed = 0
local failed = 0

-- Test each plugin
if test_plugin("Treesitter", "nvim-treesitter") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Telescope", "telescope") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Flash", "flash") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Which-key", "which-key") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Mason", "mason") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Mason-lspconfig", "mason-lspconfig") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("LSPConfig", "lspconfig") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Conform", "conform") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("LuaSnip", "luasnip") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("nvim-cmp", "cmp") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Gitsigns", "gitsigns") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Lualine", "lualine") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Persistence", "persistence") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Yazi", "yazi") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Spectre", "spectre") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Toggleterm", "toggleterm") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Lazygit", "lazygit") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Comment", "Comment") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Nvim-surround", "nvim-surround") then
	passed = passed + 1
else
	failed = failed + 1
end
if test_plugin("Nvim-autopairs", "nvim-autopairs") then
	passed = passed + 1
else
	failed = failed + 1
end

-- Test markdown-preview.nvim (command-based plugin)
if vim.fn.exists(":MarkdownPreview") == 2 then
	print("✓ Markdown-preview loaded successfully")
	passed = passed + 1
else
	print("✗ Markdown-preview failed to load")
	failed = failed + 1
end

-- Test alpha-nvim
if test_plugin("Alpha", "alpha") then
	passed = passed + 1
else
	failed = failed + 1
end

-- Test render-markdown
if test_plugin("Render-markdown", "render-markdown") then
	passed = passed + 1
else
	failed = failed + 1
end

-- Test zen-mode
if test_plugin("Zen-mode", "zen-mode") then
	passed = passed + 1
else
	failed = failed + 1
end

-- Special test for undotree (Vimscript plugin with lazy loading)
-- Force load undotree first since it's lazy loaded on key press
local lazy = require("lazy")
lazy.load({ plugins = { "undotree" } })
vim.wait(500)

local undotree_ok = vim.fn.exists(":UndotreeToggle") == 2
if undotree_ok then
	print("✓ Undotree loaded successfully")
	passed = passed + 1
else
	print("✗ Undotree failed to load: command not found")
	failed = failed + 1
end

print("\n=== Summary ===")
print("Passed: " .. passed)
print("Failed: " .. failed)
print("Total: " .. (passed + failed))

-- Write results to file
local f = io.open("tests/results/plugin_test_results.txt", "w")
if f then
	f:write("Passed: " .. passed .. "\n")
	f:write("Failed: " .. failed .. "\n")
	f:close()
end

if failed > 0 then
	vim.cmd("cq")
else
	vim.cmd("qa")
end
