# BONSAIVIM — Opinion & Suggestions

## Snapshot (What’s Working Well)
- Clear, modular layout: one feature per file under `lua/plugins/`; fast load (~26ms) and sensible defaults.
- Strong test story: headless runners in `tests/` and plugin verifier (`verify_plugins.lua`).
- Purposeful plugin set: Telescope, Treesitter, LSP + Conform, LuaSnip/CMP, Gitsigns, Bufferline/Lualine, Spectre, Toggleterm, Alpha, Zen, Yazi.
- Thoughtful UX polish: BONSAI colors, which-key groupings, session persistence, markdown/rendering.

## Gaps / Polish Opportunities
- Missing files referenced by README: `run_nvim.sh`, `symlink_nvim.sh`, and `USAGE.md` are mentioned but not present. Align docs or add scripts.
- Formatting/tooling: `.luacheckrc` exists, but there’s no `stylua.toml` or `.editorconfig`. Add both for consistent Lua/Markdown/Shell formatting.
- Shell scripts: adopt `set -euo pipefail` and defensive checks; prefer `#!/usr/bin/env bash` shebangs.
- CI: add a minimal GitHub Action to run `tests/run_all_tests.sh` on PRs with plugin cache (Lazy dir) to catch regressions.
- Lockfile policy: define how/when `lazy-lock.json` is updated; add an update script and document it.
- NVIM profiles: encourage `NVIM_APPNAME=bonsai-dev` for safe local trials in docs/scripts.

## Suggested Changes (Non-breaking)
- Add `scripts/run_nvim.sh` wrapper using `-u config/.config/nvim/init.lua` and optional `NVIM_APPNAME`.
- Add `stylua.toml` + formatting task, and `.editorconfig` with 2-space Lua/Markdown.
- Tighten tests: ensure runners `cd` to repo root, pre-create `tests/results/`, exit nonzero on failure.
- Small docs pass: consolidate keymaps into a cheatsheet link, and remove duplicated sections in README.

## Potential Additions Within BONSAI Principles (all lazy-loaded)
- nvim-ts-autotag: auto-update HTML/TSX tags; tiny and focused.
- todo-comments.nvim: quick navigation of TODO/FIXME via Telescope; low footprint.
- treesitter-context: shows current function/class at top; inexpensive, improves code comprehension.
- fidget.nvim: lightweight LSP progress; keeps UI minimal yet informative.
- nvim-bqf: better quickfix experience (works nicely with Spectre/Telescope).
- dressing.nvim: nicer `vim.ui.select`/`vim.ui.input` without heavy UI overhaul.

## Risks & Trade-offs
- Keep additions opt-in and filetype/command scoped to preserve startup time.
- Prefer one clear tool per job; avoid overlapping with existing features (e.g., no second file manager).

Overall: BONSAIVIM is cohesive, fast, and thoughtfully scoped. The above tweaks tighten the docs/tooling loop and add a few high-value, low-cost enhancements without bending the BONSAI philosophy.
