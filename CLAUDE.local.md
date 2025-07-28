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