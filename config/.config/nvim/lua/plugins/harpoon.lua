-- BONSAI harpoon configuration
-- Quick file navigation with marks

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    -- Harpoon menu and mark management
    { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
    { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
    { "<leader>hr", function() require("harpoon"):list():remove() end, desc = "Harpoon remove file" },
    { "<leader>hc", function() require("harpoon"):list():clear() end, desc = "Harpoon clear all" },
    
    -- Quick navigation with number keys
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
    { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon file 5" },
    { "<leader>6", function() require("harpoon"):list():select(6) end, desc = "Harpoon file 6" },
    { "<leader>7", function() require("harpoon"):list():select(7) end, desc = "Harpoon file 7" },
    { "<leader>8", function() require("harpoon"):list():select(8) end, desc = "Harpoon file 8" },
    { "<leader>9", function() require("harpoon"):list():select(9) end, desc = "Harpoon file 9" },
    
    -- Navigate through harpoon list
    { "<leader>hn", function() require("harpoon"):list():next() end, desc = "Harpoon next" },
    { "<leader>hp", function() require("harpoon"):list():prev() end, desc = "Harpoon previous" },
    
    -- Attach current file to specific position
    { "<leader>h1", function() require("harpoon"):list():replace_at(1) end, desc = "Attach to harpoon 1" },
    { "<leader>h2", function() require("harpoon"):list():replace_at(2) end, desc = "Attach to harpoon 2" },
    { "<leader>h3", function() require("harpoon"):list():replace_at(3) end, desc = "Attach to harpoon 3" },
    { "<leader>h4", function() require("harpoon"):list():replace_at(4) end, desc = "Attach to harpoon 4" },
    { "<leader>h5", function() require("harpoon"):list():replace_at(5) end, desc = "Attach to harpoon 5" },
    { "<leader>h6", function() require("harpoon"):list():replace_at(6) end, desc = "Attach to harpoon 6" },
    { "<leader>h7", function() require("harpoon"):list():replace_at(7) end, desc = "Attach to harpoon 7" },
    { "<leader>h8", function() require("harpoon"):list():replace_at(8) end, desc = "Attach to harpoon 8" },
    { "<leader>h9", function() require("harpoon"):list():replace_at(9) end, desc = "Attach to harpoon 9" },
    
    -- Quick navigation with Control (alternative)
    { "<C-h>", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
    { "<C-t>", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
    { "<C-n>", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
  },
  config = function()
    local harpoon = require("harpoon")
    
    harpoon:setup({
      settings = {
        -- Save on toggle instead of on every add/remove
        save_on_toggle = true,
        -- Sync on UI close
        sync_on_ui_close = true,
        -- Key to use for saving the harpoon file
        key = function()
          return vim.loop.cwd()
        end,
      },
    })
    
    -- Optional: Add telescope extension for harpoon
    local ok, telescope = pcall(require, "telescope")
    if ok then
      pcall(telescope.load_extension, "harpoon")
      
      -- Additional telescope integration
      vim.keymap.set("n", "<leader>ht", function()
        local conf = require("telescope.config").values
        local harpoon_files = require("harpoon"):list()
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end
        
        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            map("i", "<C-d>", function()
              local state = require("telescope.actions.state")
              local selected_entry = state.get_selected_entry()
              local current_picker = state.get_current_picker(prompt_bufnr)
              
              table.remove(harpoon_files.items, selected_entry.index)
              current_picker:refresh(
                require("telescope.finders").new_table({
                  results = file_paths,
                }),
                { reset_prompt = true }
              )
            end)
            return true
          end,
        }):find()
      end, { desc = "Harpoon telescope" })
    end
  end,
}