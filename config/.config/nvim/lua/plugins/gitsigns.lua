-- BONSAI gitsigns.nvim configuration
-- Subtle git integration with visual indicators and hunk operations

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Subtle sign column indicators (don't distract from code)
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
    },
    signs_staged_enable = true,
    signcolumn = true,  -- Always show sign column
    numhl      = false, -- Don't highlight line numbers
    linehl     = false, -- Don't highlight lines
    word_diff  = false, -- Don't show word diff by default
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Disabled by default (toggle with <leader>tb)
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- End of line
      delay = 1000,          -- Delay to avoid visual noise
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable for large files
    preview_config = {
      -- Preview window styling
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation between hunks
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true, desc = 'Next git hunk'})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true, desc = 'Previous git hunk'})

      -- Hunk operations under <leader>h
      map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
      map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
      map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage selected hunk' })
      map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset selected hunk' })
      map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
      map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
      map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
      map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = 'Blame line' })
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle blame line' })
      map('n', '<leader>hd', gs.diffthis, { desc = 'Diff this' })
      map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff this (cached)' })
      map('n', '<leader>td', gs.toggle_deleted, { desc = 'Toggle deleted' })

      -- Text object for selecting hunks
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })

      -- Additional navigation shortcuts matching concept.md
      map('n', '<leader>hn', gs.next_hunk, { desc = 'Next hunk' })
      map('n', '<leader>hN', gs.prev_hunk, { desc = 'Previous hunk' })
    end
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)

    -- BONSAI color setup - subtle and non-distracting
    local colors = {
      green_primary = "#7c9885",
      green_muted = "#677a70",
      red_primary = "#c78289",
      red_muted = "#a56b71",
      blue_primary = "#82a4c7",
      blue_muted = "#6b8aa5",
      yellow_primary = "#c7a882",
      yellow_muted = "#a5906b",
      text_muted = "#8b92a5",
      text_disabled = "#6b7280",
    }

    -- Apply BONSAI colors for git signs
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.green_muted })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.blue_muted })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red_muted })
    vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = colors.red_muted })
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = colors.yellow_muted })
    vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = colors.text_disabled })

    -- Staged versions (slightly brighter)
    vim.api.nvim_set_hl(0, "GitSignsStagedAdd", { fg = colors.green_primary })
    vim.api.nvim_set_hl(0, "GitSignsStagedChange", { fg = colors.blue_primary })
    vim.api.nvim_set_hl(0, "GitSignsStagedDelete", { fg = colors.red_primary })
    vim.api.nvim_set_hl(0, "GitSignsStagedTopdelete", { fg = colors.red_primary })
    vim.api.nvim_set_hl(0, "GitSignsStagedChangedelete", { fg = colors.yellow_primary })

    -- Current line blame with muted colors
    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = colors.text_muted })

    -- Preview window colors
    vim.api.nvim_set_hl(0, "GitSignsAddPreview", { bg = colors.green_muted, fg = "#0a0e14" })
    vim.api.nvim_set_hl(0, "GitSignsDeletePreview", { bg = colors.red_muted, fg = "#0a0e14" })
  end,
}