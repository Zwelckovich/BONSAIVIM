-- BONSAI flash.nvim configuration
-- Lightning-fast navigation with minimal visual disruption

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- Labels for jump positions
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = {
      -- Automatically jump to the first match
      multi_window = true,
      forward = true,
      wrap = true,
      mode = "fuzzy",
      incremental = false,
    },
    jump = {
      -- Jump position behavior
      jumplist = true,
      pos = "start", -- "start" | "end" | "range"
      history = false,
      register = false,
      nohlsearch = false,
      autojump = false,
    },
    label = {
      -- Label appearance
      uppercase = false,
      after = false,
      before = true,
      style = "overlay", -- "overlay" | "inline" | "eol"
      reuse = "lowercase",
      distance = true,
      min_pattern_length = 0,
      rainbow = {
        enabled = false,
      },
    },
    highlight = {
      -- Highlight appearance with BONSAI colors
      backdrop = true,
      matches = true,
      priority = 5000,
      groups = {
        match = "FlashMatch",
        current = "FlashCurrent",
        backdrop = "FlashBackdrop",
        label = "FlashLabel",
      },
    },
    modes = {
      search = {
        enabled = true,
        highlight = { backdrop = false },
        jump = { history = true, register = true, nohlsearch = true },
        search = {
          forward = true,
          mode = "fuzzy",
          incremental = true,
        },
      },
      char = {
        enabled = true,
        config = function(opts)
          -- Disable for large files
          opts.autohide = vim.fn.line("$") > 10000
        end,
        highlight = { backdrop = true },
        jump = { register = false },
        search = { wrap = false },
        multi_line = true,
        label = { exclude = "hjkliardc" },
        keys = { "f", "F", "t", "T", ";", "," },
        char_actions = function(motion)
          return {
            [";"] = "next",
            [","] = "prev",
            [motion:lower()] = "next",
            [motion:upper()] = "prev",
          }
        end,
      },
      treesitter = {
        labels = "abcdefghijklmnopqrstuvwxyz",
        jump = { pos = "range" },
        search = { incremental = false },
        label = { before = true, after = true, style = "inline" },
        highlight = {
          backdrop = false,
          matches = false,
        },
      },
    },
    prompt = {
      enabled = true,
      prefix = { { "⚡", "FlashPromptIcon" } },
    },
  },
  config = function(_, opts)
    require("flash").setup(opts)

    -- BONSAI color setup
    local colors = {
      yellow_primary = "#c7a882",
      yellow_secondary = "#d4b99b",
      green_primary = "#7c9885",
      green_muted = "#677a70",
      bg_deep = "#0a0e14",
      text_muted = "#8b92a5",
    }

    -- Apply BONSAI colors
    vim.api.nvim_set_hl(0, "FlashMatch", { bg = colors.green_muted, fg = colors.bg_deep })
    vim.api.nvim_set_hl(0, "FlashCurrent", { bg = colors.green_primary, fg = colors.bg_deep, bold = true })
    vim.api.nvim_set_hl(0, "FlashLabel", { bg = colors.yellow_primary, fg = colors.bg_deep, bold = true })
    vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = colors.text_muted })
    vim.api.nvim_set_hl(0, "FlashPromptIcon", { fg = colors.yellow_primary })

    -- Keymaps
    local map = vim.keymap.set

    -- Main navigation keys
    map({ "n", "x", "o" }, "s", function()
      require("flash").jump()
    end, { desc = "Flash forward" })

    map({ "n", "x", "o" }, "S", function()
      require("flash").jump({ search = { forward = false } })
    end, { desc = "Flash backward" })

    -- Treesitter navigation (for specific node types)
    map({ "n", "x", "o" }, "<leader>jt", function()
      require("flash").treesitter()
    end, { desc = "Flash Treesitter" })

    -- Remote flash (for operator pending mode)
    map("o", "r", function()
      require("flash").remote()
    end, { desc = "Remote Flash" })

    -- Toggle flash search
    map({ "c" }, "<c-s>", function()
      require("flash").toggle()
    end, { desc = "Toggle Flash Search" })
  end,
}