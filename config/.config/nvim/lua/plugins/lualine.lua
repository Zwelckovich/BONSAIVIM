-- BONSAI lualine configuration
-- Minimal statusline with essential information and BONSAI aesthetic

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    -- BONSAI color definitions
    local colors = {
      bg_primary = "#151922",
      bg_secondary = "#1e242e",
      bg_elevated = "#232933",
      text_primary = "#e6e8eb",
      text_secondary = "#b8bcc8",
      text_muted = "#8b92a5",
      green_primary = "#7c9885",
      blue_primary = "#82a4c7",
      yellow_primary = "#c7a882",
      red_primary = "#c78289",
      purple_primary = "#9882c7",
      orange_primary = "#c7975c",
    }

    -- BONSAI theme for lualine
    local bonsai_theme = {
      normal = {
        a = { bg = colors.green_primary, fg = colors.bg_primary, gui = "bold" },
        b = { bg = colors.bg_elevated, fg = colors.text_secondary },
        c = { bg = colors.bg_secondary, fg = colors.text_muted },
      },
      insert = {
        a = { bg = colors.blue_primary, fg = colors.bg_primary, gui = "bold" },
        b = { bg = colors.bg_elevated, fg = colors.text_secondary },
        c = { bg = colors.bg_secondary, fg = colors.text_muted },
      },
      visual = {
        a = { bg = colors.purple_primary, fg = colors.bg_primary, gui = "bold" },
        b = { bg = colors.bg_elevated, fg = colors.text_secondary },
        c = { bg = colors.bg_secondary, fg = colors.text_muted },
      },
      replace = {
        a = { bg = colors.red_primary, fg = colors.bg_primary, gui = "bold" },
        b = { bg = colors.bg_elevated, fg = colors.text_secondary },
        c = { bg = colors.bg_secondary, fg = colors.text_muted },
      },
      command = {
        a = { bg = colors.yellow_primary, fg = colors.bg_primary, gui = "bold" },
        b = { bg = colors.bg_elevated, fg = colors.text_secondary },
        c = { bg = colors.bg_secondary, fg = colors.text_muted },
      },
      inactive = {
        a = { bg = colors.bg_secondary, fg = colors.text_muted },
        b = { bg = colors.bg_secondary, fg = colors.text_muted },
        c = { bg = colors.bg_secondary, fg = colors.text_muted },
      },
    }

    -- Minimal diagnostic configuration
    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = "● ", warn = "● " },
      colored = true,
      update_in_insert = false,
      always_visible = false,
      diagnostics_color = {
        error = { fg = colors.red_primary },
        warn = { fg = colors.yellow_primary },
      },
    }

    -- Git diff configuration
    local diff = {
      "diff",
      colored = true,
      symbols = { added = "+", modified = "~", removed = "-" },
      diff_color = {
        added = { fg = colors.green_primary },
        modified = { fg = colors.yellow_primary },
        removed = { fg = colors.red_primary },
      },
    }

    return {
      options = {
        theme = bonsai_theme,
        component_separators = { left = "", right = "" },  -- Flat design, no separators
        section_separators = { left = "", right = "" },    -- Flat design, no separators
        disabled_filetypes = {
          statusline = { "dashboard", "lazy", "mason", "help", "NvimTree" },
        },
        globalstatus = true,  -- Single statusline for all windows
      },
      sections = {
        lualine_a = { "mode" },  -- Essential: current mode
        lualine_b = { 
          "branch",              -- Essential: git branch
          diff,                  -- Essential: git changes
          diagnostics,           -- Essential: errors/warnings
        },
        lualine_c = {
          { "filename", path = 1, symbols = { modified = "●", readonly = "🔒" } },  -- Essential: filename with status
        },
        lualine_x = { 
          { "searchcount", maxcount = 999, timeout = 500 },  -- Useful: search matches
          "filetype",  -- Essential: file type
        },
        lualine_y = { "progress" },     -- Essential: file position percentage
        lualine_z = { "location" },     -- Essential: line:column
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
