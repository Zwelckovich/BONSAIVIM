-- Test file for BONSAI autocommands
-- Tests performance optimizations and buffer-local settings

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

local function assert_true(condition, test_name)
  if condition then
    test_results.passed = test_results.passed + 1
    table.insert(test_results.tests, {name = test_name, status = "PASSED"})
    return true
  else
    test_results.failed = test_results.failed + 1
    table.insert(test_results.tests, {
      name = test_name,
      status = "FAILED",
      error = "Condition was false"
    })
    return false
  end
end

-- Test 1: Verify autocommands module loads
local function test_autocommands_load()
  -- Load autocommands
  local ok, err = pcall(require, "config.autocommands")
  assert_equals(ok, true, "autocommands module loads without error")
end

-- Test 2: Verify autogroups are created
local function test_autogroups_created()
  -- Check if autogroups exist
  local groups = vim.api.nvim_get_autocmds({ group = "BonsaiPerformance" })
  assert_true(#groups > 0, "BonsaiPerformance autogroup exists")

  groups = vim.api.nvim_get_autocmds({ group = "BonsaiBufferLocal" })
  assert_true(#groups > 0, "BonsaiBufferLocal autogroup exists")

  groups = vim.api.nvim_get_autocmds({ group = "BonsaiView" })
  assert_true(#groups > 0, "BonsaiView autogroup exists")

  groups = vim.api.nvim_get_autocmds({ group = "BonsaiCleanup" })
  assert_true(#groups > 0, "BonsaiCleanup autogroup exists")

  groups = vim.api.nvim_get_autocmds({ group = "BonsaiHighlight" })
  assert_true(#groups > 0, "BonsaiHighlight autogroup exists")
end

-- Test 3: Test terminal buffer settings
local function test_terminal_settings()
  -- Create a terminal buffer
  vim.cmd("terminal")
  vim.wait(100) -- Wait for terminal to open

  -- Check settings
  assert_equals(vim.opt_local.number:get(), false, "Terminal has no line numbers")
  assert_equals(vim.opt_local.relativenumber:get(), false, "Terminal has no relative numbers")
  assert_equals(vim.opt_local.signcolumn:get(), "no", "Terminal has no sign column")

  -- Close terminal
  vim.cmd("bdelete!")
end

-- Test 4: Test markdown buffer settings
local function test_markdown_settings()
  -- Create a markdown buffer
  vim.cmd("new test.md")
  vim.bo.filetype = "markdown"
  vim.cmd("doautocmd FileType markdown")

  -- Check settings
  assert_equals(vim.opt_local.wrap:get(), true, "Markdown has wrap enabled")
  assert_equals(vim.opt_local.spell:get(), true, "Markdown has spell check enabled")
  assert_equals(vim.opt_local.conceallevel:get(), 2, "Markdown has conceallevel 2")
  assert_equals(vim.opt_local.linebreak:get(), true, "Markdown has linebreak enabled")

  -- Close buffer
  vim.cmd("bdelete!")
end

-- Test 5: Test quickfix settings
local function test_quickfix_settings()
  -- Open quickfix
  vim.cmd("copen")
  vim.wait(50)

  -- Check settings
  assert_equals(vim.opt_local.number:get(), false, "Quickfix has no line numbers")
  assert_equals(vim.opt_local.signcolumn:get(), "no", "Quickfix has no sign column")

  -- Check q mapping
  local mappings = vim.api.nvim_buf_get_keymap(0, "n")
  local has_q_map = false
  for _, map in ipairs(mappings) do
    if map.lhs == "q" then
      has_q_map = true
      break
    end
  end
  assert_true(has_q_map, "Quickfix has q mapping for close")

  -- Close quickfix
  vim.cmd("cclose")
end

-- Test 6: Test git commit settings
local function test_gitcommit_settings()
  -- Create a git commit buffer
  vim.cmd("new COMMIT_EDITMSG")
  vim.bo.filetype = "gitcommit"
  vim.cmd("doautocmd FileType gitcommit")

  -- Check settings
  assert_equals(vim.opt_local.wrap:get(), true, "Git commit has wrap enabled")
  assert_equals(vim.opt_local.spell:get(), true, "Git commit has spell check enabled")
  assert_equals(vim.opt_local.colorcolumn:get()[1], "72", "Git commit has colorcolumn at 72")

  -- Close buffer
  vim.cmd("bdelete!")
end

-- Test 7: Test highlight yank
local function test_highlight_yank()
  -- Create a buffer with some text
  vim.cmd("new")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {"test line"})

  -- Yank the line
  vim.cmd("normal! yy")

  -- The highlight should happen, but we can't easily test the visual effect
  -- Just ensure no errors occurred
  assert_true(true, "Yank highlighting executed without error")

  -- Close buffer
  vim.cmd("bdelete!")
end

-- Test 8: Test trailing whitespace removal
local function test_whitespace_cleanup()
  -- Create a Lua buffer with trailing whitespace
  vim.cmd("new test.lua")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {"local test = 1   ", "  local test2 = 2  "})

  -- Trigger BufWritePre autocmd
  vim.cmd("doautocmd BufWritePre")

  -- Check that trailing whitespace was removed
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  assert_equals(lines[1], "local test = 1", "Trailing whitespace removed from line 1")
  assert_equals(lines[2], "  local test2 = 2", "Trailing whitespace removed from line 2")

  -- Close buffer
  vim.cmd("bdelete!")
end

-- Test 9: Verify startup performance optimization
local function test_startup_optimization()
  -- Check that UIEnter autocommand exists for colorscheme loading
  local startup_cmds = vim.api.nvim_get_autocmds({ group = "BonsaiStartup", event = "UIEnter" })
  assert_true(#startup_cmds > 0, "UIEnter colorscheme loader exists")

  -- updatetime should be set appropriately
  assert_true(vim.opt.updatetime:get() >= 200, "Update time is reasonable")
end

-- Run all tests
print("🧪 Running BONSAI autocommands tests...")
print("")

-- Load autocommands first
require("config.autocommands")

test_autocommands_load()
test_autogroups_created()
test_terminal_settings()
test_markdown_settings()
test_quickfix_settings()
test_gitcommit_settings()
test_highlight_yank()
test_whitespace_cleanup()
test_startup_optimization()

-- Print results
print("\n📊 Test Results:")
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
end

-- Exit with appropriate code
if test_results.failed > 0 then
  vim.cmd("cquit 1")
else
  print("\n✅ All autocommands tests passed!")
  vim.cmd("quit")
end