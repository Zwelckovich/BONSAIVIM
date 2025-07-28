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

## Next Phases

- Phase 2: Syntax & Understanding (treesitter)
- Phase 3: Navigation & Search (telescope, flash)
- Phase 4: Language Intelligence (LSP + Mason & Conform)
- Phase 5: Code Assistance (Luasnip & Which-key)
- Phase 6: Version Control (Gitsigns)
- Phase 7: UI Enhancement (Lualine & Undotree)
- Phase 8: Session & File Management (Persistence & Yazi)
- Phase 9: BONSAI Colorscheme & Final Polish

See `concept.md` for the complete vision.