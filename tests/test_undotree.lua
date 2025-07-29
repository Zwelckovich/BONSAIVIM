-- Test undotree plugin functionality
local function test_undotree()
  print("\n=== Testing Undotree ===\n")
  
  local tests_passed = 0
  local tests_failed = 0
  
  -- Test 1: Check if undotree command exists
  local ok, err = pcall(function()
    local cmd_exists = vim.fn.exists(":UndotreeToggle") > 0
    assert(cmd_exists, "UndotreeToggle command not found")
  end)
  
  if ok then
    print("✓ UndotreeToggle command exists")
    tests_passed = tests_passed + 1
  else
    print("✗ UndotreeToggle command not found: " .. tostring(err))
    tests_failed = tests_failed + 1
  end
  
  -- Test 2: Check undotree settings
  local settings_ok = true
  local expected_settings = {
    { name = "undotree_WindowLayout", expected = 4 },
    { name = "undotree_SplitWidth", expected = 40 },
    { name = "undotree_SetFocusWhenToggle", expected = 1 },
    { name = "undotree_DiffAutoOpen", expected = 1 },
    { name = "undotree_RelativeTimestamp", expected = 1 },
    { name = "undotree_ShortIndicators", expected = 1 },
    { name = "undotree_HelpLine", expected = 1 },
  }
  
  for _, setting in ipairs(expected_settings) do
    local value = vim.g[setting.name]
    if value ~= setting.expected then
      print(string.format("✗ %s: expected %s, got %s", setting.name, tostring(setting.expected), tostring(value)))
      settings_ok = false
      tests_failed = tests_failed + 1
    else
      print(string.format("✓ %s = %s", setting.name, tostring(value)))
      tests_passed = tests_passed + 1
    end
  end
  
  -- Test 3: Check persistent undo settings
  if vim.fn.has("persistent_undo") == 1 then
    local undo_enabled = vim.o.undofile
    if undo_enabled then
      print("✓ Persistent undo enabled")
      tests_passed = tests_passed + 1
    else
      print("✗ Persistent undo not enabled")
      tests_failed = tests_failed + 1
    end
    
    local undo_dir = vim.o.undodir
    if undo_dir and undo_dir:match("%.cache/nvim/undo") then
      print("✓ Undo directory configured: " .. undo_dir)
      tests_passed = tests_passed + 1
    else
      print("✗ Undo directory not properly configured: " .. tostring(undo_dir))
      tests_failed = tests_failed + 1
    end
  else
    print("⚠ Persistent undo not supported in this Neovim build")
  end
  
  -- Test 4: Check <leader>u keymap
  local keymap_ok = false
  local keymaps = vim.api.nvim_get_keymap('n')
  for _, map in ipairs(keymaps) do
    if map.lhs == ' u' then -- space is the leader key
      keymap_ok = true
      break
    end
  end
  
  if keymap_ok then
    print("✓ <leader>u keymap registered")
    tests_passed = tests_passed + 1
  else
    print("✗ <leader>u keymap not found")
    tests_failed = tests_failed + 1
  end
  
  -- Summary
  print("\n=== Undotree Test Summary ===")
  print("Passed: " .. tests_passed)
  print("Failed: " .. tests_failed)
  print("Total: " .. (tests_passed + tests_failed))
  
  return tests_failed == 0
end

-- Run the tests
local success = test_undotree()

-- Exit with appropriate code
if success then
  vim.cmd("qa!")
else
  vim.cmd("cq")
end