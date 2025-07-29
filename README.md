# 🌱 BONSAI Neovim Configuration

A minimal, purposeful Neovim configuration following BONSAI principles - start minimal, grow only when needed.

## 🚀 Installation

### Prerequisites
- Neovim >= 0.9.0
- Git
- Terminal with true color support
- Optional: [yazi](https://github.com/sxyazi/yazi) file manager

### Quick Install

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/BONSAIVIM.git
   cd BONSAIVIM
   ```

2. **Test the configuration** (without modifying your existing config):
   ```bash
   ./run_nvim.sh
   ```

3. **Install permanently** (choose one):
   ```bash
   ./symlink_nvim.sh         # Interactive (choose clean/adopt/cancel)
   ./symlink_nvim_clean.sh   # Non-interactive clean install
   ```

4. **First Launch**:
   - Plugins will auto-install on first run
   - LSP servers will install automatically via Mason
   - Treesitter parsers will download for configured languages

### Manual Installation

If you prefer manual installation:
```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Copy BONSAI config
cp -r config/.config/nvim ~/.config/nvim

# Launch Neovim
nvim
```

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
- **Custom Features**:
  - `lua/bonsai/align-comments.lua` - LazyVim-style comment alignment for shell scripts
  - Filetype detection enabled for proper formatter activation
  - Support for bash/shell script formatting with shfmt

### Key LSP Features

- **Code Navigation**:
  - `gd` - Go to definition
  - `gi` - Go to implementation  
  - `gr` - Go to references
  - `K` - Hover documentation

- **Code Actions** (`<leader>c` group):
  - `ca` - Code action
  - `cf` - Code format
  - `cI` - Show formatter info (ConformInfo)
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
  - Bash/Shell: shfmt with custom comment alignment (LazyVim-style)

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

- **🚀 Lightning Fast**: ~26ms startup time (well under 50ms target)
- **🎨 BONSAI Colorscheme**: Custom dark zen color palette with semantic highlighting
- **📝 Complete Language Support**: LSP for Python, JavaScript/TypeScript, Tailwind CSS, HTML, Markdown
- **🔍 Powerful Navigation**: Telescope fuzzy finder, Flash jump-to-char, Undotree visualization
- **🎯 Quick File Access**: Harpoon for instant navigation to frequently used files
- **🗂️ Buffer Tabs**: Visual buffer tabs like browser tabs with bufferline
- **💾 Smart Sessions**: Auto-save and restore your workspace
- **📁 File Manager**: Integrated yazi terminal file manager
- **💻 Integrated Terminal**: Toggleterm with persistent sessions and custom terminals
- **🔧 Auto-formatting**: Format on save with ruff (Python), prettier (JS/TS/CSS/HTML), stylua (Lua), and shfmt (Bash/Shell)
- **✂️ Snippets**: Tab-completable snippets with LuaSnip
- **📊 Git Integration**: Gitsigns with hunk navigation and inline blame + LazyGit visual interface
- **⌨️ German Keyboard**: Full support with `ö` → `[`, `ä` → `]`
- **🎯 Minimal Philosophy**: Every plugin has a clear purpose

## Testing

Run the comprehensive test suite to verify your installation:

```bash
# Quick configuration test
./test_config.sh

# Full test suite (recommended)
./tests/run_all_tests.sh

# Phase-specific tests
./tests/run_phase9_tests.sh    # Colorscheme & performance tests
./tests/run_phase10_tests.sh   # nvim-spectre search & replace tests
./tests/run_lsp_tests.sh       # LSP & formatting tests
./tests/run_snippet_tests.sh   # Snippet functionality tests
./tests/run_spectre_tests.sh   # Standalone spectre functionality tests
./tests/run_toggleterm_tests.sh # Terminal integration tests
./tests/run_lazygit_tests.sh   # LazyGit visual git interface tests
```

### What the Tests Verify

- ✅ **Startup Performance**: Confirms <50ms startup time
- ✅ **Configuration Loading**: All modules load without errors
- ✅ **Plugin Functionality**: All plugins load and function correctly (17+ active plugins)
- ✅ **LSP Integration**: Language servers install and work properly
- ✅ **Formatting**: Code formatting works for all configured languages
- ✅ **Colorscheme**: BONSAI colors apply correctly to all UI elements
- ✅ **Keybindings**: All mappings are registered and functional
- ✅ **Performance Optimizations**: Large file handling and autocommands work
- ✅ **Git Integration**: Gitsigns functionality including hunks and blame
- ✅ **Search & Replace**: nvim-spectre project-wide search and replace functionality
- ✅ **Terminal Integration**: Toggleterm with persistent sessions and custom terminals

## Phase 6: Version Control (Complete)

Added Git integration with gitsigns.nvim:
- **Sign Column**: Subtle indicators for additions, deletions, and modifications
- **Hunk Navigation**: `[c`/`]c` to navigate between changes
- **Hunk Operations**: Stage, reset, preview hunks under `<leader>gh`
- **Line Blame**: Current line blame with muted colors (toggle with `<leader>tb`)
- **BONSAI Colors**: Git signs use semantic colors that don't distract from code

### What's New in Phase 6

- `lua/plugins/gitsigns.lua` - Complete Git integration configuration
- Keymap conflict resolved: Treesitter now uses `[[`/`]]` for class navigation
- Comprehensive test suite for gitsigns functionality

### Key Git Features

- **Hunk Navigation**:
  - `[c` - Previous git hunk
  - `]c` - Next git hunk

- **Hunk Operations** (`<leader>gh` prefix):
  - `ghs` - Stage hunk
  - `ghr` - Reset hunk
  - `ghS` - Stage buffer
  - `ghu` - Undo stage hunk
  - `ghR` - Reset buffer
  - `ghp` - Preview hunk
  - `ghb` - Blame line
  - `ghd` - Diff this
  - `ghD` - Diff this ~
  - `ghn` - Next hunk
  - `ghN` - Previous hunk

- **Toggle Features** (`<leader>t` prefix):
  - `tb` - Toggle line blame
  - `td` - Toggle deleted lines

## Configuration Complete! 🎉

All 10 phases of the BONSAI Neovim configuration are now complete:

1. ✅ **Foundation** - Core structure and settings
2. ✅ **Syntax & Understanding** - Treesitter integration
3. ✅ **Navigation & Search** - Telescope, Flash, Which-key, Harpoon
4. ✅ **Language Intelligence** - LSP with Mason & Conform
5. ✅ **Code Assistance** - LuaSnip and nvim-cmp
6. ✅ **Version Control** - Gitsigns integration
7. ✅ **UI Enhancement** - Lualine statusline, Undotree & Bufferline tabs
8. ✅ **Session & File Management** - Persistence & Yazi
9. ✅ **BONSAI Colorscheme & Final Polish** - Custom colors & optimizations
10. ✅ **Advanced Search & Replace** - nvim-spectre for project-wide operations

Your Neovim is now a fully-featured, minimal, and blazing-fast development environment!

## Phase 7: UI Enhancement - Lualine (Complete)

Added a minimal, BONSAI-themed statusline:

### What's New - Lualine

- `lua/plugins/lualine.lua` - Minimal statusline with BONSAI colors
- Custom BONSAI theme matching the color philosophy:
  - Green for normal mode (#7c9885)
  - Blue for insert mode (#82a4c7)
  - Purple for visual mode (#9882c7)
  - Yellow for command mode (#c7a882)
  - Red for replace mode (#c78289)
- Minimal sections showing only essential information:
  - Mode indicator
  - Git branch and diff stats
  - LSP diagnostics
  - File name with modification status
  - Search count
  - File type
  - Progress and location

### What's New - Bufferline

- `lua/plugins/bufferline.lua` - Visual buffer tabs like browser tabs
- Browser-style tab interface for open buffers:
  - Shows all open files as tabs at the top
  - Active tab highlighted with BONSAI green accent
  - Modified buffers show ● indicator in yellow
  - Diagnostic counts (errors/warnings) in each tab
  - Click tabs to switch buffers (mouse support)
- Enhanced buffer management:
  - `<leader>1-9` - Jump directly to buffers 1-9
  - `<leader>bp` - Interactive buffer picker
  - `<leader>bc` - Pick buffer to close
  - `<leader>bo` - Close all other buffers
  - `<A-h>/<A-l>` - Move tabs left/right to reorder

### Testing Lualine

The statusline automatically appears at the bottom of your Neovim window showing:
- Current mode with color coding
- Git information (branch, added/modified/removed files)
- Diagnostics (errors, warnings, info, hints)
- File information and location

See `concept.md` for the complete vision.

## Phase 8: Session & File Management (Complete)

Added session persistence and file manager integration:

### What's New - Persistence

- `lua/plugins/persistence.lua` - Automatic session management
- Features:
  - Auto-saves session on exit
  - Auto-restores when opening nvim without arguments
  - Excludes help, quickfix, terminal, and temporary buffers
  - Per-directory session storage
- Keymaps under `<leader>p`:
  - `ps` - Save current session
  - `pr` - Restore session for current directory
  - `pd` - Don't save session on exit (disable for current session)
  - `pl` - Load last session

### What's New - Yazi

- `lua/plugins/yazi.lua` - Terminal file manager integration
- Features:
  - Floating window file manager
  - 90% width/height (as per concept.md)
  - Seamless integration with Neovim
  - Telescope integration for advanced operations
- Keymaps under `<leader>y`:
  - `yy` - Open yazi in current file's directory
  - `yw` - Open yazi in working directory
  - `yt` - Toggle last yazi state

### Testing Session Management

1. Open multiple files in Neovim
2. Exit Neovim (session auto-saves)
3. Open Neovim again without arguments
4. Your previous session is automatically restored!

### Testing Yazi Integration

1. Press `<leader>yy` to open the file manager
2. Navigate with arrow keys or vim keys
3. Press Enter to open files
4. Press `q` to close yazi

## Phase 9: BONSAI Colorscheme & Final Polish (Complete)

Added the custom BONSAI colorscheme and performance optimizations:

### What's New - BONSAI Colorscheme

- `lua/bonsai/colors.lua` - Complete BONSAI color palette implementation
- Features matching concept.md vision:
  - **Functions**: Bold blue (#82a4c7) for immediate recognition
  - **Brackets/Delimiters**: Bright primary text (#e6e8eb) for structure clarity
  - **Keywords**: Purple (#9882c7) for control flow visibility
  - **Strings**: Calming green (#7c9885)
  - **Comments**: Muted gray (#8b92a5) to stay out of the way
  - **Errors**: Soft red (#c78289) that alerts without alarming
- Comprehensive highlight groups:
  - Full syntax highlighting support
  - Treesitter-specific highlights
  - LSP diagnostics styling
  - Plugin-specific colors (Telescope, which-key, lualine, gitsigns)
  - UI elements (floats, splits, statusline, tabline)

### What's New - Performance Optimizations

- `lua/config/autocommands.lua` - Smart performance optimizations
- Features:
  - **Large File Handling**: Disables syntax highlighting for files >1MB or >5000 lines
  - **Startup Optimization**: Lazy loads colorscheme after UI initialization
  - **Buffer-Local Settings**: Optimized settings for different file types
  - **Smart Cursor Hold**: Adjusts update time based on mode
  - **View Persistence**: Saves/restores cursor position and folds
  - **Whitespace Cleanup**: Automatic trailing whitespace removal on save
  - **Yank Highlighting**: Brief highlight when yanking text

### Performance Achievements

- **Startup Time**: ~26ms (well under 50ms target)
- **Large File Support**: Instant loading for files up to 10MB
- **Memory Efficient**: Disables heavy features when not needed

## Phase 10: Advanced Search & Replace - nvim-spectre (Complete)

Added powerful project-wide search and replace functionality:

### What's New - nvim-spectre

- `lua/plugins/spectre.lua` - Advanced search and replace with live preview
- Features:
  - **Project-wide Search**: Search across entire codebase with ripgrep
  - **Live Preview**: See replacements before applying them
  - **Selective Replace**: Toggle individual occurrences on/off
  - **File Filtering**: Search within specific files or directories
  - **Regex Support**: Full regular expression support for complex patterns
  - **Multiple Replace Engines**: sed and oxi support
- BONSAI Integration:
  - Custom highlight colors matching the BONSAI theme
  - Keybindings under `<leader>s` for consistency
  - Minimal UI that doesn't distract from content
  - Fast performance with ripgrep backend

### Testing nvim-spectre

1. **Basic Search**: Press `<leader>ss` to open search panel
2. **Search Current Word**: Press `<leader>sw` on any word
3. **File-specific Search**: Press `<leader>sp` to search in current file only
4. **Replace Workflow**:
   - Enter search pattern
   - Enter replacement text
   - Use `dd` to toggle specific occurrences
   - Press `<leader>R` to replace all or `<leader>rc` for current line

### Spectre Panel Navigation

- `j/k` - Navigate through results
- `dd` - Toggle line inclusion
- `<cr>` - Jump to file location
- `<leader>q` - Send results to quickfix
- `ti` - Toggle case sensitivity
- `th` - Toggle hidden files

## 🔧 Troubleshooting

### Formatters Not Working

If formatters don't run when saving files:
1. Check formatter info with `<leader>cI` (ConformInfo)
2. Ensure filetype detection is enabled (required for conform.nvim)
3. Verify formatter is installed (e.g., `which shfmt`, `which stylua`)

The configuration includes `vim.cmd([[filetype plugin indent on]])` in options.lua to enable filetype detection.

## 📚 Complete Keybinding Reference

### Core Mappings

| Key | Mode | Description |
|-----|------|-------------|
| `<space>` | Normal | Leader key |
| `jk` | Insert | Escape alternative |
| `<C-s>` | Normal/Insert/Visual | Save file |
| `ö` | Normal/Visual | `[` (German keyboard) |
| `ä` | Normal/Visual | `]` (German keyboard) |

### Navigation

| Key | Description |
|-----|-------------|
| `s` | Flash forward search |
| `S` | Flash backward search |
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `[d` / `]d` | Previous/next diagnostic |
| `[c` / `]c` | Previous/next git hunk |
| `[[` / `]]` | Previous/next class |
| `[f` / `]f` | Previous/next function |

### Leader Key Groups

#### `<leader>f` - Find/Files (Telescope)
| Key | Description |
|-----|-------------|
| `ff` | Find files |
| `fg` | Find grep (live grep) |
| `fb` | Find buffers |
| `fh` | Find help |
| `fr` | Find recent files |
| `fw` | Find word under cursor |
| `f/` | Find in current buffer |

#### `<leader>c` - Code Actions
| Key | Description |
|-----|-------------|
| `ca` | Code action |
| `cf` | Code format |
| `cI` | Show formatter info (ConformInfo) |
| `cr` | Code rename |
| `cd` | Code definition |
| `ci` | Code implementation |
| `ch` | Code hover documentation |
| `cs` | Code signature help |

#### `<leader>d` - Diagnostics
| Key | Description |
|-----|-------------|
| `dd` | Diagnostics list |
| `dn` | Diagnostics next |
| `dp` | Diagnostics previous |
| `df` | Diagnostics float |

#### `<leader>g` - Git & LazyGit
| Key | Description |
|-----|-------------|
| `gg` | LazyGit (visual git interface) |
| `gf` | LazyGit current file |
| `gF` | LazyGit filter (project) |
| `gs` | Git status (future) |
| `gb` | Git blame (future) |
| `gd` | Git diff (future) |
| `gc` | Git commits (future) |

#### `<leader>gh` - Git Hunks (Gitsigns)
| Key | Description |
|-----|-------------|
| `ghs` | Stage hunk |
| `ghr` | Reset hunk |
| `ghS` | Stage buffer |
| `ghu` | Undo stage hunk |
| `ghR` | Reset buffer |
| `ghp` | Preview hunk |
| `ghb` | Blame line |
| `ghd` | Diff this |
| `ghD` | Diff this ~ |
| `ghn` | Next hunk |
| `ghN` | Previous hunk |

#### `<leader>b` - Buffers
| Key | Description |
|-----|-------------|
| `bd` | Buffer delete |
| `bD` | Buffer force delete |
| `bp` | Pick buffer (interactive selection) |
| `bc` | Pick buffer to close |
| `bh` | Close buffers to the left |
| `bl` | Close buffers to the right |
| `bo` | Close other buffers |
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<A-h>` | Move buffer left (reorder) |
| `<A-l>` | Move buffer right (reorder) |

#### `<leader>h` - Harpoon (Quick File Navigation)
| Key | Description |
|-----|-------------|
| `hh` | Harpoon menu |
| `ha` | Add current file to harpoon |
| `hr` | Remove current file from harpoon |
| `hc` | Clear all harpoon marks |
| `hn` | Next harpoon file |
| `hp` | Previous harpoon file |
| `ht` | Harpoon telescope picker |
| `h1-9` | Attach current file to harpoon position 1-9 |
| `<leader>1-9` | Jump to harpoon file 1-9 |

**Alternative quick access:**
- `<C-h>` - Harpoon file 1
- `<C-t>` - Harpoon file 2  
- `<C-n>` - Harpoon file 3

#### `<leader>w` - Windows
| Key | Description |
|-----|-------------|
| `wv` | Window vertical split |
| `ws` | Window horizontal split |
| `wc` | Window close |
| `wo` | Window close others |
| `w=` | Window balance |

#### `<leader>t` - Toggle/Terminal
| Key | Description |
|-----|-------------|
| `tn` | Toggle relative numbers |
| `tw` | Toggle wrap |
| `ts` | Toggle spell |
| `th` | Toggle highlight search |
| `tb` | Toggle git blame |
| `td` | Toggle deleted lines |
| `tv` | Toggle diagnostics virtual text (on/off) |
| `tV` | Cycle diagnostic modes (Hidden → Errors only → Warnings+ → All) |
| `tD` | Toggle all diagnostics (completely disable/enable) |
| `tf` | Terminal float (90% width/height) |
| `th` | Terminal horizontal (bottom split) |
| `tv` | Terminal vertical (right split) |
| `tp` | Terminal Python REPL |
| `tn` | Terminal Node REPL |
| `tr` | Terminal run current file |

#### `<leader>s` - Search & Replace (Spectre)
| Key | Description |
|-----|-------------|
| `ss` | Open search panel (Spectre) |
| `sw` | Search word under cursor (Spectre) |
| `sp` | Search in current file (Spectre) |
| `sr` | Search and replace (Spectre) |
| `sc` | Search clear highlight |

**Spectre Panel Commands:**
- `dd` - Toggle line from search
- `<cr>` - Go to file
- `<leader>q` - Send all to quickfix
- `<leader>R` - Replace all
- `<leader>rc` - Replace current line
- `ti` - Toggle ignore case
- `th` - Toggle hidden files

#### `<leader>p` - Persistence/Session
| Key | Description |
|-----|-------------|
| `ps` | Save session |
| `pr` | Restore session |
| `pd` | Don't save session |
| `pl` | Load last session |

#### `<leader>y` - Yazi File Manager
| Key | Description |
|-----|-------------|
| `yy` | Open yazi (current dir) |
| `yw` | Open yazi (working dir) |
| `yt` | Toggle last yazi state |

#### Other Leader Mappings
| Key | Description |
|-----|-------------|
| `<leader>u` | Toggle undotree |
| `<leader>jt` | Flash Treesitter |
| `<C-\>` | Toggle terminal (works in all modes) |

### Snippet Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<Tab>` | Insert/Select | Expand snippet/jump forward |
| `<S-Tab>` | Insert/Select | Jump backward |
| `<C-j>` | Insert | Choice next |
| `<C-k>` | Insert | Choice previous |

### Text Objects

| Key | Description |
|-----|-------------|
| `af` / `if` | Around/inside function |
| `ac` / `ic` | Around/inside class |
| `aa` / `ia` | Around/inside parameter |

## 🌱 Living with BONSAI

This configuration embodies the BONSAI philosophy:
- **Start Minimal**: Begin with only what you need
- **Grow Purposefully**: Each addition serves a clear purpose
- **Maintain Balance**: Performance and features in harmony
- **Prune Regularly**: Remove what you don't use

### Customization

To extend this configuration:
1. Add new plugins to `lua/plugins/` as individual files
2. Follow the existing patterns for consistency
3. Ensure each addition aligns with BONSAI principles
4. Test thoroughly with the provided test suite

### Support

- **Documentation**: See [concept.md](concept.md) for the complete vision
- **Issues**: Report bugs or request features via GitHub issues
- **Contributing**: PRs welcome that align with BONSAI principles

---

*Built with 🌱 BONSAI principles - minimal, purposeful, beautiful.*