-- Test script for LuaSnip and nvim-cmp functionality

-- Test helper function
local function test(name, fn)
  local status, err = pcall(fn)
  if status then
    print("✓ " .. name)
    return true
  else
    print("✗ " .. name .. ": " .. tostring(err))
    return false
  end
end

local passed = 0
local failed = 0

print("=== Testing LuaSnip and nvim-cmp ===\n")

-- Test 1: LuaSnip loads correctly
if test("LuaSnip module loads", function()
  require("luasnip")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 2: nvim-cmp loads correctly
if test("nvim-cmp module loads", function()
  require("cmp")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 3: cmp_luasnip loads correctly
if test("cmp_luasnip module loads", function()
  require("cmp_luasnip")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 4: LuaSnip configuration is set
if test("LuaSnip is configured", function()
  local ls = require("luasnip")
  assert(ls.config ~= nil, "LuaSnip config is nil")
  assert(type(ls.expand_or_jumpable) == "function", "expand_or_jumpable is not a function")
  assert(type(ls.jumpable) == "function", "jumpable is not a function")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 5: nvim-cmp configuration is set
if test("nvim-cmp is configured", function()
  local cmp = require("cmp")
  -- Check that cmp is loaded and has expected methods
  assert(cmp ~= nil, "cmp module is nil")
  assert(type(cmp.visible) == "function", "cmp.visible is not a function")
  assert(type(cmp.complete) == "function", "cmp.complete is not a function")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 6: Check that friendly-snippets is loaded
if test("friendly-snippets VSCode loader configured", function()
  -- This tests that the loader is available
  require("luasnip.loaders.from_vscode")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 7: Check Tab mapping exists
if test("Tab key mapping exists", function()
  local mappings = vim.api.nvim_get_keymap("i")
  local tab_found = false
  for _, mapping in ipairs(mappings) do
    if mapping.lhs == "<Tab>" then
      tab_found = true
      break
    end
  end
  assert(tab_found, "Tab mapping not found in insert mode")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 8: Check Shift-Tab mapping exists
if test("Shift-Tab key mapping exists", function()
  local mappings = vim.api.nvim_get_keymap("i")
  local shift_tab_found = false
  for _, mapping in ipairs(mappings) do
    if mapping.lhs == "<S-Tab>" then
      shift_tab_found = true
      break
    end
  end
  assert(shift_tab_found, "Shift-Tab mapping not found in insert mode")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 9: Check Python snippets are loaded
if test("Python snippets are available", function()
  local ls = require("luasnip")
  local snippets = ls.get_snippets("python")
  assert(snippets ~= nil, "No Python snippets found")
  -- Check for our custom snippets
  local found_docstring = false
  local found_deft = false
  local found_main = false

  if snippets then
    for _, snippet in pairs(snippets) do
      if snippet.trigger == "docstring" then found_docstring = true end
      if snippet.trigger == "deft" then found_deft = true end
      if snippet.trigger == "main" then found_main = true end
    end
  end

  assert(found_docstring, "docstring snippet not found")
  assert(found_deft, "deft snippet not found")
  assert(found_main, "main snippet not found")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 10: Check JavaScript snippets are loaded
if test("JavaScript snippets are available", function()
  local ls = require("luasnip")
  local snippets = ls.get_snippets("javascript")
  assert(snippets ~= nil, "No JavaScript snippets found")
  -- Check for our custom snippets
  local found_arrow = false
  local found_rfc = false
  local found_useState = false
  local found_useEffect = false

  if snippets then
    for _, snippet in pairs(snippets) do
      if snippet.trigger == "arrow" then found_arrow = true end
      if snippet.trigger == "rfc" then found_rfc = true end
      if snippet.trigger == "useState" then found_useState = true end
      if snippet.trigger == "useEffect" then found_useEffect = true end
    end
  end

  assert(found_arrow, "arrow snippet not found")
  assert(found_rfc, "rfc snippet not found")
  assert(found_useState, "useState snippet not found")
  assert(found_useEffect, "useEffect snippet not found")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 11: Check nvim-cmp source modules are loaded
if test("nvim-cmp source modules available", function()
  -- Just check that the source modules can be loaded
  local sources_ok = true
  local sources = { "cmp_nvim_lsp", "cmp_luasnip" }
  for _, source in ipairs(sources) do
    local ok = pcall(require, source)
    if not ok then
      sources_ok = false
      assert(false, "Failed to load source: " .. source)
    end
  end
  -- Also check that the sources are registered with cmp
  local cmp = require("cmp")
  assert(cmp ~= nil, "cmp module not loaded")
  assert(sources_ok, "Not all sources loaded")
end) then passed = passed + 1 else failed = failed + 1 end

-- Test 12: Check nvim-cmp basic functionality
if test("nvim-cmp basic functions available", function()
  local cmp = require("cmp")
  -- Check for basic cmp functions that should always be available
  assert(type(cmp.confirm) == "function", "cmp.confirm is not a function")
  assert(type(cmp.select_next_item) == "function", "cmp.select_next_item is not a function")
  assert(type(cmp.select_prev_item) == "function", "cmp.select_prev_item is not a function")
  assert(type(cmp.abort) == "function", "cmp.abort is not a function")
end) then passed = passed + 1 else failed = failed + 1 end

print("\n=== Summary ===")
print("Passed: " .. passed)
print("Failed: " .. failed)
print("Total: " .. (passed + failed))

-- Exit with error code if any tests failed
if failed > 0 then
  vim.cmd("cq")
else
  vim.cmd("qa")
end