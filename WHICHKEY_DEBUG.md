# Which-Key Debug Guide

## Current Status
I've reverted which-key to a minimal configuration to restore functionality.

## Test Steps

1. **Test Basic Functionality**:
   ```bash
   cd ~/projects/BONSAIVIM
   nvim config/.config/nvim/init.lua
   ```
   
   Then:
   - Press `<space>` (leader key) and wait ~500ms
   - You should see the which-key menu at the bottom

2. **Check Plugin Health**:
   In Neovim, run:
   ```vim
   :checkhealth which-key
   ```

3. **Verify Keymaps**:
   ```vim
   :WhichKey <space>
   ```

4. **Check for Errors**:
   ```vim
   :messages
   ```

## Gradual Right Panel Configuration

Once basic functionality is confirmed, we can try adding the right panel configuration step by step:

### Step 1: Add Width Setting
```lua
win = {
  border = "rounded",
  width = 0.3,  -- 30% of screen
},
```

### Step 2: Add Position
For which-key v3, right-side positioning uses `col`:
```lua
win = {
  border = "rounded",
  width = 0.3,
  col = -1,  -- Negative value positions from right
  row = 0,   -- Top of screen
},
```

### Step 3: Add Height
```lua
win = {
  border = "rounded",
  width = 0.3,
  col = -1,
  row = 0,
  height = { min = 4, max = 0.8 },
},
```

## Alternative: Using Preset
Which-key v3 has presets. Try:
```lua
{
  preset = "modern",  -- or "helix" for right-side panel
  win = {
    border = "rounded",
  },
}
```

## Troubleshooting

1. **Plugin Not Loading**:
   - Run `:Lazy` and check if which-key is loaded
   - Try `:Lazy sync` to update plugins

2. **Keymaps Not Working**:
   - Check if leader key is set: `:echo mapleader`
   - Should show a space character

3. **No Menu Appears**:
   - Try increasing timeout: `vim.o.timeoutlen = 1000`
   - Check for conflicting plugins

## Version Check
To check which-key version:
```vim
:lua print(require("lazy.core.config").plugins["which-key.nvim"].version)
```

Latest v3 uses different configuration format than v2.