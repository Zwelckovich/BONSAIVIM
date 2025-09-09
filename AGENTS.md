# Repository Guidelines

## Project Structure & Module Organization
- `config/.config/nvim/init.lua` – Neovim entrypoint for this repo.
- `config/.config/nvim/lua/config/` – Core setup: options, keymaps, autocommands, lazy.
- `config/.config/nvim/lua/plugins/` – One plugin/feature per file (lazy.nvim specs).
- `config/.config/nvim/lua/bonsai/` – BONSAI colors and utilities.
- `tests/` – Lua tests, shell runners, and `results/` outputs.
- Scripts: `symlink_nvim_clean.sh` for install; see README for usage.

## Build, Test, and Development Commands
- Run with repo config: `nvim -u config/.config/nvim/init.lua`  
  Tip: isolate state with `NVIM_APPNAME=bonsai-dev`.
- Quick headless check: `nvim --headless -u config/.config/nvim/init.lua -c 'qa'`.
- All tests: `./tests/run_all_tests.sh`.
- Suite examples: `./tests/run_lsp_tests.sh`, `./tests/run_snippet_tests.sh`.
- Plugin smoke test: `nvim --headless -u config/.config/nvim/init.lua +"luafile config/.config/nvim/verify_plugins.lua"`.

## Coding Style & Naming Conventions
- Lua: 2-space indentation, spaces not tabs; keep lines concise.
- Files: lowercase; prefer simple names (`lsp.lua`, `keymaps.lua`); mirror plugin names when helpful (`render-markdown.lua`, `table-mode.lua`).
- One concern per file; keep modules focused and small.
- Use descriptive locals; avoid one-letter names.
- Formatting: prefer `stylua` where available; trailing whitespace should be clean.

## Testing Guidelines
- Add Lua tests under `tests/` (name like `test_<feature>.lua`).
- Provide a shell runner when useful (`tests/run_<feature>_tests.sh`).
- Use headless Neovim for assertions; write outputs under `tests/results/` when applicable.
- Minimum expectation: modules load, commands/keymaps exist, core options behave.

## Commit & Pull Request Guidelines
- Follow Conventional Commits: `feat:`, `fix:`, `docs:`, `refactor:`, etc. (see `git log`).
- Keep PRs focused; include: what/why, test results, and any screenshots for UI changes (statusline, colors, dashboard).
- Link related issues; update tests/docs when behavior changes.
- Ensure `./tests/run_all_tests.sh` passes; avoid changing `lazy-lock.json` unless updating plugins intentionally.

## Agent-Specific Notes
- Do not rename files or directories; keep changes minimal and localized.
- Match existing style and structure; prefer adding small modules over large edits.
- Before changes, run a headless load; after changes, run relevant test runners.
