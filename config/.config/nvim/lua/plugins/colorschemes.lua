-- BONSAI additional colorschemes
-- Alternative themes alongside the default BONSAI colorscheme

return {
  -- Tokyo Night theme
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Load immediately so it's available
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- Available: storm, moon, night, day
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          variables = {},
        },
        dim_inactive = true,
        lualine_bold = true,
      })
    end,
  },

  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
      })
    end,
  },

  -- Nightfox theme
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled",
          transparent = false,
          terminal_colors = true,
          dim_inactive = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "bold",
          },
        },
      })
    end,
  },
}