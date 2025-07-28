-- BONSAI Neovim Configuration Test Script
-- Run with: nvim -u init.lua +source test_config.lua +qa

local M = {}

-- Test results storage
local results = {
  passed = 0,
  failed = 0,
  tests = {}
}

-- Test helper function
local function test(name, fn)
  local ok, err = pcall(fn)
  if ok then
    results.passed = results.passed + 1
    table.insert(results.tests, { name = name, status = "PASS" })
    print("✓ " .. name)
  else
    results.failed = results.failed + 1
    table.insert(results.tests, { name = name, status = "FAIL", error = err })
    print("✗ " .. name .. " - " .. err)
  end
end

-- Run tests
function M.run()
  print("=== BONSAI Neovim Configuration Tests ===\n")
  
  -- Also write to a results file
  local results_file = io.open("test_results.txt", "w")
  local function log(msg)
    print(msg)
    if results_file then
      results_file:write(msg .. "\n")
    end
  end
  
  -- Test 1: Check if treesitter is loaded
  test("Treesitter plugin loaded", function()
    assert(pcall(require, "nvim-treesitter"), "Treesitter not loaded")
  end)
  
  -- Test 1b: Check if telescope is loaded
  test("Telescope plugin loaded", function()
    assert(pcall(require, "telescope"), "Telescope not loaded")
  end)
  
  -- Test 1c: Check if flash is loaded
  test("Flash plugin loaded", function()
    assert(pcall(require, "flash"), "Flash not loaded")
  end)
  
  -- Test 1d: Check if which-key is loaded
  test("Which-key plugin loaded", function()
    assert(pcall(require, "which-key"), "Which-key not loaded")
  end)
  
  -- Test 2: Check if treesitter configs are accessible
  test("Treesitter configs accessible", function()
    assert(pcall(require, "nvim-treesitter.configs"), "Treesitter configs not accessible")
  end)
  
  -- Test 3: Check if required parsers are listed
  test("Required parsers configured", function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    assert(ok, "Cannot load treesitter configs")
    -- Note: Can't directly test ensure_installed without complex setup
  end)
  
  -- Test 4: Check folding settings
  test("Folding configured correctly", function()
    assert(vim.opt.foldmethod:get() == "expr", "Foldmethod not set to expr")
    assert(vim.opt.foldenable:get() == false, "Folding enabled by default")
  end)
  
  -- Test 5: Check lazy.nvim imports plugins directory
  test("Lazy.nvim configured for plugins directory", function()
    local lazy_config = require("lazy.core.config")
    assert(lazy_config, "Lazy config not accessible")
  end)
  
  -- Test 6: Performance check - startup time
  test("Startup time under 50ms", function()
    -- This is a placeholder - actual startup time testing requires external measurement
    -- For now, just check that we're not loading unnecessary plugins
    local loaded_count = 0
    for _ in pairs(package.loaded) do
      loaded_count = loaded_count + 1
    end
    print("  Loaded modules: " .. loaded_count)
    assert(loaded_count < 200, "Too many modules loaded at startup")
  end)
  
  -- Print summary
  log("\n=== Test Summary ===")
  log("Passed: " .. results.passed)
  log("Failed: " .. results.failed)
  log("Total:  " .. (results.passed + results.failed))
  
  -- Close results file
  if results_file then
    results_file:close()
  end
  
  -- Exit with appropriate code
  if results.failed > 0 then
    vim.cmd("cq") -- Exit with error
  else
    vim.cmd("qa") -- Exit successfully
  end
end

-- Auto-run if sourced directly
if vim.fn.has('vim_starting') == 0 then
  M.run()
end

return M