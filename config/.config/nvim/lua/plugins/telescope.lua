-- BONSAI telescope.nvim configuration
-- Fuzzy finding with a clean, minimal interface

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  event = "VeryLazy",
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    -- BONSAI color definitions
    local colors = {
      bg_deep = "#0a0e14",
      bg_primary = "#151922",
      bg_secondary = "#1e242e",
      bg_elevated = "#232933",
      text_primary = "#e6e8eb",
      text_secondary = "#b8bcc8",
      text_muted = "#8b92a5",
      border_subtle = "#2d3441",
      green_primary = "#7c9885",
      blue_primary = "#82a4c7",
      yellow_primary = "#c7a882",
    }

    -- Apply BONSAI colors to Telescope
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, "TelescopeNormal", { bg = colors.bg_primary })
    set_hl(0, "TelescopeBorder", { fg = colors.border_subtle, bg = colors.bg_primary })
    set_hl(0, "TelescopePromptNormal", { bg = colors.bg_secondary })
    set_hl(0, "TelescopePromptBorder", { fg = colors.border_subtle, bg = colors.bg_secondary })
    set_hl(0, "TelescopePromptTitle", { fg = colors.green_primary, bg = colors.bg_secondary })
    set_hl(0, "TelescopePreviewTitle", { fg = colors.blue_primary, bg = colors.bg_primary })
    set_hl(0, "TelescopeResultsTitle", { fg = colors.yellow_primary, bg = colors.bg_primary })
    set_hl(0, "TelescopeSelection", { bg = colors.bg_elevated, fg = colors.text_primary })
    set_hl(0, "TelescopeSelectionCaret", { fg = colors.green_primary, bg = colors.bg_elevated })
    set_hl(0, "TelescopeMatching", { fg = colors.green_primary, bold = true })

    telescope.setup({
      defaults = {
        -- Floating window layout (like yazi) with 90% dimensions
        layout_strategy = "flex",
        layout_config = {
          width = 0.9,
          height = 0.9,
          prompt_position = "top",
          flex = {
            flip_columns = 120,  -- Switch to horizontal layout on wider windows
          },
          horizontal = {
            preview_width = 0.55,
            preview_cutoff = 120,
          },
          vertical = {
            preview_height = 0.5,
            preview_cutoff = 40,
          },
        },
        sorting_strategy = "ascending",
        winblend = 0,  -- No transparency
        border = true,
        borderchars = {
          prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
          results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },

        -- UI elements
        prompt_prefix = "  ",
        selection_caret = " ",
        entry_prefix = "  ",

        -- Performance optimizations
        file_ignore_patterns = {
          "^.git/",
          "^node_modules/",
          "^__pycache__/",
          "%.pyc$",
          "%.pyo$",
          "%.class$",
          "%.cache$",
        },

        -- Preview settings
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        -- Mappings
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<esc>"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = false,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
          },
        },
        -- Use ivy theme (bottom pane) for current buffer search
        current_buffer_fuzzy_find = {
          theme = "ivy",
          layout_config = {
            height = 0.4,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load extensions
    telescope.load_extension("fzf")

    -- Set up keymaps
    local map = vim.keymap.set

    -- Find operations
    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find grep" })
    map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
    map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
    map("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })
    map("n", "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in current buffer" })

    -- Git operations (for future gitsigns integration)
    map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
    map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })

    -- LSP operations (for future LSP integration)
    map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })
    map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Find symbols" })
  end,
}