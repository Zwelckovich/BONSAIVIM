" Debug script to check leader key and which-key setup
echo "Leader key check:"
echo "vim.g.mapleader = " . g:mapleader
echo "\nChecking which-key..."

" Load which-key and check
lua << EOF
local ok, wk = pcall(require, "which-key")
if ok then
  print("Which-key loaded successfully")
  
  -- Try to show the which-key window
  vim.defer_fn(function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Space>", true, false, true), 'n', false)
  end, 1000)
else
  print("Failed to load which-key:", wk)
end
EOF

echo "\nPress <space> now to test which-key menu..."