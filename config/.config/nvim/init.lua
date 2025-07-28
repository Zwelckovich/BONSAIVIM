-- BONSAI Neovim Configuration
-- Minimal entry point that loads core configuration

-- Set leader key first (must be before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Load core configuration in order
require("config.options")  -- Neovim options must come first
require("config.lazy")     -- Plugin manager setup
require("config.keymaps")  -- Key mappings after plugins load