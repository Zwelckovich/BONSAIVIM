#!/usr/bin/env nvim -l
-- Test script for undotree plugin

-- Add config path to runtime
vim.opt.runtimepath:prepend(vim.fn.expand("~/projects/BONSAIVIM/config/.config/nvim"))

-- Load lazy.nvim
require("config.lazy")

-- Wait for plugins to load
vim.wait(3000)

-- Force load undotree
local lazy = require("lazy")
lazy.load({plugins = {"undotree"}})
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
    print(" " .. name)
  else
    results.failed = results.failed + 1
    print(" " .. name .. (error_msg and ": " .. error_msg or ""))
  end
end

print("Testing undotree plugin...")
print("=" .. string.rep("=", 50))

-- Test undotree command exists
test("UndotreeToggle command exists", vim.fn.exists(":UndotreeToggle") == 2)
test("UndotreeShow command exists", vim.fn.exists(":UndotreeShow") == 2)
test("UndotreeHide command exists", vim.fn.exists(":UndotreeHide") == 2)
test("UndotreeFocus command exists", vim.fn.exists(":UndotreeFocus") == 2)

-- Test configuration values
test("Window layout configured (right side)", vim.g.undotree_WindowLayout == 4)
test("Split width configured (40%)", vim.g.undotree_SplitWidth == 40)
test("Auto-focus configured", vim.g.undotree_SetFocusWhenToggle == 1)
test("Short indicators configured", vim.g.undotree_ShortIndicators == 1)
test("Relative timestamp configured", vim.g.undotree_RelativeTimestamp == 1)
test("Diff auto-open configured", vim.g.undotree_DiffAutoOpen == 1)
test("Diff panel height configured", vim.g.undotree_DiffpanelHeight == 10)

-- Test persistent undo settings
test("Persistent undo enabled", vim.o.undofile == true)
test("Undo levels set to 10000", vim.o.undolevels == 10000)
test("Undo reload set to 10000", vim.o.undoreload == 10000)

-- Test undo directory
local undodir = vim.o.undodir
test("Undo directory configured", undodir ~= nil and undodir ~= "")
test("Undo directory contains nvim/undo", undodir and undodir:match("nvim/undo") ~= nil)

-- Test undo directory exists
local undodir_path = vim.fn.expand(undodir:match("([^,]+)"))
test("Undo directory exists", vim.fn.isdirectory(undodir_path) == 1)

-- Test keymapping
local mapping = vim.fn.mapcheck("<leader>u", "n")
test("Leader-u mapping exists", mapping ~= "")

-- Test FileType autocmd for undotree
local autocmds = vim.api.nvim_get_autocmds({event = "FileType", pattern = "undotree"})
test("Undotree FileType autocmd exists", #autocmds > 0)

-- Summary
print("=" .. string.rep("=", 50))
print(string.format("Tests: %d total, %d passed, %d failed", 
  results.total, results.passed, results.failed))

-- Exit with appropriate code
os.exit(results.failed == 0 and 0 or 1)