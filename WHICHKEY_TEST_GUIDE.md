# Which-Key Testing Guide

## Quick Test

1. Open Neovim:
   ```bash
   cd /home/zwelch/projects/BONSAIVIM/config/.config/nvim
   nvim
   ```

2. Once in Neovim, press the space bar (leader key) and wait about 500ms

3. You should see a popup menu showing available key bindings organized by groups:
   - `+buffer` - Buffer operations
   - `+find` - Telescope find commands  
   - `+toggle` - Toggle settings
   - `+window` - Window management
   - `+quit` - Quit commands
   - etc.

## Testing Specific Commands

Try these leader key combinations:

- `<space>e` - Open file explorer
- `<space>ff` - Find files (Telescope)
- `<space>fg` - Find by grep (Telescope)
- `<space>tn` - Toggle relative line numbers
- `<space>bd` - Delete buffer
- `<space>qq` - Quit all

## Troubleshooting

If the which-key menu doesn't appear:

1. Check if which-key is loaded:
   ```vim
   :lua print(pcall(require, 'which-key'))
   ```

2. Manually trigger the which-key menu:
   ```vim
   :WhichKey
   :WhichKey <space>
   ```

3. Check the leader key:
   ```vim
   :echo mapleader
   ```
   (Should show a space character)

4. Run health check:
   ```vim
   :checkhealth which-key
   ```

## Expected Behavior

When you press `<space>` and wait, you should see a floating window at the bottom of the screen showing all available leader key mappings. The window uses BONSAI colors with a rounded border.

The deprecated warnings in the health check are expected and don't affect functionality - we're using the older but stable configuration format.