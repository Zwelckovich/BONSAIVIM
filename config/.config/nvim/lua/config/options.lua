-- BONSAI Neovim core options
-- Performance-optimized settings for a minimal, fast experience

local opt = vim.opt

-- Performance options (these come first for faster startup)
opt.updatetime = 200          -- Faster completion and diagnostics
opt.timeoutlen = 400          -- Faster key sequence completion
opt.ttimeoutlen = 0           -- No delay for escape key
opt.redrawtime = 1500         -- Prevent hanging on complex files
opt.lazyredraw = true         -- Don't redraw during macros
opt.synmaxcol = 240           -- Limit syntax highlighting for long lines

-- Enable filetype detection (REQUIRED for conform.nvim and syntax highlighting)
vim.cmd([[filetype plugin indent on]])

-- Essential editor behavior
opt.number = true             -- Show line numbers
opt.relativenumber = true     -- Relative line numbers for easy jumping
opt.signcolumn = "yes:1"      -- Always show sign column to prevent shifting
opt.cursorline = true         -- Highlight current line
opt.scrolloff = 8             -- Keep 8 lines visible above/below cursor
opt.sidescrolloff = 8         -- Keep 8 columns visible left/right of cursor
opt.wrap = false              -- Don't wrap lines by default

-- Indentation (spaces for consistency across environments)
opt.expandtab = true          -- Use spaces instead of tabs
opt.tabstop = 2               -- 2 spaces per tab
opt.shiftwidth = 2            -- 2 spaces per indent level
opt.softtabstop = 2           -- 2 spaces per tab in insert mode
opt.shiftround = true         -- Round indent to multiple of shiftwidth
opt.smartindent = true        -- Smart autoindenting on new lines

-- Search behavior
opt.ignorecase = true         -- Case-insensitive search
opt.smartcase = true          -- Case-sensitive if uppercase present
opt.hlsearch = true           -- Highlight search results
opt.incsearch = true          -- Show matches while typing
opt.gdefault = true           -- Global substitution by default

-- Split behavior
opt.splitbelow = true         -- Horizontal splits open below
opt.splitright = true         -- Vertical splits open to the right
opt.splitkeep = "screen"      -- Keep screen position when splitting

-- File handling
opt.autowrite = true          -- Auto-save before commands like :next
opt.hidden = true             -- Allow hidden buffers
opt.backup = false            -- No backup files
opt.writebackup = false       -- No backup before overwriting
opt.swapfile = false          -- No swap files
opt.undofile = true           -- Persistent undo history
opt.undolevels = 10000        -- Maximum undo levels

-- Visual improvements
opt.termguicolors = true      -- True color support
opt.pumheight = 10            -- Popup menu height
opt.pumblend = 10             -- Popup menu transparency
opt.winblend = 10             -- Window transparency
opt.conceallevel = 0          -- Don't hide text
opt.list = true               -- Show invisible characters
opt.listchars = {             -- Define invisible characters
  tab = "→ ",
  trail = "·",
  extends = "…",
  precedes = "…",
  nbsp = "␣",
}
opt.fillchars = {             -- Cleaner window separators
  vert = "│",
  fold = " ",
  foldopen = "▼",
  foldclose = "▶",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Mouse and clipboard
opt.mouse = "a"               -- Enable mouse in all modes
opt.clipboard = "unnamedplus" -- Use system clipboard

-- Completion behavior
opt.completeopt = "menuone,noinsert,noselect" -- Better completion
opt.wildmode = "longest:full,full"            -- Command line completion
opt.wildignore = {            -- Ignore these files in completion
  "*.o", "*.a", "*.la", "*.so", "*.swp", "*.swo",
  "*~", "*.pyc", "__pycache__", ".DS_Store",
  "*/node_modules/*", "*/.git/*", "*/dist/*", "*/build/*"
}

-- Session options (for persistence plugin)
opt.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp"

-- Disable providers we don't use (faster startup)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0