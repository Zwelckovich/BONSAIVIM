-- BONSAI bufferline configuration
-- Visual buffer tabs like browser tabs

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  config = function()
    local bufferline = require("bufferline")
    
    bufferline.setup({
      options = {
        mode = "buffers", -- Show buffers as tabs
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },
        themable = true,
        numbers = "none", -- Don't show buffer numbers
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = "▎", -- This is the indicator shown on the active buffer
          style = "icon",
        },
        buffer_close_icon = "✗",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp", -- Show diagnostic indicators
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " ✗ "
              or (e == "warning" and " ⚠ " or " ➤ ")
            s = s .. n .. sym
          end
          return s
        end,
        offsets = {
          {
            filetype = "undotree",
            text = "Undo History",
            text_align = "center",
            separator = true,
          },
          {
            filetype = "yazi",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        move_wraps_at_ends = false,
        separator_style = "thin", -- Options: "slant", "slope", "thick", "thin"
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_after_current",
      },
      highlights = {
        -- Background colors
        fill = {
          bg = "#0a0e14", -- BONSAI background deep
        },
        background = {
          fg = "#8b92a5", -- BONSAI text muted
          bg = "#151922", -- BONSAI background primary
        },
        
        -- Active buffer (current tab)
        buffer_selected = {
          fg = "#e6e8eb", -- BONSAI text primary
          bg = "#232933", -- BONSAI background elevated
          bold = false,
          italic = false,
        },
        
        -- Visible but not active buffers
        buffer_visible = {
          fg = "#b8bcc8", -- BONSAI text secondary
          bg = "#1e242e", -- BONSAI background secondary
        },
        
        -- Separators
        separator = {
          fg = "#2d3441", -- BONSAI border subtle
          bg = "#151922",
        },
        separator_selected = {
          fg = "#2d3441",
          bg = "#232933",
        },
        separator_visible = {
          fg = "#2d3441",
          bg = "#1e242e",
        },
        
        -- Indicators
        indicator_selected = {
          fg = "#7c9885", -- BONSAI green primary
          bg = "#232933",
        },
        
        -- Modified indicator
        modified = {
          fg = "#c7a882", -- BONSAI yellow primary
          bg = "#151922",
        },
        modified_selected = {
          fg = "#c7a882",
          bg = "#232933",
        },
        
        -- Close button
        close_button = {
          fg = "#8b92a5",
          bg = "#151922",
        },
        close_button_selected = {
          fg = "#c78289", -- BONSAI red primary
          bg = "#232933",
        },
        
        -- Diagnostics
        diagnostic = {
          fg = "#8b92a5",
          bg = "#151922",
        },
        diagnostic_selected = {
          fg = "#e6e8eb",
          bg = "#232933",
        },
        error = {
          fg = "#c78289", -- BONSAI red primary
          bg = "#151922",
        },
        error_selected = {
          fg = "#c78289",
          bg = "#232933",
        },
        warning = {
          fg = "#c7a882", -- BONSAI yellow primary
          bg = "#151922",
        },
        warning_selected = {
          fg = "#c7a882",
          bg = "#232933",
        },
      },
    })
    
    -- Additional keymaps for buffer management
    local map = vim.keymap.set
    
    -- Buffer management
    map("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
    map("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Pick buffer to close" })
    map("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close buffers to the left" })
    map("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", { desc = "Close buffers to the right" })
    map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
    
    -- Move buffers (reorder tabs)
    map("n", "<A-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
    map("n", "<A-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })
  end,
}