-- BONSAI LuaSnip configuration
-- Practical snippets with Tab/Shift-Tab navigation

return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = {
    -- Community snippets collection
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    -- nvim-cmp integration
    "saadparwaiz1/cmp_luasnip",
  },
  event = "InsertEnter",
  config = function()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")

    -- Configuration
    ls.config.set_config({
      -- Keep snippet active while jumping
      history = true,

      -- Update snippets as you type
      updateevents = "TextChanged,TextChangedI",

      -- Enable autotrigger snippets
      enable_autosnippets = true,

      -- Visual placeholder configuration
      store_selection_keys = "<Tab>",

      -- Highlight snippet nodes
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "●", "DiagnosticOk" } },
          },
        },
        [types.insertNode] = {
          active = {
            virt_text = { { "●", "DiagnosticInfo" } },
          },
        },
      },
    })

    -- Load snippets from multiple sources
    -- 1. VSCode-style snippets (from friendly-snippets and custom)
    require("luasnip.loaders.from_vscode").lazy_load()

    -- 2. SnipMate-style snippets
    require("luasnip.loaders.from_snipmate").lazy_load()

    -- 3. Lua snippets (for more complex snippets)
    require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })

    -- Custom snippets for Python and JavaScript
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node

    -- Python snippets
    ls.add_snippets("python", {
      -- Docstring with type hints
      s("docstring", {
        t('"""'),
        i(1, "Brief description"),
        t({ "", "", "Args:" }),
        t({ "", "    " }), i(2, "arg_name"), t(" ("), i(3, "type"), t("): "), i(4, "description"),
        t({ "", "", "Returns:" }),
        t({ "", "    " }), i(5, "type"), t(": "), i(6, "description"),
        t({ "", '"""' }),
      }),

      -- Type-hinted function
      s("deft", {
        t("def "), i(1, "function_name"), t("("),
        i(2, "args"), t(") -> "), i(3, "return_type"), t(":"),
        t({ "", '    """' }),
        i(4, "Brief description"),
        t({ '"""', "    " }),
        i(0),
      }),

      -- Main block
      s("main", {
        t({ 'if __name__ == "__main__":', "    " }),
        i(0),
      }),
    })

    -- JavaScript/React snippets
    ls.add_snippets("javascript", {
      -- ES6 arrow function
      s("arrow", {
        t("const "), i(1, "name"), t(" = ("), i(2, "params"), t(") => "),
        c(3, {
          t("{"),
          t("("),
        }),
        t({ "", "  " }), i(4),
        t({ "", "" }),
        c(5, {
          t("}"),
          t(")"),
        }),
      }),

      -- React functional component
      s("rfc", {
        t("const "), i(1, "ComponentName"), t(" = ("), i(2, "props"), t(") => {"),
        t({ "", "  return (" }),
        t({ "", "    " }), i(3, "<div>Component</div>"),
        t({ "", "  )" }),
        t({ "", "}" }),
        t({ "", "", "export default " }), f(function(args) return args[1][1] end, { 1 }),
      }),

      -- React hook - useState
      s("useState", {
        t("const ["), i(1, "state"), t(", set"),
        f(function(args)
          return args[1][1]:sub(1, 1):upper() .. args[1][1]:sub(2)
        end, { 1 }),
        t("] = useState("), i(2, "initialValue"), t(")"),
      }),

      -- React hook - useEffect
      s("useEffect", {
        t("useEffect(() => {"),
        t({ "", "  " }), i(1),
        t({ "", "}, [" }), i(2), t("])"),
      }),
    })

    -- HTML snippets
    ls.add_snippets("html", {
      -- Basic HTML template
      s("html5", {
        t({ '<!DOCTYPE html>', '<html lang="en">', '<head>' }),
        t({ "", '  <meta charset="UTF-8">' }),
        t({ "", '  <meta name="viewport" content="width=device-width, initial-scale=1.0">' }),
        t({ "", "  <title>" }), i(1, "Document"), t({ "</title>", "</head>" }),
        t({ "", "<body>", "  " }), i(0),
        t({ "", "</body>", "</html>" }),
      }),
    })

    -- Markdown snippets
    ls.add_snippets("markdown", {
      -- Code block
      s("code", {
        t("```"), i(1, "language"),
        t({ "", "" }), i(2, "code"),
        t({ "", "```" }),
      }),
    })

    -- Key mappings for Tab/Shift-Tab navigation
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        -- If not in a snippet, insert a regular tab
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
      end
    end, { desc = "Expand snippet or jump to next placeholder" })

    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      else
        -- If not in a snippet, insert a regular shift-tab
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
      end
    end, { desc = "Jump to previous placeholder" })

    -- Choice node navigation
    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { desc = "Next choice" })

    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end, { desc = "Previous choice" })
  end,
}