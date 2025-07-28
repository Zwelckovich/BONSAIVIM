-- BONSAI core keymaps
-- Minimal, purposeful key mappings that enhance vim's natural flow

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Escape alternative (faster than reaching for ESC)
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- German keyboard support (umlauts to brackets)
map({ "n", "v", "o" }, "ö", "[", { desc = "[ (German keyboard)" })
map({ "n", "v", "o" }, "Ö", "{", { desc = "{ (German keyboard)" })
map({ "n", "v", "o" }, "ä", "]", { desc = "] (German keyboard)" })
map({ "n", "v", "o" }, "Ä", "}", { desc = "} (German keyboard)" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window management
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>wc", "<C-w>c", { desc = "Close current window" })
map("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
map("n", "<leader>w=", "<C-w>=", { desc = "Balance window sizes" })

-- Resize windows with arrows
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", ":bdelete!<CR>", { desc = "Force delete buffer" })

-- Better movement (move by visual lines)
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Center screen after jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Maintain cursor position with J
map("n", "J", "mzJ`z", { desc = "Join lines keeping cursor position" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Paste without losing register
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

-- Clear search highlighting
map("n", "<leader>sc", ":nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Toggle settings
map("n", "<leader>tn", ":set relativenumber!<CR>", { desc = "Toggle relative numbers" })
map("n", "<leader>tw", ":set wrap!<CR>", { desc = "Toggle line wrap" })
map("n", "<leader>ts", ":set spell!<CR>", { desc = "Toggle spell check" })
map("n", "<leader>th", ":set hlsearch!<CR>", { desc = "Toggle search highlight" })

-- Quick save
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map({ "i", "v" }, "<C-s>", "<ESC>:w<CR>", { desc = "Save file" })

-- Quit shortcuts
map("n", "<leader>qq", ":qa<CR>", { desc = "Quit all" })
map("n", "<leader>qQ", ":qa!<CR>", { desc = "Force quit all" })

-- Navigate quickfix list
map("n", "]q", ":cnext<CR>", { desc = "Next quickfix item" })
map("n", "[q", ":cprev<CR>", { desc = "Previous quickfix item" })

-- Make file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })

-- Replace word under cursor
map("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Open netrw (temporary until yazi is configured)
map("n", "<leader>e", ":Ex<CR>", { desc = "Open file explorer" })