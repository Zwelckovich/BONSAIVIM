-- BONSAI Formatting configuration with conform.nvim
-- Provides consistent formatting for Python, JavaScript, TypeScript, CSS, HTML, and Markdown

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Code format",
    },
  },
  config = function()
    local conform = require("conform")
    local util = require("conform.util")

    conform.setup({
      -- Define formatters by filetype
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },  -- ruff handles both fixing and formatting
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        lua = { "stylua" },
      },

      -- Format on save configuration
      format_on_save = {
        -- Enable format on save with timeout
        timeout_ms = 1000,
        lsp_fallback = true,  -- Use LSP formatting if no formatter available
      },

      -- Format after save (async) - disabled by default
      format_after_save = nil,

      -- Customize formatter configurations
      formatters = {
        ruff_fix = {
          -- ruff with --fix flag for import sorting and auto-fixes
          command = "ruff",
          args = {
            "check",
            "--fix",
            "--force-exclude",
            "--quiet",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
          stdin = true,
          cwd = util.root_file({
            "pyproject.toml",
            "ruff.toml",
            ".ruff.toml",
          }),
        },
        ruff_format = {
          -- ruff format for code formatting (replaces black)
          command = "ruff",
          args = {
            "format",
            "--force-exclude",
            "--quiet",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
          stdin = true,
          cwd = util.root_file({
            "pyproject.toml",
            "ruff.toml",
            ".ruff.toml",
          }),
        },
        prettier = {
          -- Use local prettier if available, otherwise global
          command = function(self, bufnr)
            local cmd = util.find_executable({
              "node_modules/.bin/prettier",
            }, "prettier")(self, bufnr)
            return cmd
          end,
          args = {
            "--stdin-filepath",
            "$FILENAME",
          },
          cwd = util.root_file({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            ".prettierrc.toml",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
            "package.json",
          }),
        },
        stylua = {
          -- Lua formatter for Neovim config files
          command = "stylua",
          args = {
            "--stdin-filepath",
            "$FILENAME",
            "-",
          },
          stdin = true,
          cwd = util.root_file({
            "stylua.toml",
            ".stylua.toml",
          }),
        },
      },

      -- Log level
      log_level = vim.log.levels.ERROR,

      -- Notify on format errors
      notify_on_error = true,
    })

    -- Create command to disable formatting
    vim.api.nvim_create_user_command("ConformDisable", function(args)
      if args.bang then
        -- ConformDisable! will disable formatting globally
        vim.g.disable_autoformat = true
      else
        -- ConformDisable will disable formatting for current buffer
        vim.b.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    -- Create command to enable formatting
    vim.api.nvim_create_user_command("ConformEnable", function(args)
      if args.bang then
        -- ConformEnable! will enable formatting globally
        vim.g.disable_autoformat = false
      else
        -- ConformEnable will enable formatting for current buffer
        vim.b.disable_autoformat = false
      end
    end, {
      desc = "Enable autoformat-on-save",
      bang = true,
    })
  end,
}