-- BONSAI yazi.nvim configuration
-- Terminal file manager integration with floating window

return {
  "DreamMaoMao/yazi.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    -- Yazi keybindings under <leader>y
    { "<leader>yy", "<cmd>Yazi<cr>", desc = "Yazi open in current directory" },
    { "<leader>yw", "<cmd>Yazi cwd<cr>", desc = "Yazi open in working directory" },
    { "<leader>yt", "<cmd>Yazi toggle<cr>", desc = "Yazi toggle last state" },
  },
  config = function()
    -- Yazi is a simple plugin that provides :Yazi command
    -- No additional configuration needed - it works out of the box
    -- The floating window and file manager functionality is built-in
  end,
}