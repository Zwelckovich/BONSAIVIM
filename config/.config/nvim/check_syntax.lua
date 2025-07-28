-- BONSAI Lua syntax checker
local files = {
  "init.lua",
  "lua/config/lazy.lua",
  "lua/config/options.lua", 
  "lua/config/keymaps.lua",
  "lua/plugins/treesitter.lua",
  "test_config.lua"
}

local errors = 0
for _, file in ipairs(files) do
  local f, err = loadfile(file)
  if f then
    print("✓ " .. file .. " - syntax OK")
  else
    print("✗ " .. file .. " - " .. (err or "unknown error"))
    errors = errors + 1
  end
end

print("\nSyntax check complete: " .. errors .. " errors found")
if errors > 0 then
  vim.cmd("cq")
else
  vim.cmd("qa")
end