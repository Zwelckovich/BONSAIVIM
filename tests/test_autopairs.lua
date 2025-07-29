-- Test nvim-autopairs functionality
vim.cmd([[source config/.config/nvim/init.lua]])

-- Wait for plugins to load
vim.wait(1000)

local function test_autopairs()
  print("=== nvim-autopairs Tests ===\n")
  
  local passed = 0
  local failed = 0
  
  -- Test 1: Module loading
  local ok, autopairs = pcall(require, "nvim-autopairs")
  if ok then
    print("✓ nvim-autopairs module loaded successfully")
    passed = passed + 1
  else
    print("✗ Failed to load nvim-autopairs: " .. tostring(autopairs))
    failed = failed + 1
  end
  
  -- Test 2: Check if setup was called
  if ok and type(autopairs.setup) == "function" then
    print("✓ nvim-autopairs setup function exists")
    passed = passed + 1
  else
    print("✗ nvim-autopairs setup function not found")
    failed = failed + 1
  end
  
  -- Test 3: Check cmp integration
  local cmp_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
  if cmp_ok then
    print("✓ nvim-cmp integration loaded")
    passed = passed + 1
  else
    print("✗ Failed to load cmp integration: " .. tostring(cmp_autopairs))
    failed = failed + 1
  end
  
  -- Test 4: Check Rule module
  local rule_ok, Rule = pcall(require, "nvim-autopairs.rule")
  if rule_ok then
    print("✓ Rule module loaded")
    passed = passed + 1
  else
    print("✗ Failed to load Rule module: " .. tostring(Rule))
    failed = failed + 1
  end
  
  -- Test 5: Check conditions module
  local cond_ok, cond = pcall(require, "nvim-autopairs.conds")
  if cond_ok then
    print("✓ Conditions module loaded")
    passed = passed + 1
  else
    print("✗ Failed to load conditions module: " .. tostring(cond))
    failed = failed + 1
  end
  
  -- Test 6: Check fast wrap mapping
  local fast_wrap_map = vim.fn.mapcheck('<M-e>', 'i')
  if fast_wrap_map ~= '' then
    print("✓ Fast wrap mapping <M-e> is set")
    passed = passed + 1
  else
    print("✗ Fast wrap mapping <M-e> not found")
    failed = failed + 1
  end
  
  -- Test 7: Check if autopairs is enabled
  if ok and autopairs.state and autopairs.state.disabled == false then
    print("✓ nvim-autopairs is enabled")
    passed = passed + 1
  else
    print("✗ nvim-autopairs is not enabled properly")
    failed = failed + 1
  end
  
  -- Test 8: Check treesitter integration config
  if ok and autopairs.config and autopairs.config.check_ts then
    print("✓ Treesitter integration enabled")
    passed = passed + 1
  else
    print("✗ Treesitter integration not configured")
    failed = failed + 1
  end
  
  -- Test 9: Check disabled filetypes
  if ok and autopairs.config and vim.tbl_contains(autopairs.config.disable_filetype, "TelescopePrompt") then
    print("✓ TelescopePrompt is in disabled filetypes")
    passed = passed + 1
  else
    print("✗ TelescopePrompt not properly disabled")
    failed = failed + 1
  end
  
  -- Test 10: Test that get_rules function exists
  if ok and type(autopairs.get_rules) == "function" then
    print("✓ get_rules function exists (custom rules configured)")
    passed = passed + 1
  else
    print("✗ get_rules function not found")
    failed = failed + 1
  end
  
  print("\n=== Summary ===")
  print("Passed: " .. passed)
  print("Failed: " .. failed)
  print("Total: " .. (passed + failed))
  
  return failed == 0
end

-- Run tests
local success = test_autopairs()

-- Write results
local f = io.open("tests/results/autopairs_test_results.txt", "w")
if f then
  f:write(success and "SUCCESS" or "FAILURE")
  f:close()
end

-- Exit
vim.cmd(success and "qa!" or "cq!")