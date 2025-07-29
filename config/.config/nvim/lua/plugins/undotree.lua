-- BONSAI undotree configuration
-- Visual undo history with floating window and BONSAI colors

return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undo tree" },
  },
  config = function()
    -- BONSAI color definitions for undotree
    local colors = {
      bg_primary = "#151922",
      bg_elevated = "#232933",
      text_primary = "#e6e8eb",
      text_muted = "#8b92a5",
      green_primary = "#7c9885",
      blue_primary = "#82a4c7",
      yellow_primary = "#c7a882",
      red_primary = "#c78289",
      purple_primary = "#9882c7",
    }

    -- Configure undotree settings
    vim.g.undotree_WindowLayout = 4  -- Layout 4: right side window
    vim.g.undotree_SplitWidth = 40   -- 40% width as specified
    vim.g.undotree_SetFocusWhenToggle = 1  -- Auto-focus on open
    vim.g.undotree_ShortIndicators = 1     -- Use short timestamps
    vim.g.undotree_RelativeTimestamp = 1   -- Relative timestamps for recent changes
    vim.g.undotree_DiffAutoOpen = 1        -- Auto-open diff window
    vim.g.undotree_DiffpanelHeight = 10    -- Diff panel height

    -- Enable persistent undo
    vim.opt.undofile = true
    vim.opt.undolevels = 10000
    vim.opt.undoreload = 10000
    
    -- Set undo directory
    local undodir = vim.fn.expand("~/.cache/nvim/undo")
    if vim.fn.isdirectory(undodir) == 0 then
      vim.fn.mkdir(undodir, "p", 0700)
    end
    vim.opt.undodir = undodir

    -- Apply BONSAI colors to undotree
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "undotree",
      callback = function()
        -- Tree structure colors
        vim.api.nvim_set_hl(0, "UndotreeBranch", { fg = colors.text_muted })
        vim.api.nvim_set_hl(0, "UndotreeNode", { fg = colors.text_primary })
        vim.api.nvim_set_hl(0, "UndotreeNodeCurrent", { fg = colors.green_primary, bold = true })
        vim.api.nvim_set_hl(0, "UndotreeNext", { fg = colors.blue_primary })
        vim.api.nvim_set_hl(0, "UndotreeTimeStamp", { fg = colors.text_muted })
        vim.api.nvim_set_hl(0, "UndotreeSavedSmall", { fg = colors.yellow_primary })
        vim.api.nvim_set_hl(0, "UndotreeSavedBig", { fg = colors.yellow_primary, bold = true })
        
        -- Diff window colors
        vim.api.nvim_set_hl(0, "UndotreeDiffAdded", { fg = colors.green_primary })
        vim.api.nvim_set_hl(0, "UndotreeDiffRemoved", { fg = colors.red_primary })
        
        -- Window background
        vim.api.nvim_set_hl(0, "UndotreeNormal", { bg = colors.bg_primary })
      end,
    })

    -- Floating window configuration for modern look
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "undotree_*",
      callback = function()
        vim.wo.winhl = "Normal:UndotreeNormal"
      end,
    })
  end,
}

