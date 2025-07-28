-- Simple plugin verification script
local function test_plugin(name, module)
  local ok, err = pcall(require, module)
  if ok then
    print("✓ " .. name .. " loaded successfully")
    return true
  else
    print("✗ " .. name .. " failed to load: " .. tostring(err))
    return false
  end
end

print("=== BONSAI Plugin Verification ===\n")

local passed = 0
local failed = 0

-- Test each plugin
if test_plugin("Treesitter", "nvim-treesitter") then passed = passed + 1 else failed = failed + 1 end
if test_plugin("Telescope", "telescope") then passed = passed + 1 else failed = failed + 1 end
if test_plugin("Flash", "flash") then passed = passed + 1 else failed = failed + 1 end
if test_plugin("Which-key", "which-key") then passed = passed + 1 else failed = failed + 1 end
if test_plugin("Mason", "mason") then passed = passed + 1 else failed = failed + 1 end
if test_plugin("Mason-lspconfig", "mason-lspconfig") then passed = passed + 1 else failed = failed + 1 end
if test_plugin("LSPConfig", "lspconfig") then passed = passed + 1 else failed = failed + 1 end
if test_plugin("Conform", "conform") then passed = passed + 1 else failed = failed + 1 end
if test_plugin("LuaSnip", "luasnip") then passed = passed + 1 else failed = failed + 1 end
if test_plugin("nvim-cmp", "cmp") then passed = passed + 1 else failed = failed + 1 end

print("\n=== Summary ===")
print("Passed: " .. passed)
print("Failed: " .. failed)
print("Total: " .. (passed + failed))

-- Write results to file
local f = io.open("plugin_test_results.txt", "w")
if f then
  f:write("Passed: " .. passed .. "\n")
  f:write("Failed: " .. failed .. "\n")
  f:close()
end

if failed > 0 then
  vim.cmd("cq")
else
  vim.cmd("qa")
end