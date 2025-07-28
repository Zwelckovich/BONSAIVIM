-- BONSAI nvim-cmp configuration
-- Minimal completion setup with LuaSnip integration

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Basic completion sources
    "hrsh7th/cmp-nvim-lsp",     -- LSP completions
    "hrsh7th/cmp-buffer",        -- Buffer completions
    "hrsh7th/cmp-path",          -- Path completions
    "hrsh7th/cmp-cmdline",       -- Command line completions
    "saadparwaiz1/cmp_luasnip",  -- LuaSnip completions
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- BONSAI colors for completion menu
    local colors = {
      green_primary = "#7c9885",
      green_muted = "#677a70",
      blue_primary = "#82a4c7",
      yellow_primary = "#c7a882",
      text_primary = "#e6e8eb",
      text_muted = "#8b92a5",
      bg_primary = "#151922",
      bg_secondary = "#1e242e",
      bg_elevated = "#232933",
    }

    -- Apply BONSAI colors to completion menu
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = colors.green_primary, bold = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = colors.green_primary })
    vim.api.nvim_set_hl(0, "CmpItemKindDefault", { fg = colors.text_muted })
    vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = colors.text_muted })
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = colors.text_muted, strikethrough = true })

    -- Kind highlights
    vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = colors.blue_primary })
    vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = colors.blue_primary })
    vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = colors.green_primary })
    vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = colors.yellow_primary })
    vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = colors.yellow_primary })
    vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = colors.yellow_primary })
    vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = colors.green_primary })

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        -- Navigation
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept only explicitly selected item

        -- Tab/Shift-Tab handled by LuaSnip directly
        -- This ensures snippets take priority over completion
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500, keyword_length = 3 },
        { name = "path", priority = 250 },
      }),

      formatting = {
        format = function(entry, vim_item)
          -- Kind icons
          local kind_icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
          }

          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)

          -- Source labels
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
          })[entry.source.name]

          return vim_item
        end,
      },

      window = {
        completion = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        },
      },

      experimental = {
        ghost_text = false, -- Disable ghost text to avoid conflicts
      },
    })

    -- Setup completion for specific filetypes
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "buffer" },
      }),
    })

    -- Command line completion
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })
  end,
}