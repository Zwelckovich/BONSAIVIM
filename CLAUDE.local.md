# CLAUDE.local.md - Project-Specific Learnings

## Project Structure Decision

### Date: 2025-07-28
### Structure Type: BONSAI
### LOCKED: Do not change unless user explicitly requests

### Detected Pattern:
- Configuration: Neovim config with Lua plugins
- Plugin Manager: lazy.nvim
- Structure: Standard Neovim config structure (init.lua, lua/config/, lua/plugins/)

## Environment-Specific Discoveries

### Neovim Plugin Configuration
- **Date**: 2025-07-28
- **Discovery**: conform.nvim requires `config` function, not `opts` table
- **Reason**: Plugin modules like `conform.util` are not available until after plugin loads
- **Solution**: Use `config = function()` instead of `opts = {}`

### LSP Keymaps
- **Date**: 2025-07-28
- **Discovery**: LSP keymaps are only registered when LSP attaches to a buffer
- **Testing**: Cannot test LSP keymaps in headless mode without opening a file
- **Solution**: Test keymap configuration presence in lazy.nvim spec instead

### Test Organization
- **Date**: 2025-07-28
- **Structure**: tests/ directory for all test files
- **Test Types**: 
  - Plugin verification (verify_plugins.lua)
  - LSP/formatting tests (test_lsp_conform.lua)
  - Integration tests (run_lsp_tests.sh)

### Formatting Tools
- **Date**: 2025-07-28
- **Available**: sed for basic text manipulation
- **Unavailable**: stylua (would need local installation)
- **Workaround**: Use sed for trailing whitespace removal, nvim for syntax checking

## BONSAI Compliance Notes

### Tool Usage
- ✅ Using lazy.nvim (minimal plugin manager)
- ✅ Using Mason for LSP management
- ✅ Using conform.nvim for formatting
- ❌ No global tool installations (stylua would need per-project install)

### Configuration Patterns
- All plugin configs in individual files under lua/plugins/
- Lazy loading where appropriate
- Minimal keybindings following vim conventions
- BONSAI color scheme integrated throughout

### nvim-cmp Integration
- **Date**: 2025-07-28
- **Discovery**: nvim-cmp is needed for proper LuaSnip integration
- **Reason**: Provides completion framework that works with snippet expansion
- **Solution**: Added cmp.lua with LuaSnip source and Tab navigation preserved for snippets

### Snippet Testing
- **Date**: 2025-07-28
- **Discovery**: nvim-cmp and LuaSnip load on InsertEnter event
- **Testing**: Need to force load plugins in headless tests with lazy.load()
- **Solution**: Modified test runner to explicitly load plugins before testing

### LSP Capabilities
- **Date**: 2025-07-28
- **Discovery**: LSP servers need nvim-cmp capabilities for better completion
- **Solution**: Integrated cmp_nvim_lsp.default_capabilities() in LSP config
- **Benefit**: Enhanced completion experience with snippet support

### Undotree Plugin
- **Date**: 2025-07-29
- **Discovery**: mbbill/undotree doesn't expose a Lua module (pure Vimscript plugin)
- **Testing**: Plugin verification must check command existence, not require module
- **Solution**: Test for :UndotreeToggle command and vim.g settings
- **Configuration**: Uses vim.g.undotree_* settings for all configuration

### Which-Key v3 Configuration
- **Date**: 2025-07-29
- **Discovery**: which-key.nvim v3 renamed 'window' option to 'win'
- **Current Status**: Using hybrid configuration (v2 'window' with v3 add() method)
- **Migration Path**: Change 'window' to 'win' for full v3 compliance
- **Deprecated Options**: border, position, margin (removed in v3)
- **New Options**: no_overlap, zindex, separate wo/bo tables

### Keymap Conflicts
- **Date**: 2025-07-29
- **Discovery**: Treesitter and gitsigns both used [c/]c for navigation
- **Conflict**: [c/]c was mapped for both class navigation (treesitter) and hunk navigation (gitsigns)
- **Solution**: Changed treesitter to use [[/]] for class navigation (matches concept.md)
- **Result**: Both plugins can coexist without keymap conflicts

### Lualine Configuration
- **Date**: 2025-07-29
- **Discovery**: Lualine doesn't automatically set statusline in headless mode
- **Reason**: Requires UI event triggers for full initialization
- **Testing**: Module loads successfully but config application needs UI context
- **Solution**: Test module loading and config presence, visual testing requires manual verification

### Undotree Lazy Loading
- **Date**: 2025-07-29
- **Discovery**: Undotree is lazy loaded on key press, not on startup
- **Testing**: Must force load with lazy.load() before checking vim.fn.exists()
- **Solution**: Updated verify_plugins.lua to force load undotree before testing
- **Configuration**: All settings (window layout, split width, etc.) apply correctly after loading

### Yazi.nvim Plugin
- **Date**: 2025-07-29
- **Discovery**: yazi.nvim is a simple command provider, not a complex plugin
- **Error**: "attempt to call field 'setup' (a nil value)"
- **Solution**: No setup() function needed - just provides :Yazi command
- **Configuration**: Minimal config with only keymaps, no opts or setup required

### Persistence.nvim Auto-Restore
- **Date**: 2025-07-29
- **Discovery**: Session auto-restore only works when nvim opened without arguments
- **Implementation**: Check vim.fn.argc(-1) == 0 before restoring
- **Location**: Sessions stored in stdpath("data") .. "/sessions/"
- **Exclusions**: Successfully excludes help, quickfix, terminal, and temporary buffers