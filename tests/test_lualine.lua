#!/usr/bin/env nvim -l
-- Test script for lualine.nvim plugin

-- Add config path to runtime
vim.opt.runtimepath:prepend(vim.fn.expand("~/projects/BONSAIVIM/config/.config/nvim"))

-- Load lazy.nvim
require("config.lazy")

-- Wait for plugins to load
vim.wait(3000)

-- Force load lualine
local lazy = require("lazy")
lazy.load({plugins = {"lualine.nvim"}})
vim.wait(1000)

-- Test results tracking
local results = {
  total = 0,
  passed = 0,
  failed = 0
}

local function test(name, condition, error_msg)
  results.total = results.total + 1
  if condition then
    results.passed = results.passed + 1
    print("✓ " .. name)
  else
    results.failed = results.failed + 1
    print("✗ " .. name .. (error_msg and ": " .. error_msg or ""))
  end
end

print("Testing lualine statusline plugin...")
print("=" .. string.rep("=", 50))

-- Basic loading test
local lualine_ok, lualine = pcall(require, "lualine")
test("Lualine module loads", lualine_ok)

-- Test lualine is active
if lualine_ok then
  test("Lualine has get_config function", type(lualine.get_config) == "function")
  
  -- Get current config
  local config = lualine.get_config()
  test("Lualine config exists", config ~= nil)
  
  if config then
    test("Lualine has options", config.options ~= nil)
    test("Lualine has sections", config.sections ~= nil)
    test("Lualine globalstatus enabled", config.options and config.options.globalstatus == true)
    
    -- Test BONSAI theme is applied
    test("Lualine theme is set", config.options and config.options.theme ~= nil)
    
    -- Test sections are configured
    if config.sections then
      test("Lualine section a configured", config.sections.lualine_a ~= nil)
      test("Lualine section b configured", config.sections.lualine_b ~= nil)
      test("Lualine section c configured", config.sections.lualine_c ~= nil)
      test("Lualine section x configured", config.sections.lualine_x ~= nil)
      test("Lualine section y configured", config.sections.lualine_y ~= nil)
      test("Lualine section z configured", config.sections.lualine_z ~= nil)
    end
  end
end

-- Test statusline is not empty
test("Statusline is configured", vim.o.statusline ~= "")

-- Test that laststatus is set correctly for globalstatus
test("Laststatus set for global statusline", vim.o.laststatus == 3)

-- Summary
print("=" .. string.rep("=", 50))
print(string.format("Tests: %d total, %d passed, %d failed", 
  results.total, results.passed, results.failed))

-- Exit with appropriate code
os.exit(results.failed == 0 and 0 or 1)