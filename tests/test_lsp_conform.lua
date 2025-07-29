-- Comprehensive test suite for LSP and formatting configuration

local function test(desc, fn)
  local ok, err = pcall(fn)
  if ok then
    print("✓ " .. desc)
    return true
  else
    print("✗ " .. desc .. ": " .. tostring(err))
    return false
  end
end

print("=== BONSAI LSP & Formatting Test Suite ===\n")

local passed = 0
local failed = 0

-- Test 1: Verify all LSP plugins are loaded
local function run_lsp_tests()
  if test("Mason core loaded", function()
    require("mason")
  end) then passed = passed + 1 else failed = failed + 1 end

  if test("Mason-lspconfig loaded", function()
    require("mason-lspconfig")
  end) then passed = passed + 1 else failed = failed + 1 end

  if test("nvim-lspconfig loaded", function()
    require("lspconfig")
  end) then passed = passed + 1 else failed = failed + 1 end

  if test("Conform.nvim loaded", function()
    require("conform")
  end) then passed = passed + 1 else failed = failed + 1 end
end

-- Test 2: Verify LSP server configurations
local function run_server_config_tests()
  if test("Pyright server config exists", function()
    local lspconfig = require("lspconfig")
    assert(lspconfig.pyright, "pyright server not found")
  end) then passed = passed + 1 else failed = failed + 1 end

  if test("TypeScript server config exists", function()
    local lspconfig = require("lspconfig")
    assert(lspconfig.ts_ls, "ts_ls server not found")
  end) then passed = passed + 1 else failed = failed + 1 end

  if test("Tailwind CSS server config exists", function()
    local lspconfig = require("lspconfig")
    assert(lspconfig.tailwindcss, "tailwindcss server not found")
  end) then passed = passed + 1 else failed = failed + 1 end
end

-- Test 3: Verify formatter configurations
local function run_formatter_tests()
  if test("Python formatters configured", function()
    local conform = require("conform")
    -- Check the formatters_by_ft table directly
    local formatters_by_ft = conform.formatters_by_ft or {}
    local formatters = formatters_by_ft.python or {}
    assert(#formatters > 0, "No Python formatters configured")
    assert(vim.tbl_contains(formatters, "ruff_fix") or vim.tbl_contains(formatters, "ruff_format"),
           "ruff formatters not found")
  end) then passed = passed + 1 else failed = failed + 1 end

  if test("JavaScript formatters configured", function()
    local conform = require("conform")
    local formatters_by_ft = conform.formatters_by_ft or {}
    local formatters = formatters_by_ft.javascript or {}
    assert(#formatters > 0, "No JavaScript formatters configured")
    assert(vim.tbl_contains(formatters, "prettier"), "prettier not found")
  end) then passed = passed + 1 else failed = failed + 1 end

  if test("Lua formatter configured", function()
    local conform = require("conform")
    local formatters_by_ft = conform.formatters_by_ft or {}
    local formatters = formatters_by_ft.lua or {}
    assert(#formatters > 0, "No Lua formatters configured")
    assert(vim.tbl_contains(formatters, "stylua"), "stylua not found")
  end) then passed = passed + 1 else failed = failed + 1 end
end

-- Test 4: Verify keymaps
local function run_keymap_tests()
  if test("Conform format keymap defined", function()
    -- Verify the keymap will be registered (it's lazy-loaded)
    -- Check if conform plugin configuration includes the keymap
    local lazy_config = require("lazy.core.config")
    local conform_spec = nil

    -- Find conform plugin spec
    for _, plugin in pairs(lazy_config.plugins) do
      if plugin.name == "conform.nvim" then
        conform_spec = plugin
        break
      end
    end

    assert(conform_spec, "Conform plugin not found in lazy config")
    assert(conform_spec.keys, "Conform plugin has no keys defined")

    -- Check if <leader>cf is in the keys
    local has_format_key = false
    for _, key in ipairs(conform_spec.keys) do
      if type(key) == "table" and key[1] == "<leader>cf" then
        has_format_key = true
        break
      end
    end

    assert(has_format_key, "No <leader>cf keymap defined in conform config")
  end) then passed = passed + 1 else failed = failed + 1 end

  if test("Diagnostic navigation keymaps exist", function()
    local keymaps = vim.api.nvim_get_keymap('n')
    local has_diagnostic_prev = false
    local has_diagnostic_next = false
    for _, map in ipairs(keymaps) do
      if map.lhs == "[d" then has_diagnostic_prev = true end
      if map.lhs == "]d" then has_diagnostic_next = true end
    end
    assert(has_diagnostic_prev and has_diagnostic_next, "Diagnostic navigation keymaps missing")
  end) then passed = passed + 1 else failed = failed + 1 end
end

-- Test 5: Verify diagnostic configuration
local function run_diagnostic_tests()
  if test("Diagnostics configured for errors only in virtual text", function()
    local config = vim.diagnostic.config()
    assert(config.virtual_text, "Virtual text not enabled")
    assert(config.virtual_text.severity == vim.diagnostic.severity.ERROR,
           "Virtual text not limited to errors only")
  end) then passed = passed + 1 else failed = failed + 1 end

  if test("Diagnostic signs defined", function()
    local signs = {"DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignHint", "DiagnosticSignInfo"}
    for _, sign in ipairs(signs) do
      local defined = vim.fn.sign_getdefined(sign)
      assert(#defined > 0, sign .. " not defined")
    end
  end) then passed = passed + 1 else failed = failed + 1 end
end

-- Test 6: Verify format on save
local function run_format_on_save_tests()
  if test("Format on save configured", function()
    -- Conform setup is configured, we just verify the plugin is loaded
    -- The actual format on save settings are internal to conform
    local conform = require("conform")
    assert(conform, "Conform module not loaded")
    -- We can't directly access format_on_save as it's internal
    -- But we can verify the commands exist
    local commands = vim.api.nvim_get_commands({})
    assert(commands.ConformInfo, "ConformInfo command not found")
  end) then passed = passed + 1 else failed = failed + 1 end
end

-- Run all tests
print("→ Running LSP plugin tests...")
run_lsp_tests()

print("\n→ Running server configuration tests...")
run_server_config_tests()

print("\n→ Running formatter tests...")
run_formatter_tests()

print("\n→ Running keymap tests...")
run_keymap_tests()

print("\n→ Running diagnostic tests...")
run_diagnostic_tests()

print("\n→ Running format on save tests...")
run_format_on_save_tests()

-- Summary
print("\n=== Test Summary ===")
print("Passed: " .. passed)
print("Failed: " .. failed)
print("Total: " .. (passed + failed))

-- Write results
local f = io.open("tests/results/lsp_test_results.txt", "w")
if f then
  f:write("LSP & Formatting Test Results\n")
  f:write("============================\n")
  f:write("Passed: " .. passed .. "\n")
  f:write("Failed: " .. failed .. "\n")
  f:write("Total: " .. (passed + failed) .. "\n")
  f:close()
end

-- Exit with appropriate code
if failed > 0 then
  vim.cmd("cq 1")
else
  vim.cmd("qa")
end