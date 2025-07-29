# Testing Which-Key Right Panel Configuration

## What Changed
The which-key panel now appears on the **right side** of the screen instead of the bottom, with a vertical layout that displays each section in its own row.

## Configuration Details
- **Position**: Right side of the screen
- **Width**: Minimum 30 columns, maximum 50 columns
- **Height**: Adjusts based on content (up to 80% of screen height)
- **Layout**: Vertical with left-aligned columns
- **Spacing**: 3 spaces between columns

## How to Test

1. **Open Neovim**:
   ```bash
   cd ~/projects/BONSAIVIM
   nvim config/.config/nvim/init.lua
   ```

2. **Trigger Which-Key**:
   - Press `<space>` (the leader key)
   - Wait ~500ms for the panel to appear

3. **Verify the Layout**:
   - The panel should appear on the **right side** of your screen
   - Each group (buffer, code, find, git, etc.) should be displayed vertically
   - The panel should have a rounded border with BONSAI colors

4. **Test Different Levels**:
   - Press `<space>f` to see the "find" submenu
   - Press `<space>c` to see the "code" submenu
   - Each submenu should also appear on the right side

## Expected Behavior

Instead of a bottom panel like this:
```
+buffer  +code  +find  +git  +toggle  +window
```

You should see a right-side panel with vertical layout:
```
┌─────────────────┐
│ +buffer         │
│ +code           │
│ +diagnostics    │
│ +find           │
│ +git            │
│ +hunk           │
│ +jump           │
│ +markdown       │
│ +persistence    │
│ +quit           │
│ +search         │
│ +toggle         │
│ +window         │
│ +execute        │
│ +yazi           │
└─────────────────┘
```

## Troubleshooting

If the panel still appears at the bottom:
1. Make sure you're using the correct config directory
2. Try `:Lazy sync` to ensure which-key is updated
3. Check `:checkhealth which-key` for any issues
4. Restart Neovim completely

## Reverting Changes

If you prefer the bottom layout, you can remove the position and layout configuration by editing `lua/plugins/which-key.lua` and changing the setup_opts back to just:
```lua
local setup_opts = vim.tbl_deep_extend("force", {
  win = {
    border = "rounded",
  },
}, opts)
```