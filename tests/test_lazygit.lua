-- BONSAI LazyGit plugin tests
local function test_lazygit()
	local passed = 0
	local failed = 0

	print("=== LazyGit Plugin Tests ===\n")

	-- Test 1: Check if plugin is loaded
	local has_lazygit = pcall(require, "lazygit")
	if has_lazygit then
		print("✓ LazyGit module loaded")
		passed = passed + 1
	else
		print("✗ LazyGit module not loaded")
		failed = failed + 1
	end

	-- Test 2: Check LazyGit command
	if vim.fn.exists(":LazyGit") == 2 then
		print("✓ LazyGit command available")
		passed = passed + 1
	else
		print("✗ LazyGit command not available")
		failed = failed + 1
	end

	-- Test 3: Check LazyGitConfig command
	if vim.fn.exists(":LazyGitConfig") == 2 then
		print("✓ LazyGitConfig command available")
		passed = passed + 1
	else
		print("✗ LazyGitConfig command not available")
		failed = failed + 1
	end

	-- Test 4: Check LazyGitCurrentFile command
	if vim.fn.exists(":LazyGitCurrentFile") == 2 then
		print("✓ LazyGitCurrentFile command available")
		passed = passed + 1
	else
		print("✗ LazyGitCurrentFile command not available")
		failed = failed + 1
	end

	-- Test 5: Check LazyGitFilter command
	if vim.fn.exists(":LazyGitFilter") == 2 then
		print("✓ LazyGitFilter command available")
		passed = passed + 1
	else
		print("✗ LazyGitFilter command not available")
		failed = failed + 1
	end

	-- Test 6: Check LazyGitFilterCurrentFile command
	if vim.fn.exists(":LazyGitFilterCurrentFile") == 2 then
		print("✓ LazyGitFilterCurrentFile command available")
		passed = passed + 1
	else
		print("✗ LazyGitFilterCurrentFile command not available")
		failed = failed + 1
	end

	-- Test 7: Check <leader>gg keymapping
	local keymaps = vim.api.nvim_get_keymap("n")
	local has_gg = false
	for _, map in ipairs(keymaps) do
		if map.lhs == " gg" then -- space is leader
			has_gg = true
			break
		end
	end
	if has_gg then
		print("✓ <leader>gg keymapping configured")
		passed = passed + 1
	else
		print("✗ <leader>gg keymapping not found")
		failed = failed + 1
	end

	-- Test 8: Check <leader>gf keymapping
	local has_gf = false
	for _, map in ipairs(keymaps) do
		if map.lhs == " gf" then
			has_gf = true
			break
		end
	end
	if has_gf then
		print("✓ <leader>gf keymapping configured")
		passed = passed + 1
	else
		print("✗ <leader>gf keymapping not found")
		failed = failed + 1
	end

	-- Test 9: Check <leader>gF keymapping
	local has_gF = false
	for _, map in ipairs(keymaps) do
		if map.lhs == " gF" then
			has_gF = true
			break
		end
	end
	if has_gF then
		print("✓ <leader>gF keymapping configured")
		passed = passed + 1
	else
		print("✗ <leader>gF keymapping not found")
		failed = failed + 1
	end

	-- Test 10: Check window configuration
	local window_config_ok = true
	if vim.g.lazygit_floating_window_winblend ~= 0 then
		window_config_ok = false
	end
	if vim.g.lazygit_floating_window_scaling_factor ~= 0.9 then
		window_config_ok = false
	end
	if window_config_ok then
		print("✓ Window configuration correct (90% size, no transparency)")
		passed = passed + 1
	else
		print("✗ Window configuration incorrect")
		failed = failed + 1
	end

	-- Test 11: Check border configuration
	if vim.g.lazygit_floating_window_border_chars then
		print("✓ Custom border characters configured")
		passed = passed + 1
	else
		print("✗ Custom border characters not configured")
		failed = failed + 1
	end

	-- Test 12: Check neovim remote configuration
	if vim.g.lazygit_use_neovim_remote == 1 then
		print("✓ Neovim remote integration enabled")
		passed = passed + 1
	else
		print("✗ Neovim remote integration not enabled")
		failed = failed + 1
	end

	-- Test 13: Check gitsigns integration (auto-refresh setup)
	local has_autocmd = false
	local autocmds = vim.api.nvim_get_autocmds({ group = "lazygit_gitsigns_refresh" })
	if #autocmds > 0 then
		has_autocmd = true
	end
	if has_autocmd then
		print("✓ Gitsigns auto-refresh autocmd configured")
		passed = passed + 1
	else
		print("✗ Gitsigns auto-refresh autocmd not found")
		failed = failed + 1
	end

	-- Test 14: Check LazyGitOpen user autocmd
	local has_open_autocmd = false
	local user_autocmds = vim.api.nvim_get_autocmds({ event = "User", pattern = "LazyGitOpen" })
	if #user_autocmds > 0 then
		has_open_autocmd = true
	end
	if has_open_autocmd then
		print("✓ LazyGitOpen user autocmd configured")
		passed = passed + 1
	else
		print("✗ LazyGitOpen user autocmd not found")
		failed = failed + 1
	end

	print("\n=== Summary ===")
	print("Passed: " .. passed)
	print("Failed: " .. failed)
	print("Total: " .. (passed + failed))

	-- Write results to file
	local f = io.open("tests/results/lazygit_test_results.txt", "w")
	if f then
		f:write("LazyGit Test Results\n")
		f:write("===================\n")
		f:write("Passed: " .. passed .. "\n")
		f:write("Failed: " .. failed .. "\n")
		f:write("Total: " .. (passed + failed) .. "\n")
		f:close()
	end

	return failed == 0
end

-- Run the tests
local success = test_lazygit()

if success then
	vim.cmd("qa")
else
	vim.cmd("cq")
end
