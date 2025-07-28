-- BONSAI lazy.nvim configuration
-- Minimal package manager setup

require("lazy").setup({
  spec = {
    -- Plugins will be added here in future phases
    -- For now, we keep it empty to ensure a working foundation
  },
  defaults = {
    lazy = true,  -- Default all plugins to lazy loading
    version = "*", -- Use latest stable versions
  },
  install = {
    colorscheme = { "habamax" }, -- Fallback until BONSAI colorscheme
  },
  checker = {
    enabled = false, -- Disable automatic update checking
  },
  performance = {
    rtp = {
      disabled_plugins = {
        -- Disable unused built-in plugins for faster startup
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded", -- BONSAI aesthetic
    backdrop = 100,     -- Darken backdrop
  },
})