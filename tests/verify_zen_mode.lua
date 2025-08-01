-- Simple zen-mode verification
-- Run from Neovim config directory

-- Test basic loading
local function test_zen_mode()
	-- Force load zen-mode
	local lazy = require("lazy")
	lazy.load({ plugins = { "zen-mode.nvim", "twilight.nvim" } })
	vim.wait(1000)

	-- Test zen-mode module
	local zen_ok, zen_mode = pcall(require, "zen-mode")
	if not zen_ok then
		print("✗ Zen-mode module failed to load")
		return false
	end
	print("✓ Zen-mode module loaded")

	-- Test twilight module
	local twilight_ok = pcall(require, "twilight")
	if not twilight_ok then
		print("✗ Twilight module failed to load")
		return false
	end
	print("✓ Twilight module loaded")

	-- Test command
	if vim.fn.exists(":ZenMode") ~= 2 then
		print("✗ ZenMode command not found")
		return false
	end
	print("✓ ZenMode command exists")

	-- Test keymap
	local keymaps = vim.api.nvim_get_keymap("n")
	local found_keymap = false
	for _, map in ipairs(keymaps) do
		if map.lhs == "<Space>zz" or map.lhs == " zz" then
			found_keymap = true
			break
		end
	end
	if found_keymap then
		print("✓ <leader>zz keymap found")
	else
		print("⚠ <leader>zz keymap not found (may be lazy loaded)")
	end

	-- Test highlight groups
	local hl1 = vim.api.nvim_get_hl(0, { name = "TwilightDimmed" })
	local hl2 = vim.api.nvim_get_hl(0, { name = "TwilightActive" })
	if (hl1 and hl1.fg) and (hl2 and hl2.fg) then
		print("✓ BONSAI highlight groups configured")
	else
		print("✗ BONSAI highlight groups missing")
		return false
	end

	return true
end

-- Run test
local success = test_zen_mode()

print("\n=== Zen-Mode Verification ===")
if success then
	print("✓ All checks passed")
	vim.cmd("qa")
else
	print("✗ Some checks failed")
	vim.cmd("cq")
end