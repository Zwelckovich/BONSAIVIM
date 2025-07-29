-- BONSAI nvim-autopairs configuration
-- Automatic bracket/quote pairing with context awareness

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/nvim-cmp", -- Integration with completion
	},
	config = function()
		local autopairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")

		-- BONSAI minimal configuration
		autopairs.setup({
			-- Smart pairing for brackets, quotes, and backticks
			check_ts = true, -- Enable treesitter integration
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				python = { "string" },
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" },
			disable_in_macro = true, -- Disable in macros for safety
			disable_in_visualblock = false, -- Works in visual block mode
			disable_in_replace_mode = true,
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=], -- Don't pair if next char matches
			enable_moveright = true,
			enable_afterquote = true, -- Add pair after quote
			enable_check_bracket_line = true, -- Check for existing pairs on line
			enable_bracket_in_quote = true, -- Allow brackets in quotes
			enable_abbr = false, -- No abbreviation expansion
			break_undo = true, -- Break undo sequence after pair

			-- Fast wrap configuration
			fast_wrap = {
				map = "<M-e>", -- Alt-e to wrap
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})

		-- Integration with nvim-cmp
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")

		-- Make autopairs and completion work together
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- Custom rules for markdown
		autopairs.add_rules({
			-- Triple asterisk for bold italic in markdown
			Rule("***", "***", "markdown"):with_pair(function()
				return true
			end),

			-- Triple backtick for code blocks
			Rule("```", "```", "markdown"):with_pair(function(opts)
				return opts.line:sub(1, opts.col - 1):match("^%s*$") ~= nil
			end),

			-- HTML tag completion
			Rule("<", ">", { "html", "xml", "markdown" })
				:with_pair(cond.not_inside_quote())
				:with_move(cond.done())
				:use_key(">"),
		})

		-- Language-specific rules
		local langs = { "python", "lua", "javascript", "typescript", "javascriptreact", "typescriptreact" }

		for _, lang in ipairs(langs) do
			-- Triple quotes for Python/JS docstrings
			autopairs.add_rules({
				Rule('"""', '"""', lang):with_pair(cond.not_inside_quote()),
				Rule("'''", "'''", lang):with_pair(cond.not_inside_quote()),
			})
		end

		-- React/JSX specific
		autopairs.add_rules({
			-- Self-closing tags
			Rule("<", "/>", { "javascriptreact", "typescriptreact" })
				:with_pair(cond.not_inside_quote())
				:with_move(cond.done())
				:use_key("/>")
				:replace_endpair(function(opts)
					return opts.prev_char:match("%w") and "/>" or ""
				end),
		})
	end,
}
