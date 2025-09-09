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
        -- For Typst files, use LSP formatting directly since Tinymist doesn't advertise capability properly
        if vim.bo.filetype == "typst" then
          vim.lsp.buf.format({ async = false })
        else
          require("conform").format({ async = true, lsp_fallback = true })
        end
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
        sh = { "shfmt" },
        bash = { "shfmt" },
        -- typst formatting is handled by LSP directly (Tinymist)
      },

      -- Format on save configuration
      format_on_save = function(bufnr)
        -- Get the filetype
        local ft = vim.bo[bufnr].filetype
        
        -- For shell scripts, run our custom comment aligner after formatting
        if ft == "sh" or ft == "bash" then
          -- Run normal formatters first
          require("conform").format({
            bufnr = bufnr,
            timeout_ms = 1000,
            lsp_fallback = true,
          })
          -- Then align comments
          local ok, aligner = pcall(require, "bonsai.align-comments")
          if ok then
            aligner.align_bash_comments()
          end
          return false  -- Don't run format again
        end
        
        -- For other files, use default behavior
        return {
          timeout_ms = 1000,
          lsp_fallback = true,
        }
      end,

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
        shfmt = {
          -- Shell script formatter
          command = "shfmt",
          args = {
            "-i", "2",     -- Use 2 spaces for indentation
            "-bn",         -- Binary operators at start of line
            "-ci",         -- Indent switch cases
            "-sr",         -- Keep column alignment paddings
            "-kp",         -- Keep column alignment for pipes
            "-filename", "$FILENAME",
            "-",
          },
          stdin = true,
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