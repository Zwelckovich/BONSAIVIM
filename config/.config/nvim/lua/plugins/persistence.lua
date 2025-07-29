-- BONSAI persistence.nvim configuration
-- Automatic session management that preserves project context

return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- Load before reading buffers
  keys = {
    -- Session management keybindings under <leader>p
    { "<leader>ps", function() require("persistence").save() end, desc = "Save session" },
    { "<leader>pr", function() require("persistence").load() end, desc = "Restore session" },
    { "<leader>pd", function() require("persistence").stop() end, desc = "Don't save session on exit" },
    { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
  },
  opts = {
    -- Store in standard data directory
    dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
    options = {
      "buffers",       -- Save and restore open buffers
      "curdir",        -- Save and restore current directory
      "folds",         -- Save and restore folds
      "help",          -- Exclude help windows
      "tabpages",      -- Save and restore tabs
      "terminal",      -- Exclude terminal buffers
      "winsize",       -- Save and restore window sizes
    },
    -- Exclude patterns for buffers we don't want to save
    pre_save = function()
      -- Remove buffers we don't want to persist
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) then
          local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
          local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
          
          -- Exclude help, quickfix, and temporary buffers
          if buftype == 'help' or 
             buftype == 'quickfix' or 
             buftype == 'terminal' or
             buftype == 'nofile' or
             filetype == 'gitcommit' or
             filetype == 'gitrebase' then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end
    end,
  },
  config = function(_, opts)
    local persistence = require("persistence")
    persistence.setup(opts)
    
    -- Auto-restore only when opening nvim without arguments
    local argc = vim.fn.argc(-1)
    if argc == 0 then
      -- Check if there's a session for the current directory
      local session_file = opts.dir .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:gs?/?_?') .. '.vim'
      if vim.fn.filereadable(session_file) == 1 then
        -- Restore session after UI has loaded
        vim.schedule(function()
          persistence.load()
          -- Notify user that session was restored
          vim.notify("Session restored", vim.log.levels.INFO, { title = "Persistence" })
        end)
      end
    end
  end,
}