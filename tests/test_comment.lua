-- BONSAI Comment.nvim plugin tests
local function test_comment()
	local passed = 0
	local failed = 0

	print("=== Comment.nvim Plugin Tests ===\n")

	-- Test 1: Check if plugin is loaded
	local has_comment = pcall(require, "Comment")
	if has_comment then
		print("✓ Comment module loaded")
		passed = passed + 1
	else
		print("✗ Comment module not loaded")
		failed = failed + 1
	end

	-- Test 2: Check if ts-context-commentstring is loaded
	local has_ts_context = pcall(require, "ts_context_commentstring")
	if has_ts_context then
		print("✓ TS context commentstring loaded")
		passed = passed + 1
	else
		print("✗ TS context commentstring not loaded")
		failed = failed + 1
	end

	-- Test 3: Check if Comment API is available
	local has_api = pcall(require, "Comment.api")
	if has_api then
		print("✓ Comment API available")
		passed = passed + 1
	else
		print("✗ Comment API not available")
		failed = failed + 1
	end

	-- Test 4: Check gcc keymap (line comment)
	local keymaps = vim.api.nvim_get_keymap("n")
	local has_gcc = false
	for _, map in ipairs(keymaps) do
		if map.lhs == "gcc" then
			has_gcc = true
			break
		end
	end
	if has_gcc then
		print("✓ gcc keymap configured")
		passed = passed + 1
	else
		print("✗ gcc keymap not found")
		failed = failed + 1
	end

	-- Test 5: Check gc operator (motion comment)
	local has_gc = false
	local op_keymaps = vim.api.nvim_get_keymap("n")
	for _, map in ipairs(op_keymaps) do
		if map.lhs == "gc" then
			has_gc = true
			break
		end
	end
	if has_gc then
		print("✓ gc operator configured")
		passed = passed + 1
	else
		print("✗ gc operator not found")
		failed = failed + 1
	end

	-- Test 6: Check gb operator (block comment)
	local has_gb = false
	for _, map in ipairs(keymaps) do
		if map.lhs == "gb" then
			has_gb = true
			break
		end
	end
	if has_gb then
		print("✓ gb operator configured")
		passed = passed + 1
	else
		print("✗ gb operator not found")
		failed = failed + 1
	end

	-- Test 7: Check gco keymap (comment below)
	local has_gco = false
	for _, map in ipairs(keymaps) do
		if map.lhs == "gco" then
			has_gco = true
			break
		end
	end
	if has_gco then
		print("✓ gco keymap configured")
		passed = passed + 1
	else
		print("✗ gco keymap not found")
		failed = failed + 1
	end

	-- Test 8: Check gcO keymap (comment above)
	local has_gcO = false
	for _, map in ipairs(keymaps) do
		if map.lhs == "gcO" then
			has_gcO = true
			break
		end
	end
	if has_gcO then
		print("✓ gcO keymap configured")
		passed = passed + 1
	else
		print("✗ gcO keymap not found")
		failed = failed + 1
	end

	-- Test 9: Check gcA keymap (comment at end of line)
	local has_gcA = false
	for _, map in ipairs(keymaps) do
		if map.lhs == "gcA" then
			has_gcA = true
			break
		end
	end
	if has_gcA then
		print("✓ gcA keymap configured")
		passed = passed + 1
	else
		print("✗ gcA keymap not found")
		failed = failed + 1
	end

	-- Test 10: Check <leader>c/ keymap
	local has_leader_c = false
	for _, map in ipairs(keymaps) do
		if map.lhs == " c/" then -- space is leader
			has_leader_c = true
			break
		end
	end
	if has_leader_c then
		print("✓ <leader>c/ keymap configured")
		passed = passed + 1
	else
		print("✗ <leader>c/ keymap not found")
		failed = failed + 1
	end

	-- Test 11: Check visual mode mappings
	local v_keymaps = vim.api.nvim_get_keymap("v")
	local has_v_gc = false
	for _, map in ipairs(v_keymaps) do
		if map.lhs == "gc" then
			has_v_gc = true
			break
		end
	end
	if has_v_gc then
		print("✓ Visual mode gc mapping configured")
		passed = passed + 1
	else
		print("✗ Visual mode gc mapping not found")
		failed = failed + 1
	end

	-- Test 12: Check Comment configuration
	local comment_ok, comment_config = pcall(require, "Comment.config")
	if comment_ok and comment_config then
		print("✓ Comment configuration loaded")
		passed = passed + 1
	else
		print("✗ Comment configuration not loaded")
		failed = failed + 1
	end

	print("\n=== Summary ===")
	print("Passed: " .. passed)
	print("Failed: " .. failed)
	print("Total: " .. (passed + failed))

	-- Write results to file
	local f = io.open("tests/results/comment_test_results.txt", "w")
	if f then
		f:write("Comment.nvim Test Results\n")
		f:write("========================\n")
		f:write("Passed: " .. passed .. "\n")
		f:write("Failed: " .. failed .. "\n")
		f:write("Total: " .. (passed + failed) .. "\n")
		f:close()
	end

	return failed == 0
end

-- Run the tests
local success = test_comment()

if success then
	vim.cmd("qa")
else
	vim.cmd("cq")
end
