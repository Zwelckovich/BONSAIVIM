-- BONSAI nvim-treesitter configuration
-- Syntax highlighting and code understanding with performance optimizations

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      return
    end

    -- Disable treesitter for large files
    vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
      callback = function()
        local max_filesize = 1024 * 1024 -- 1MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
        if ok and stats and stats.size > max_filesize then
          vim.cmd("setlocal syntax=off")
          vim.b.large_file = true
        end
      end,
    })

    configs.setup({
      -- Only install parsers for languages we actually use
      ensure_installed = {
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "lua",
        "vim",
        "vimdoc",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      highlight = {
        enable = true,
        -- Disable for large files
        disable = function(lang, buf)
          return vim.b[buf].large_file
        end,
        -- Disable slow treesitter highlight for large files
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
        disable = function(lang, buf)
          return vim.b[buf].large_file
        end,
      },

      -- Enable incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<Tab>",
          node_decremental = "<S-Tab>",
        },
      },

      -- Text objects for functions and classes
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["as"] = "@scope",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    })

    -- Use treesitter for folding
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false -- Don't fold by default
  end,
}