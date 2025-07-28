# 🌱 BONSAI Neovim Configuration

A minimal, purposeful Neovim configuration following BONSAI principles.

## Phase 1: Foundation (Complete)

This phase establishes the core configuration structure:

- **Package Management**: lazy.nvim with self-bootstrapping
- **Core Options**: Sensible Neovim defaults
- **Key Mappings**: Including German keyboard support
- **Directory Structure**: Modular plugin organization

### What's Included in Phase 1

- `init.lua` - Minimal entry point
- `lua/config/lazy.lua` - Package manager setup
- `lua/config/options.lua` - Core Neovim options
- `lua/config/keymaps.lua` - Essential key mappings

No plugins are installed yet - this is the pure foundation.

## Phase 2: Syntax & Understanding (Complete)

Added Treesitter for:
- Syntax highlighting with performance optimizations
- Code understanding and navigation
- Text objects for functions and classes
- Incremental selection
- Folding based on syntax tree
- Automatic parser installation for Python, JS/TS, HTML, CSS, Markdown, Lua

### What's New in Phase 2

- `lua/plugins/treesitter.lua` - Complete Treesitter configuration
- Performance optimization for large files (>1MB)
- Navigation shortcuts: `[f`/`]f` for functions, `[[`/`]]` for classes
- Smart text objects: `af`/`if` (function), `ac`/`ic` (class)

## Phase 3: Navigation & Search (Complete)

Added powerful navigation and search capabilities:
- **Telescope**: Fuzzy finding with ivy theme and BONSAI colors
- **Flash**: Lightning-fast character navigation
- **Which-key**: Interactive keybinding discovery

### What's New in Phase 3

- `lua/plugins/telescope.lua` - Fuzzy finder with fzf algorithm
- `lua/plugins/flash.lua` - Fast navigation with `s`/`S` keys
- `lua/plugins/which-key.lua` - Keybind hints with 500ms delay

### Key Navigation Features

- **Telescope** (`<leader>f` group):
  - `ff` - Find files
  - `fg` - Live grep
  - `fb` - Find buffers
  - `fh` - Find help
  - `fr` - Recent files
  - `fw` - Find word under cursor
  - `f/` - Search in current buffer

- **Flash Navigation**:
  - `s` - Jump forward to any character
  - `S` - Jump backward to any character
  - `<leader>jt` - Flash Treesitter navigation

- **Which-key**: Press `<leader>` and wait 500ms to see available commands

## Quick Start

1. **Test the configuration**:
   ```bash
   ./run_nvim.sh
   ```

2. **Or install permanently**:
   ```bash
   ./symlink_nvim.sh         # Interactive (choose clean/adopt/cancel)
   ./symlink_nvim_clean.sh   # Non-interactive clean install
   ```

See [USAGE.md](USAGE.md) for all running options.

## Features

- **Leader Key**: Space
- **Escape Alternative**: `jk` in insert mode
- **Quick Save**: `Ctrl+S` in any mode
- **German Keyboard**: `ö` → `[`, `ä` → `]`
- **Lightning Fast**: ~6ms startup time (well under 50ms target)

## Testing

Run the test script to verify configuration:
```bash
./test_config.sh
```

This will check:
- Startup time
- Configuration loads without errors
- Leader key is set correctly
- lazy.nvim is installed
- Key mappings work
- Core options are applied
- All plugins load correctly (Treesitter, Telescope, Flash, Which-key)

## Next Phases

- ~~Phase 2: Syntax & Understanding (treesitter)~~ ✅ Complete
- ~~Phase 3: Navigation & Search (telescope, flash, which-key)~~ ✅ Complete
- Phase 4: Language Intelligence (LSP + Mason & Conform)
- Phase 5: Code Assistance (Luasnip)
- Phase 6: Version Control (Gitsigns)
- Phase 7: UI Enhancement (Lualine & Undotree)
- Phase 8: Session & File Management (Persistence & Yazi)
- Phase 9: BONSAI Colorscheme & Final Polish

See `concept.md` for the complete vision.