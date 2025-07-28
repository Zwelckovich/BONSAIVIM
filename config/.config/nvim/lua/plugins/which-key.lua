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
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      -- Use compatible configuration
      window = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 10,
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      ignore_missing = false,
      show_help = true,
      show_keys = true,
      triggers = "auto",
      triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
      },
      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },
    }, opts)
    
    wk.setup(setup_opts)

    -- Register key groups and mappings with explicit leader prefix
    wk.register({
      b = { name = "+buffer" },
      c = { name = "+code" },
      d = { name = "+diagnostics" },
      f = { name = "+find" },
      g = { name = "+git" },
      h = { name = "+hunk" },
      j = { name = "+jump" },
      m = { name = "+markdown" },
      p = { name = "+persistence" },
      q = { name = "+quit" },
      s = { name = "+search" },
      t = { name = "+toggle" },
      w = { name = "+window" },
      x = { name = "+execute" },
      y = { name = "+yazi" },
      
      -- Explicitly register mappings from keymaps.lua
      Y = { '"+Y', "Yank line to clipboard" },
      e = { ":Ex<CR>", "Open file explorer" },
      
      -- Window management (as subcommands)
      ["wv"] = { "<C-w>v", "Vertical split" },
      ["ws"] = { "<C-w>s", "Horizontal split" },
      ["wc"] = { "<C-w>c", "Close window" },
      ["wo"] = { "<C-w>o", "Close other windows" },
      ["w="] = { "<C-w>=", "Balance windows" },
      
      -- Buffer management  
      ["bd"] = { ":bdelete<CR>", "Delete buffer" },
      ["bn"] = { ":bnext<CR>", "Next buffer" },
      ["bp"] = { ":bprevious<CR>", "Previous buffer" },
      ["bD"] = { ":bdelete!<CR>", "Force delete buffer" },
      
      -- Quit commands
      ["qq"] = { ":qa<CR>", "Quit all" },
      ["qQ"] = { ":qa!<CR>", "Force quit all" },
      
      -- Search/Replace
      ["sc"] = { ":nohlsearch<CR>", "Clear search highlights" },
      ["sw"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace word under cursor" },
      
      -- Toggle settings
      ["tn"] = { ":set relativenumber!<CR>", "Toggle relative numbers" },
      ["tw"] = { ":set wrap!<CR>", "Toggle line wrap" },
      ["ts"] = { ":set spell!<CR>", "Toggle spell check" },
      ["th"] = { ":set hlsearch!<CR>", "Toggle search highlight" },
      
      -- Telescope mappings (from telescope.lua)
      ["ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
      ["fg"] = { "<cmd>Telescope live_grep<cr>", "Find by grep" },
      ["fb"] = { "<cmd>Telescope buffers<cr>", "Find buffers" },
      ["fh"] = { "<cmd>Telescope help_tags<cr>", "Find help" },
      ["fc"] = { "<cmd>Telescope commands<cr>", "Find commands" },
      ["fr"] = { "<cmd>Telescope oldfiles<cr>", "Find recent files" },
      ["f/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find in buffer" },
    }, { prefix = "<leader>" })

    -- Register specific mappings with descriptions
    -- These enhance the existing keymaps from keymaps.lua
    wk.register({
      -- Normal mode mappings
      ["<C-h>"] = { "<C-w>h", "Go to left window" },
      ["<C-j>"] = { "<C-w>j", "Go to lower window" },
      ["<C-k>"] = { "<C-w>k", "Go to upper window" },
      ["<C-l>"] = { "<C-w>l", "Go to right window" },

      ["<S-h>"] = { ":bprevious<CR>", "Previous buffer" },
      ["<S-l>"] = { ":bnext<CR>", "Next buffer" },

      ["[q"] = { ":cprev<CR>", "Previous quickfix" },
      ["]q"] = { ":cnext<CR>", "Next quickfix" },

      -- Treesitter text objects (from treesitter config)
      ["[f"] = { "Previous function" },
      ["]f"] = { "Next function" },
      ["[c"] = { "Previous class" },
      ["]c"] = { "Next class" },
      ["[["] = { "Previous function/class" },
      ["]]"] = { "Next function/class" },

      -- Flash navigation
      s = { "Flash forward" },
      S = { "Flash backward" },

      -- Leader mappings are already defined in keymaps.lua
      -- We just add group names above
    }, { mode = "n" })

    -- Visual mode mappings
    wk.register({
      ["<"] = { "<gv", "Indent left" },
      [">"] = { ">gv", "Indent right" },
      J = { ":m '>+1<CR>gv=gv", "Move selection down" },
      K = { ":m '<-2<CR>gv=gv", "Move selection up" },
    }, { mode = "v" })
    
    -- Visual mode leader mappings
    wk.register({
      d = { '"_d', "Delete without yanking" },
      p = { '"_dP', "Paste without yanking" },
      y = { '"+y', "Yank to clipboard" },
    }, { mode = "v", prefix = "<leader>" })

    -- Operator pending mode
    wk.register({
      ["af"] = { "@function.outer", "around function" },
      ["if"] = { "@function.inner", "inside function" },
      ["ac"] = { "@class.outer", "around class" },
      ["ic"] = { "@class.inner", "inside class" },
      ["as"] = { "@scope", "around scope" },
    }, { mode = "o" })
  end,
}