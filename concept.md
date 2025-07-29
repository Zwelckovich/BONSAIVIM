# 🌱 BONSAI Neovim Configuration

## Vision

A minimal, purposeful Neovim configuration that embodies BONSAI principles:
- Start minimal, grow only when needed
- Every plugin has a clear purpose
- Clean, readable code following Lua best practices
- Optimized for Python, React, JavaScript, Tailwind CSS, HTML, and Markdown development

## Core Principles

- **Lazy Loading**: Plugins load only when needed for maximum performance
- **Modular Structure**: One file per plugin for clarity and maintainability
- **BONSAI Aesthetics**: Dark zen color scheme with excellent readability
- **Minimal Keybindings**: Intuitive, vim-like mappings that enhance, not replace
- **Fast Startup**: <50ms target startup time through careful optimization

## Technology Stack

### Package Management
- **lazy.nvim**: Modern, fast, with minimal configuration overhead

### Core Plugins
- **treesitter**: Syntax highlighting and code understanding
- **telescope**: Fuzzy finding with a clean interface
- **lsp + mason**: Language intelligence with easy server management
- **conform**: Formatting with BONSAI-approved tools
- **flash**: Lightning-fast navigation
- **undotree**: Visual undo history
- **lualine**: Customizable statusline with BONSAI theme
- **which-key**: Interactive keybinding discovery
- **luasnip**: Practical snippets
- **gitsigns**: Git integration in the sign column
- **persistence**: Automatic session management
- **yazi.nvim**: Terminal file manager integration
- **nvim-surround**: Efficient text manipulation for quotes, brackets, and tags
- **nvim-autopairs**: Automatic bracket/quote pairing with context awareness

## BONSAI-Specific Tooling

### Python
- **Formatter**: ruff (replaces black, isort)
- **LSP**: pyright (type checking and intelligence)
- **Virtual Environments**: Automatic detection

### JavaScript/React
- **Formatter**: prettier (minimal config)
- **Linter**: eslint (minimal rules)
- **LSP**: typescript-language-server

### Web Technologies
- **Tailwind CSS**: tailwindcss-language-server
- **HTML/CSS**: Native LSP support
- **Markdown**: markdownlint, markdown-preview

## Color Philosophy

The BONSAI colorscheme prioritizes:
1. **High Contrast** for critical syntax elements (functions, brackets, operators)
2. **Zen Aesthetics** with muted backgrounds and thoughtful color choices
3. **Semantic Meaning** where each color serves a specific purpose
4. **Eye Comfort** for extended coding sessions

### Syntax Highlighting Strategy
- **Functions**: Bold blue (#82a4c7) for immediate recognition
- **Brackets/Delimiters**: Bright primary text (#e6e8eb) for structure clarity
- **Keywords**: Purple (#9882c7) for control flow visibility
- **Strings**: Calming green (#7c9885) 
- **Comments**: Muted gray (#8b92a5) to stay out of the way
- **Errors**: Soft red (#c78289) that alerts without alarming

## Keybinding Philosophy

Following vim's modal philosophy with minimal, mnemonic additions:

### Core Mappings
- **Leader key**: `<space>` (comfortable and central)
- **Escape alternative**: `jk` in insert mode (faster than reaching for ESC)
- **Quick save**: `<C-s>` in any mode (saves file immediately)
- **German keyboard support**: 
  - `ö` → `[` (all bracket-based navigation)
  - `ä` → `]` (all bracket-based navigation)

### Leader Key Groups
Organized mnemonically for quick muscle memory:

- **`<leader>c`** - **C**ode actions
  - `ca` - code action
  - `cf` - code format
  - `cr` - code rename
  - `cd` - code definition
  - `ci` - code implementation
  - `ch` - code hover documentation
  - `cs` - code signature help

- **`<leader>f`** - **F**ind/Files (Telescope/fzf)
  - `ff` - find files
  - `fg` - find grep (live grep)
  - `fb` - find buffers
  - `fh` - find help
  - `fr` - find recent files
  - `fw` - find word under cursor
  - `f/` - find in current buffer

- **`<leader>g`** - **G**it operations
  - `gs` - git status
  - `gb` - git blame
  - `gd` - git diff
  - `gc` - git commits
  - `gp` - git push
  - `gl` - git pull

- **`<leader>b`** - **B**uffer management
  - `bd` - buffer delete
  - `bn` - buffer next
  - `bp` - buffer previous
  - `bD` - buffer force delete

- **`<leader>w`** - **W**indow management
  - `wv` - window vertical split
  - `ws` - window horizontal split
  - `wc` - window close
  - `wo` - window close others
  - `w=` - window balance

- **`<leader>t`** - **T**oggle settings
  - `tn` - toggle relative numbers
  - `tw` - toggle wrap
  - `ts` - toggle spell
  - `th` - toggle highlight search

- **`<leader>d`** - **D**iagnostics/Debug
  - `dd` - diagnostics list
  - `dn` - diagnostics next
  - `dp` - diagnostics previous
  - `df` - diagnostics float

- **`<leader>s`** - **S**earch/Replace
  - `sr` - search and replace
  - `sw` - search word
  - `sc` - search clear highlight

- **`<leader>m`** - **M**arkdown (context-aware)
  - `mp` - markdown preview
  - `mt` - markdown toggle checkbox

- **`<leader>u`** - **U**ndotree toggle

- **`<leader>y`** - **Y**azi file manager
  - `yy` - yazi open in current directory
  - `yw` - yazi open in working directory

- **`<leader>p`** - **P**ersistence/Session
  - `ps` - persistence save session
  - `pr` - persistence restore session
  - `pd` - persistence delete session

- **`<leader>h`** - Git**H**unk operations (gitsigns)
  - `hs` - hunk stage
  - `hr` - hunk reset
  - `hp` - hunk preview
  - `hb` - hunk blame line
  - `hn` - next hunk
  - `hN` - previous hunk

### Non-Leader Navigation
Quick actions without leader key:
- `<C-s>` - save file (works in normal, insert, and visual modes)
- `K` - hover documentation (LSP)
- `gd` - go to definition
- `gr` - go to references
- `gi` - go to implementation
- `[d` / `]d` - previous/next diagnostic
- `[c` / `]c` - previous/next git hunk (gitsigns)
- `[[` / `]]` - previous/next function/class
- `s` / `S` - flash.nvim forward/backward

## Performance Targets

- **Startup Time**: <50ms
- **File Load**: Instant for files <10MB
- **LSP Response**: <100ms for completions
- **Search**: <200ms for project-wide searches

## Growth Strategy

Start with this minimal set. Add only when:
1. A specific need arises repeatedly
2. The benefit clearly outweighs complexity
3. It aligns with BONSAI principles
4. Performance impact is negligible

### Plugin Justifications

Each plugin serves a clear purpose in the BONSAI workflow:

- **lualine**: Provides essential context (mode, file, git status) at a glance
- **which-key**: Reduces cognitive load by showing available keybindings
- **gitsigns**: Git context without leaving the editor, essential for modern development
- **persistence**: Eliminates repetitive file opening, preserves project context
- **yazi.nvim**: Fast file navigation when tree-based exploration is needed
- **nvim-surround**: Streamlines common text manipulation tasks (quotes, brackets, tags)

## Directory Structure

```
nvim/
├── init.lua                 # Minimal entry point
├── lua/
│   ├── config/             # Core configuration
│   │   ├── lazy.lua       # Package manager setup
│   │   ├── options.lua    # Neovim options
│   │   ├── keymaps.lua    # Core mappings
│   │   └── autocommands.lua
│   ├── plugins/           # Plugin configurations
│   │   ├── lualine.lua   # Status line config
│   │   ├── which-key.lua # Keybinding hints
│   │   ├── gitsigns.lua  # Git integration
│   │   ├── persistence.lua # Session management
│   │   ├── yazi.lua      # File manager
│   │   └── [other plugin files]
│   └── bonsai/           # BONSAI-specific
│       └── colors.lua    # Color definitions
└── concept.md            # This file
```

## Plugin Configuration Philosophy

### Treesitter
- Enable highlighting, indentation, and text objects
- Install only for actively used languages (Python, JS/TS, HTML, CSS, Markdown, Lua)
- Incremental selection with visual mode expansion
- Fold expressions based on syntax tree
- Disable for large files (>1MB) to maintain performance

### Telescope
- Use BONSAI colors for all UI elements
- Ivy theme for compact, bottom-aligned picker
- Fuzzy finding with fzf algorithm
- Respect .gitignore and hidden files by default
- Preview window for code files, disable for binaries
- Mappings: `<C-x>` split, `<C-v>` vsplit, `<C-t>` tab

### LSP + Mason
- Mason: Auto-install only essential servers (pyright, typescript-language-server, tailwindcss-language-server)
- Virtual text for errors only (not warnings/hints)
- Signs in gutter with BONSAI semantic colors
- Hover documentation in floating window with rounded borders
- Format on save disabled by default (use explicit `<leader>cf`)
- Diagnostics update in insert mode disabled (only on normal mode)

### Conform
- **Format on save enabled for all configured formatters**
- **Import sorting integrated into format step (ruff for Python handles both)**
- Python: ruff (formats AND sorts imports in one pass)
- JavaScript/TypeScript: prettier with minimal config
- CSS/HTML: prettier
- Markdown: prettier with prose wrap
- Timeout: 1000ms to prevent hanging
- Fallback to LSP formatter if conform formatter unavailable
- Async formatting to not block editor

### Flash
- Lowercase labels for minimal visual disruption  
- Search mode with `/` integration
- Jump labels use BONSAI yellow for visibility
- Highlight matches with subtle BONSAI green
- Disable in large files (>10,000 lines)
- `s` for forward, `S` for backward navigation

### Undotree
- Float window on right side (40% width)
- Auto-focus on open, auto-close on selection
- Relative timestamps for recent changes
- Persistent undo history across sessions
- Diff window shows changes between states
- BONSAI colors for tree branches

### Lualine
- Use BONSAI colors exclusively
- Minimal sections: mode, filename, git branch, diagnostics, file position
- Disable unnecessary components (encoding, fileformat unless relevant)
- Flat design, no powerline symbols

### Which-key
- Delay popup to 500ms (not intrusive but available)
- Group related commands clearly
- Show only for multi-key sequences
- Use BONSAI color scheme for popup

### Gitsigns
- Subtle signs that don't distract from code
- Inline blame delayed to avoid visual noise
- Current line blame in virtual text with muted colors
- Preview hunks in floating windows

### Persistence
- Auto-save session on exit
- Auto-restore only when opening nvim without arguments
- Exclude help, quickfix, and temporary buffers
- Store in standard data directory

### Yazi
- Float window with 90% width/height
- Transparent border using BONSAI colors
- Keybinding to send selected files to quickfix
- Integration with telescope for fuzzy finding after navigation

### Luasnip
- Load snippets from both VSCode and SnipMate formats
- Expand with `<Tab>`, jump with `<Tab>`/`<S-Tab>`
- Python: docstrings, type hints, common patterns
- JavaScript: modern ES6+ snippets, React hooks
- Auto-trigger for common patterns (e.g., `def` → function template)
- Visual placeholder for TM_SELECTED_TEXT
- No aggressive auto-expansion

### Nvim-surround
- Efficient manipulation of surrounding characters (quotes, brackets, tags)
- Minimal keybindings: `ys` (add), `cs` (change), `ds` (delete)
- Visual mode with `S` to surround selection
- Aliases for common surrounds: `q` for quotes, `b` for brackets
- Subtle highlight animation (300ms) for visual feedback
- Works seamlessly with repeat (`.`) command

### Nvim-autopairs
- Automatic insertion of closing brackets, quotes, and backticks
- Treesitter integration for context awareness (disable in comments/strings)
- nvim-cmp integration for seamless completion compatibility
- Fast wrap with `<M-e>` to surround existing text
- Language-specific rules: markdown triple asterisks, HTML tags, docstrings
- Disable in specific filetypes: TelescopePrompt, vim, command mode
- Smart behavior: skip over existing pairs, delete pairs together

## Maintenance

- Review quarterly for unused plugins
- Benchmark startup time monthly
- Update tools to match BONSAI standards
- Keep configuration comments minimal but clear

---

Remember: Like a bonsai tree, this configuration should be carefully pruned and shaped over time, never allowed to grow wild.