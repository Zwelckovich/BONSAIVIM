# Which-Key.nvim v3 Configuration: window vs win

## Breaking Change: window → win

In which-key.nvim v3, the window configuration has been renamed from `window` to `win`.

### ❌ OLD (v2) Configuration - Using 'window'
```lua
require("which-key").setup({
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 1, 2, 1, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
})
```

### ✅ NEW (v3) Configuration - Using 'win'
```lua
require("which-key").setup({
  win = {
    -- Core window options
    no_overlap = true,      -- Don't overlap cursor
    padding = { 1, 2 },     -- [top/bottom, right/left]
    title = true,           -- Show title
    title_pos = "center",   -- Title position
    zindex = 1000,          -- Window z-index

    -- Additional vim window options
    wo = {
      winblend = 10,      -- 0-100 transparency
    },
    -- Additional buffer options
    bo = {},
  },
  -- Layout is separate from window config in v3
  layout = {
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
})
```

## Complete v3 Setup Example with BONSAI Colors

```lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    local wk = require("which-key")

    -- BONSAI color definitions
    local colors = {
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
      purple_primary = "#9882c7",
    }

    -- Apply BONSAI colors
    vim.api.nvim_set_hl(0, "WhichKey", { fg = colors.green_primary })
    vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = colors.blue_primary })
    vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = colors.text_secondary })
    vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = colors.text_muted })
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = colors.bg_primary })
    vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = colors.border_subtle, bg = colors.bg_primary })
    vim.api.nvim_set_hl(0, "WhichKeyValue", { fg = colors.yellow_primary })

    -- v3 configuration with 'win' instead of 'window'
    wk.setup({
      -- ✅ CORRECT: Use 'win' in v3
      win = {
        no_overlap = true,      -- Prevent overlap with cursor
        padding = { 1, 2 },     -- Padding: [top/bottom, right/left]
        title = true,           -- Show window title
        title_pos = "center",   -- Title position
        zindex = 1000,          -- Window stacking order

        -- Window-specific options
        wo = {
          winblend = 0,       -- 0 = opaque, 100 = transparent
        },
        -- Buffer-specific options
        bo = {},
      },
      -- Layout configuration (separate from window)
      layout = {
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      -- Other v3 options
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
    })

    -- Register groups using v3 add() method
    wk.add({
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>c", group = "code" },
      -- etc...
    })
  end,
}
```

## Key Differences Summary

| Feature | v2 | v3 |
|---------|----|----|
| Window config key | `window` | `win` |
| Border option | `window.border` | Removed (use default) |
| Position option | `window.position` | Removed (auto-positioned) |
| Margin option | `window.margin` | Removed |
| Padding format | `{ 1, 2, 1, 2 }` | `{ 1, 2 }` (simplified) |
| Window options | Mixed in window | Separate `wo` table |
| Buffer options | Not available | Separate `bo` table |
| Overlap prevention | Not available | `no_overlap` option |
| Z-index control | Not available | `zindex` option |

## Migration Tips

1. **Rename `window` to `win`** in your configuration
2. **Remove deprecated options**: `border`, `position`, `margin`
3. **Simplify padding**: From 4 values to 2 values
4. **Move vim options**: Put window-specific options in `wo` subtable
5. **Use v3 add() method**: For registering keymaps and groups
6. **Check health**: Run `:checkhealth which-key` after migration

## Your Current Configuration Status

Looking at your `which-key.lua` file, you're actually using a **hybrid approach**:
- You have `window` in the configuration (v2 style)
- But you're using `wk.add()` method (v3 style)

This might work due to backward compatibility, but for full v3 compliance, you should change `window` to `win` in your setup options.