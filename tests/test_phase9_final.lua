-- Comprehensive Phase 9 Tests
-- Tests colorscheme and final optimizations

local test_results = {
  passed = 0,
  failed = 0,
  tests = {}
}

local function assert_equals(actual, expected, test_name)
  if actual == expected then
    test_results.passed = test_results.passed + 1
    table.insert(test_results.tests, {name = test_name, status = "PASSED"})
    return true
  else
    test_results.failed = test_results.failed + 1
    table.insert(test_results.tests, {
      name = test_name,
      status = "FAILED",
      error = string.format("Expected %s, got %s", vim.inspect(expected), vim.inspect(actual))
    })
    return false
  end
end

-- Test Suite 1: Colorscheme Tests
print("🧪 Testing BONSAI Colorscheme...")
local ok = pcall(dofile, vim.fn.stdpath("config") .. "/tests/test_colorscheme.lua")
if not ok then
  test_results.failed = test_results.failed + 1
  table.insert(test_results.tests, {
    name = "Colorscheme test suite",
    status = "FAILED",
    error = "Failed to run colorscheme tests"
  })
else
  test_results.passed = test_results.passed + 1
  table.insert(test_results.tests, {name = "Colorscheme test suite", status = "PASSED"})
end

-- Test Suite 2: Autocommands Tests
print("\n🧪 Testing Autocommands...")
ok = pcall(dofile, vim.fn.stdpath("config") .. "/tests/test_autocommands.lua")
if not ok then
  test_results.failed = test_results.failed + 1
  table.insert(test_results.tests, {
    name = "Autocommands test suite",
    status = "FAILED",
    error = "Failed to run autocommands tests"
  })
else
  test_results.passed = test_results.passed + 1
  table.insert(test_results.tests, {name = "Autocommands test suite", status = "PASSED"})
end

-- Test 3: Verify all files exist
local function test_phase9_files()
  local files = {
    "lua/bonsai/colors.lua",
    "lua/config/autocommands.lua"
  }
  
  local all_exist = true
  for _, file in ipairs(files) do
    local full_path = vim.fn.stdpath("config") .. "/" .. file
    if vim.fn.filereadable(full_path) ~= 1 then
      all_exist = false
      assert_equals(1, 0, "File exists: " .. file)
    else
      assert_equals(1, 1, "File exists: " .. file)
    end
  end
  
  return all_exist
end

print("\n🧪 Testing Phase 9 file structure...")
test_phase9_files()

-- Test 4: Performance validation
local function test_performance()
  -- This would be tested by the shell script
  -- Here we just verify the autocommands are set up
  local perf_cmds = vim.api.nvim_get_autocmds({ group = "BonsaiPerformance" })
  assert_equals(#perf_cmds > 0, true, "Performance autocommands configured")
end

print("\n🧪 Testing performance optimizations...")
test_performance()

-- Final Summary
print("\n" .. string.rep("=", 50))
print("📊 Phase 9 Test Summary")
print(string.rep("=", 50))
print(string.format("✅ Passed: %d", test_results.passed))
print(string.format("❌ Failed: %d", test_results.failed))
print(string.format("📋 Total:  %d", test_results.passed + test_results.failed))

-- Print failed tests
if test_results.failed > 0 then
  print("\n❌ Failed Tests:")
  for _, test in ipairs(test_results.tests) do
    if test.status == "FAILED" then
      print(string.format("  - %s: %s", test.name, test.error))
    end
  end
  vim.cmd("cquit 1")
else
  print("\n✅ All Phase 9 tests passed!")
  vim.cmd("quit")
end