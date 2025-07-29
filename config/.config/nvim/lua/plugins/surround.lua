-- nvim-surround: Efficient text manipulation with surround operations
return {
  "kylechui/nvim-surround",
  version = "*", -- Use stable releases
  event = "VeryLazy", -- Load when needed
  config = function()
    require("nvim-surround").setup({
      -- BONSAI minimal configuration
      keymaps = {
        -- Normal mode
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
      },
      -- Aliases for convenience
      aliases = {
        ["a"] = ">", -- angle brackets
        ["b"] = ")", -- brackets
        ["B"] = "}", -- curly brackets
        ["r"] = "]", -- square brackets
        ["q"] = { '"', "'", "`" }, -- quotes
      },
      -- BONSAI styling for highlights
      highlight = {
        duration = 300, -- Subtle, quick highlight
      },
      -- Disable default surrounds we don't need
      surrounds = {
        -- Keep all defaults but customize behavior
      },
      -- Move cursor to appropriate position after surround
      move_cursor = "begin",
    })
  end,
}