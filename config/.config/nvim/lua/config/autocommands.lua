-- BONSAI Autocommands
-- Performance optimizations and buffer-local settings

local api = vim.api
local augroup = api.nvim_create_augroup
local autocmd = api.nvim_create_autocmd

-- Load diagnostic utilities
require("config.diagnostic-utils")

-- BONSAI Performance Group
local perf_group = augroup("BonsaiPerformance", { clear = true })

-- Disable syntax highlighting for large files (>1MB or >5000 lines)
autocmd({ "BufReadPre", "FileReadPre" }, {
  group = perf_group,
  callback = function()
    local size = vim.fn.getfsize(vim.fn.expand("<afile>"))
    if size > 1024 * 1024 or size == -2 then
      -- File is larger than 1MB or getfsize failed (large file)
      vim.cmd("syntax off")
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.undolevels = -1
      vim.opt_local.undofile = false
      vim.opt_local.swapfile = false
      vim.opt_local.loadplugins = false
      vim.opt_local.spell = false
      vim.opt_local.wrap = false
      vim.opt_local.cursorline = false
      vim.notify("Large file detected - disabled syntax and features for performance", vim.log.levels.INFO)
    end
  end,
})

-- Check line count for existing buffers
autocmd("BufReadPost", {
  group = perf_group,
  callback = function()
    local lines = api.nvim_buf_line_count(0)
    if lines > 5000 then
      vim.cmd("syntax off")
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.cursorline = false
      vim.notify("Large file detected (>5000 lines) - disabled syntax for performance", vim.log.levels.INFO)
    end
  end,
})

-- Optimize cursor hold time for better responsiveness
autocmd("CursorHold", {
  group = perf_group,
  callback = function()
    -- Trigger CursorHold events less frequently in insert mode
    if vim.fn.mode() == "i" then
      vim.opt.updatetime = 1000
    else
      vim.opt.updatetime = 200
    end
  end,
})

-- Buffer-local optimizations
local buffer_group = augroup("BonsaiBufferLocal", { clear = true })

-- Terminal buffer settings
autocmd("TermOpen", {
  group = buffer_group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = false
    vim.cmd("startinsert")
  end,
})

-- Quickfix and location list settings
autocmd("FileType", {
  group = buffer_group,
  pattern = { "qf", "help", "man" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.colorcolumn = ""
    -- Allow easy quit
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
  end,
})

-- Markdown settings
autocmd("FileType", {
  group = buffer_group,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
    vim.opt_local.linebreak = true
  end,
})

-- Git commit messages
autocmd("FileType", {
  group = buffer_group,
  pattern = { "gitcommit", "gitrebase" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.colorcolumn = "72"
  end,
})

-- Auto-save and restore view
local view_group = augroup("BonsaiView", { clear = true })

-- Save view when leaving buffer
autocmd("BufWinLeave", {
  group = view_group,
  pattern = "*.*",
  callback = function()
    if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! mkview")
    end
  end,
})

-- Restore view when entering buffer
autocmd("BufWinEnter", {
  group = view_group,
  pattern = "*.*",
  callback = function()
    if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! loadview")
    end
  end,
})

-- Remove trailing whitespace on save (for code files only)
local cleanup_group = augroup("BonsaiCleanup", { clear = true })

autocmd("BufWritePre", {
  group = cleanup_group,
  pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx", "*.css", "*.html", "*.md" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Highlight yanked text briefly
local highlight_group = augroup("BonsaiHighlight", { clear = true })

autocmd("TextYankPost", {
  group = highlight_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Auto-resize splits when window is resized
local resize_group = augroup("BonsaiResize", { clear = true })

autocmd("VimResized", {
  group = resize_group,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Return to last edit position when opening files
local last_pos_group = augroup("BonsaiLastPosition", { clear = true })

autocmd("BufReadPost", {
  group = last_pos_group,
  callback = function()
    local mark = api.nvim_buf_get_mark(0, '"')
    local lcount = api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Faster startup by delaying some plugin loading
local startup_group = augroup("BonsaiStartup", { clear = true })

-- Load BONSAI colorscheme after UI enters
autocmd("UIEnter", {
  group = startup_group,
  once = true,
  callback = function()
    -- Apply BONSAI colors
    require("bonsai.colors").setup()

    -- Set vim options that affect appearance
    vim.opt.termguicolors = true
    vim.g.colors_name = "bonsai"
  end,
})

-- Performance monitoring for development
if vim.env.NVIM_PROFILE then
  autocmd("UIEnter", {
    group = startup_group,
    once = true,
    callback = function()
      local startuptime = vim.fn.reltimefloat(vim.fn.reltime(vim.g.startup_time))
      vim.notify(string.format("Startup time: %.3f ms", startuptime * 1000), vim.log.levels.INFO)
    end,
  })
end