# BONSAI Colorscheme Configuration

The BONSAI Neovim configuration comes with its own beautiful dark theme by default, but you can also use other popular colorschemes.

## Available Colorschemes

1. **BONSAI** (default) - Our custom zen-inspired dark theme
2. **Tokyo Night** - A clean, dark theme with great contrast
3. **Catppuccin** - A soothing pastel theme
4. **Nightfox** - A highly customizable dark theme

## How to Use

### Method 1: Cycle Through Themes
Press `<leader>tc` to cycle through all available colorschemes. The change is temporary and will reset to your default on restart.

### Method 2: Set a Default Theme
To set a different default colorscheme, add this to your local config:

```lua
-- In ~/.config/nvim/lua/config/local.lua (create if doesn't exist)
vim.g.bonsai_colorscheme = "tokyonight"  -- or "catppuccin", "nightfox", "bonsai"
```

### Method 3: Direct Command
You can also switch themes directly:

```vim
:colorscheme tokyonight
:colorscheme catppuccin  
:colorscheme nightfox
:colorscheme bonsai
```

## Tokyo Night Variants

Tokyo Night comes with multiple styles. To change the style:

```lua
-- In your local config
vim.g.tokyonight_style = "storm"  -- Options: storm, moon, night, day
```

## Catppuccin Flavours

Catppuccin has different flavours:

```lua
-- Before loading the colorscheme
vim.g.catppuccin_flavour = "mocha"  -- Options: latte, frappe, macchiato, mocha
```

## Adding More Colorschemes

To add more colorschemes, edit `lua/plugins/colorschemes.lua` and add your favorite theme following the same pattern.

## Tips

- The BONSAI theme is optimized for the rest of the configuration
- Other themes will work but may not have perfect integration with all UI elements
- You can always return to BONSAI by pressing `<leader>tc` until it appears
- Your theme preference persists only for the current session unless you set `vim.g.bonsai_colorscheme`

## Troubleshooting

If colorscheme cycling stops working:
- The cycling uses an index tracker to reliably switch between themes
- The order is: bonsai → tokyonight → catppuccin → nightfox → (back to bonsai)
- If a colorscheme fails to load, it will reset to BONSAI and notify you