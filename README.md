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

## Phase 4: Language Intelligence (Complete)

Added LSP support and code formatting:
- **Mason**: Automatic LSP server installation and management
- **LSP**: Language servers for Python (pyright), TypeScript/JavaScript, Tailwind CSS
- **Conform**: Code formatting with ruff (Python) and prettier (JS/TS/CSS/HTML/Markdown)
- **Diagnostics**: Errors shown in virtual text, full diagnostics on hover

### What's New in Phase 4

- `lua/plugins/lsp.lua` - Complete LSP configuration with Mason
- `lua/plugins/conform.lua` - Format on save with 1000ms timeout
- Automatic LSP server installation via Mason
- Smart code actions and navigation

### Key LSP Features

- **Code Navigation**:
  - `gd` - Go to definition
  - `gi` - Go to implementation  
  - `gr` - Go to references
  - `K` - Hover documentation

- **Code Actions** (`<leader>c` group):
  - `ca` - Code action
  - `cf` - Code format
  - `cr` - Code rename
  - `cd` - Code definition
  - `ci` - Code implementation
  - `ch` - Code hover
  - `cs` - Code signature help

- **Diagnostics** (`<leader>d` group):
  - `df` - Diagnostics float
  - `dd` - Diagnostics list
  - `dn` - Next diagnostic
  - `dp` - Previous diagnostic
  - `[d`/`]d` - Navigate diagnostics

- **Formatting**: Automatic format on save with conform.nvim
  - Python: ruff (replaces black, isort, flake8)
  - JS/TS/CSS/HTML/Markdown: prettier
  - Lua: stylua (when available)

## Phase 5: Code Assistance (Complete)

Added snippet support with LuaSnip and completion with nvim-cmp:
- **LuaSnip**: Advanced snippet engine with multiple format support
- **nvim-cmp**: Completion framework with LSP integration
- **Tab Navigation**: Tab to expand/jump forward, Shift-Tab to jump backward
- **Multiple Formats**: VSCode and SnipMate snippet compatibility
- **friendly-snippets**: Community-maintained snippet collection

### What's New in Phase 5

- `lua/plugins/luasnip.lua` - Complete snippet configuration
- `lua/plugins/cmp.lua` - Completion engine with BONSAI styling
- Integrated nvim-cmp with LSP for better completions
- Custom snippets for Python and JavaScript

### Key Snippet Features

- **Snippet Expansion**:
  - `Tab` - Expand snippet or jump to next placeholder
  - `Shift-Tab` - Jump to previous placeholder
  - `Ctrl-j`/`Ctrl-k` - Navigate choice nodes in snippets

- **Python Snippets**:
  - `docstring` - Generate Python docstring with type hints
  - `deft` - Type-hinted function definition
  - `main` - if __name__ == "__main__" block

- **JavaScript/React Snippets**:
  - `arrow` - ES6 arrow function
  - `rfc` - React functional component
  - `useState` - React useState hook
  - `useEffect` - React useEffect hook

- **Completion Sources**:
  - LSP completions (highest priority)
  - Snippet completions
  - Buffer word completions
  - File path completions

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

Run the test scripts to verify configuration:
```bash
./test_config.sh          # Basic configuration tests
./run_all_tests.sh        # Comprehensive test suite
```

This will check:
- Startup time
- Configuration loads without errors
- Leader key is set correctly
- lazy.nvim is installed
- Key mappings work
- Core options are applied
- All plugins load correctly (Treesitter, Telescope, Flash, Which-key, Mason, LSP, Conform, LuaSnip, nvim-cmp)
- LSP functionality and formatting work correctly
- Snippet expansion and completion work correctly

## Next Phases

- ~~Phase 2: Syntax & Understanding (treesitter)~~ ✅ Complete
- ~~Phase 3: Navigation & Search (telescope, flash, which-key)~~ ✅ Complete
- ~~Phase 4: Language Intelligence (LSP + Mason & Conform)~~ ✅ Complete
- ~~Phase 5: Code Assistance (Luasnip)~~ ✅ Complete
- Phase 6: Version Control (Gitsigns)
- Phase 7: UI Enhancement (Lualine & Undotree)
- Phase 8: Session & File Management (Persistence & Yazi)
- Phase 9: BONSAI Colorscheme & Final Polish

See `concept.md` for the complete vision.