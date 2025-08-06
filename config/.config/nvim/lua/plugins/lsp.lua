-- BONSAI LSP configuration with Mason
-- Provides language intelligence for Python, JavaScript/TypeScript, and Tailwind CSS

return {
  -- Mason for LSP server management
  {
    "mason-org/mason.nvim",
    lazy = false,  -- Mason should load early
    priority = 100,
    opts = {
      ui = {
        border = "rounded",
        backdrop = 100,
        icons = {
          package_installed = "✓",
          package_pending = "◍",
          package_uninstalled = "✗"
        }
      }
    }
  },

  -- Bridge between Mason and lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    priority = 90,
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "pyright",                    -- Python
        "ts_ls",                      -- TypeScript/JavaScript (new name for typescript-language-server)
        "tailwindcss",                -- Tailwind CSS
        "ruff",                       -- An extremely fast Python linter and code formatter, written in Rust.
      },
      automatic_enable = true,  -- Auto-enable installed servers
    }
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    priority = 80,
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- Configure diagnostics (includes sign configuration)
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "always",  -- Always show diagnostic source  -- Show source if multiple sources
          spacing = 4,
          -- Show all severities or adjust as needed:
          -- severity = vim.diagnostic.severity.ERROR,  -- Only errors
          -- severity = { min = vim.diagnostic.severity.WARN },  -- WARN and above
          severity = { min = vim.diagnostic.severity.HINT },  -- All diagnostics (HINT, INFO, WARN, ERROR)
        },
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",  -- Always show diagnostic source
          header = "",
          prefix = "",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✗",
            [vim.diagnostic.severity.WARN] = "⚠",
            [vim.diagnostic.severity.HINT] = "➤",
            [vim.diagnostic.severity.INFO] = "i",
          },
        },
        underline = true,
        update_in_insert = false,  -- Don't update diagnostics in insert mode
        severity_sort = true,
      })

      -- Configure hover and signature help windows
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        width = 60,
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        width = 60,
      })

      -- Setup keymaps when LSP attaches
      local on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gr", vim.lsp.buf.references, "Go to references")
        map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")

        -- Documentation
        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map("n", "<leader>cs", vim.lsp.buf.signature_help, "Code signature help")

        -- Code actions
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>cr", vim.lsp.buf.rename, "Code rename")
        map("n", "<leader>cd", vim.lsp.buf.definition, "Code definition")
        map("n", "<leader>ci", vim.lsp.buf.implementation, "Code implementation")
        map("n", "<leader>ch", vim.lsp.buf.hover, "Code hover documentation")

        -- Diagnostics
        map("n", "<leader>df", vim.diagnostic.open_float, "Diagnostics float")
        map("n", "<leader>dd", "<cmd>Telescope diagnostics<cr>", "Diagnostics list")
        map("n", "<leader>dn", vim.diagnostic.goto_next, "Diagnostics next")
        map("n", "<leader>dp", vim.diagnostic.goto_prev, "Diagnostics previous")
        map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")

        -- Workspace
        map("n", "<leader>cw", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        map("n", "<leader>cW", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        map("n", "<leader>cl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "List workspace folders")

        -- Enable inlay hints if supported
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end

      -- Configure servers with capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Integrate with nvim-cmp
      local has_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp_lsp then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
      else
        -- Fallback: Enhanced capabilities for better completion
        capabilities.textDocument.completion.completionItem = {
          documentationFormat = { "markdown", "plaintext" },
          snippetSupport = true,
          preselectSupport = true,
          insertReplaceSupport = true,
          labelDetailsSupport = true,
          deprecatedSupport = true,
          commitCharactersSupport = true,
          tagSupport = { valueSet = { 1 } },
          resolveSupport = {
            properties = {
              "documentation",
              "detail",
              "additionalTextEdits",
            },
          },
        }
      end

      -- Server-specific configurations
      local servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "standard",
              },
            },
          },
        },
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
              },
            },
          },
        },
      }

      -- Setup servers
      local lspconfig = require("lspconfig")

      for server, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end

    end,
  },
}
