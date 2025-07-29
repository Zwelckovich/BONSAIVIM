-- Test nvim-surround plugin functionality
local function test_nvim_surround()
  print("\n=== Testing nvim-surround ===\n")
  
  -- Force load the plugin since it's lazy loaded
  local lazy = require("lazy")
  lazy.load({ plugins = { "nvim-surround" } })
  vim.wait(100)
  
  -- Test if the plugin module is available
  local ok, surround = pcall(require, "nvim-surround")
  if ok then
    print("✓ nvim-surround module loaded successfully")
    
    -- Test if configuration is set up
    local config_ok, config = pcall(require, "nvim-surround.config")
    if config_ok then
      print("✓ nvim-surround config loaded successfully")
      
      -- Verify default keymaps exist
      local keymaps = config.get_opts().keymaps
      if keymaps and keymaps.normal == "ys" then
        print("✓ Default keymaps configured correctly")
      else
        print("✗ Default keymaps not configured")
      end
    else
      print("✗ nvim-surround config failed to load")
    end
  else
    print("✗ nvim-surround module failed to load: " .. tostring(surround))
  end
  
  -- Test basic functionality (in buffer)
  vim.cmd("new") -- Create new buffer
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {"test word"})
  vim.cmd("normal! 0") -- Go to beginning
  
  -- Check if surround mappings exist
  local mappings = vim.api.nvim_get_keymap('n')
  local has_ys = false
  local has_cs = false
  local has_ds = false
  
  for _, map in ipairs(mappings) do
    if map.lhs == "ys" then has_ys = true end
    if map.lhs == "cs" then has_cs = true end
    if map.lhs == "ds" then has_ds = true end
  end
  
  if has_ys and has_cs and has_ds then
    print("✓ All surround keymaps registered (ys, cs, ds)")
  else
    print("✗ Some surround keymaps missing:")
    if not has_ys then print("  - ys (add surround) not found") end
    if not has_cs then print("  - cs (change surround) not found") end
    if not has_ds then print("  - ds (delete surround) not found") end
  end
  
  -- Clean up
  vim.cmd("bdelete!")
  
  print("\n=== nvim-surround test complete ===\n")
end

-- Run the test
test_nvim_surround()

-- Exit
vim.cmd("qa!")