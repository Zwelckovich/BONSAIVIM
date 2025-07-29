-- Test nvim-spectre plugin configuration
vim.cmd([[set runtimepath+=.]])
vim.cmd([[runtime! plugin/plenary.vim]])

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim (minimal)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy with minimal config
require("lazy").setup({
  spec = {
    { import = "plugins.spectre" },
  },
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Force load spectre
vim.cmd([[Lazy load nvim-spectre]])

-- Test basic loading
local ok, spectre = pcall(require, "spectre")
if not ok then
  error("Failed to load spectre: " .. tostring(spectre))
end

print("✓ nvim-spectre loaded successfully")

-- Test keymaps existence
local keymaps = {
  { "n", "<leader>ss", "Search (Spectre)" },
  { "n", "<leader>sw", "Search word (Spectre)" },
  { "v", "<leader>sw", "Search selection (Spectre)" },
  { "n", "<leader>sp", "Search in file (Spectre)" },
  { "n", "<leader>sr", "Search and replace (Spectre)" },
}

local errors = {}
for _, map in ipairs(keymaps) do
  local mode, lhs, desc = unpack(map)
  local mapping = vim.fn.maparg(lhs, mode)
  if mapping == "" then
    table.insert(errors, string.format("Missing keymap: %s %s (%s)", mode, lhs, desc))
  else
    print(string.format("✓ Keymap found: %s %s -> %s", mode, lhs, desc))
  end
end

if #errors > 0 then
  error(table.concat(errors, "\n"))
end

-- Test configuration
local config_ok, _ = pcall(function()
  spectre.setup({})
end)

if not config_ok then
  error("Failed to setup spectre")
end

print("✓ nvim-spectre configuration valid")

-- Test color highlights
local highlights = {
  "SpectreSearch",
  "SpectreReplace", 
  "SpectreBorder",
  "SpectreDir",
  "SpectreFile",
  "SpectreBody",
  "SpectreHeader",
}

for _, hl in ipairs(highlights) do
  local hl_def = vim.api.nvim_get_hl(0, { name = hl })
  if vim.tbl_isempty(hl_def) then
    print("⚠ Missing highlight: " .. hl)
  else
    print("✓ Highlight defined: " .. hl)
  end
end

print("\n✅ All nvim-spectre tests passed!")
vim.cmd([[quit]])