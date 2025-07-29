-- BONSAI which-key configuration
-- Interactive keybinding discovery and visualization

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {},
  config = function(_, opts)
    local wk = require("which-key")

    -- BONSAI color definitions
    local colors = {
      bg_primary = "#151922",
      bg_secondary = "#1e242e",
      bg_elevated = "#232933",
      text_primary = "#e6e8eb",
      text_secondary = "#b8bcc8",
      text_muted = "#8b92a5",
      border_subtle = "#2d3441",
      green_primary = "#7c9885",
      blue_primary = "#82a4c7",
      yellow_primary = "#c7a882",
      purple_primary = "#9882c7",
    }

    -- Apply BONSAI colors
    vim.api.nvim_set_hl(0, "WhichKey", { fg = colors.green_primary })
    vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = colors.blue_primary })
    vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = colors.text_secondary })
    vim.api.nvim_set_hl(0, "WhichKeySeperator", { fg = colors.text_muted })
    vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = colors.text_muted })
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = colors.bg_primary })
    vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = colors.border_subtle, bg = colors.bg_primary })
    vim.api.nvim_set_hl(0, "WhichKeyValue", { fg = colors.yellow_primary })

    -- Merge opts with our configuration
    local setup_opts = vim.tbl_deep_extend("force", {
      -- Try the helix preset which provides right-side panel
      preset = "helix",
      win = {
        border = "rounded",
        wo = {
          winblend = 0, -- No transparency
        },
      },
    }, opts)

    wk.setup(setup_opts)

    -- Register key groups only - mappings are defined in their respective files
    wk.add({
      -- Groups
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "diagnostics" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "hunk" },
      { "<leader>j", group = "jump" },
      { "<leader>m", group = "markdown" },
      { "<leader>p", group = "persistence" },
      { "<leader>q", group = "quit" },
      { "<leader>s", group = "search" },
      { "<leader>t", group = "toggle" },
      { "<leader>w", group = "window" },
      { "<leader>x", group = "execute" },
      { "<leader>y", group = "yazi" },
    })

    -- Register descriptions for existing mappings (don't duplicate the mappings)
    -- These mappings are defined in other files
    wk.add({
      -- Describe existing navigation mappings
      { "[f", desc = "Previous function" },
      { "]f", desc = "Next function" },
      { "[c", desc = "Previous git hunk" },
      { "]c", desc = "Next git hunk" },
      { "[[", desc = "Previous class" },
      { "]]", desc = "Next class" },

      -- Flash navigation descriptions
      { "s", desc = "Flash forward" },
      { "S", desc = "Flash backward" },
    })
  end,
}