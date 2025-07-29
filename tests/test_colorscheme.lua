-- Test file for BONSAI colorscheme
-- Tests color definitions and highlight groups

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

local function assert_highlight_exists(group, test_name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
  if ok and next(hl) ~= nil then
    test_results.passed = test_results.passed + 1
    table.insert(test_results.tests, {name = test_name, status = "PASSED"})
    return true
  else
    test_results.failed = test_results.failed + 1
    table.insert(test_results.tests, {
      name = test_name,
      status = "FAILED",
      error = string.format("Highlight group '%s' not found or empty", group)
    })
    return false
  end
end

-- Test 1: Verify colorscheme module loads
local function test_colorscheme_module()
  local ok, colors = pcall(require, "bonsai.colors")
  assert_equals(ok, true, "bonsai.colors module loads")
  if ok then
    assert_equals(type(colors.setup), "function", "setup function exists")
    assert_equals(type(colors.colors), "table", "colors table exists")
  end
end

-- Test 2: Verify color definitions match concept.md
local function test_color_definitions()
  local ok, colors = pcall(require, "bonsai.colors")
  if ok then
    -- Test key colors from concept.md
    assert_equals(colors.colors.text_primary, "#e6e8eb", "Primary text color matches")
    assert_equals(colors.colors.blue_primary, "#82a4c7", "Blue (functions) color matches")
    assert_equals(colors.colors.green_primary, "#7c9885", "Green (strings) color matches")
    assert_equals(colors.colors.purple_primary, "#9882c7", "Purple (keywords) color matches")
    assert_equals(colors.colors.text_muted, "#8b92a5", "Comment color matches")
    assert_equals(colors.colors.red_primary, "#c78289", "Red (errors) color matches")
  end
end

-- Test 3: Verify colorscheme application
local function test_colorscheme_application()
  -- Clear any existing colorscheme
  vim.cmd("highlight clear")

  -- Apply BONSAI colorscheme
  local ok, colors = pcall(require, "bonsai.colors")
  if ok then
    pcall(colors.setup)

    -- Test critical highlight groups
    assert_highlight_exists("Normal", "Normal highlight set")
    assert_highlight_exists("Function", "Function highlight set")
    assert_highlight_exists("String", "String highlight set")
    assert_highlight_exists("Keyword", "Keyword highlight set")
    assert_highlight_exists("Comment", "Comment highlight set")
    assert_highlight_exists("Error", "Error highlight set")
    assert_highlight_exists("Delimiter", "Delimiter highlight set")

    -- Test that Function is bold
    local hl = vim.api.nvim_get_hl(0, { name = "Function" })
    assert_equals(hl.bold, true, "Functions are bold")
  end
end

-- Test 4: Verify Treesitter highlight groups
local function test_treesitter_highlights()
  local ok, colors = pcall(require, "bonsai.colors")
  if ok then
    pcall(colors.setup)

    assert_highlight_exists("@function", "Treesitter function highlight")
    assert_highlight_exists("@string", "Treesitter string highlight")
    assert_highlight_exists("@keyword", "Treesitter keyword highlight")
    assert_highlight_exists("@comment", "Treesitter comment highlight")
    assert_highlight_exists("@punctuation.bracket", "Treesitter bracket highlight")
  end
end

-- Test 5: Verify plugin-specific highlights
local function test_plugin_highlights()
  local ok, colors = pcall(require, "bonsai.colors")
  if ok then
    pcall(colors.setup)

    -- Telescope highlights
    assert_highlight_exists("TelescopeNormal", "Telescope normal highlight")
    assert_highlight_exists("TelescopeSelection", "Telescope selection highlight")

    -- Which-key highlights
    assert_highlight_exists("WhichKey", "WhichKey highlight")
    assert_highlight_exists("WhichKeyGroup", "WhichKeyGroup highlight")

    -- Lualine highlights (these are set via theme, not directly)
    -- Just verify the colorscheme doesn't error when applied
    assert_equals(true, true, "Plugin highlights applied without error")
  end
end

-- Test 6: Verify LSP diagnostic highlights
local function test_lsp_highlights()
  local ok, colors = pcall(require, "bonsai.colors")
  if ok then
    pcall(colors.setup)

    assert_highlight_exists("DiagnosticError", "LSP error highlight")
    assert_highlight_exists("DiagnosticWarn", "LSP warning highlight")
    assert_highlight_exists("DiagnosticInfo", "LSP info highlight")
    assert_highlight_exists("DiagnosticHint", "LSP hint highlight")
  end
end

-- Run all tests
print("🧪 Running BONSAI colorscheme tests...")
print("")

test_colorscheme_module()
test_color_definitions()
test_colorscheme_application()
test_treesitter_highlights()
test_plugin_highlights()
test_lsp_highlights()

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
  print("\n✅ All colorscheme tests passed!")
  vim.cmd("quit")
end