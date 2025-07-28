-- BONSAI lazy.nvim configuration
-- Minimal package manager setup

require("lazy").setup({
  spec = {
    -- Import all plugins from lua/plugins directory
    { import = "plugins" },
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
  -- Disable luarocks integration (not needed for our plugins)
  rocks = {
    enabled = false,
  },
  ui = {
    border = "rounded", -- BONSAI aesthetic
    backdrop = 100,     -- Darken backdrop
  },
})