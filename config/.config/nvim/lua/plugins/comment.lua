-- BONSAI Comment.nvim configuration
-- Smart language-aware commenting

return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- For JSX/TSX comment context
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local comment = require("Comment")
		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		comment.setup({
			-- Add space after comment delimiter
			padding = true,
			-- Use sticky cursor (stay in place)
			sticky = true,
			-- Ignore empty lines
			ignore = "^$",

			-- Keybindings (using default vim-commentary style)
			toggler = {
				-- Line comment toggle
				line = "gcc",
				-- Block comment toggle
				block = "gbc",
			},
			opleader = {
				-- Line comment motion
				line = "gc",
				-- Block comment motion
				block = "gb",
			},
			extra = {
				-- Comment line above
				above = "gcO",
				-- Comment line below
				below = "gco",
				-- Comment at end of line
				eol = "gcA",
			},

			-- Enable keybindings
			mappings = {
				-- Operator-pending mapping (gc{motion})
				basic = true,
				-- Extra mappings (gco, gcO, gcA)
				extra = true,
			},

			-- Pre-hook for embedded language support (JSX, TSX, etc.)
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})

		-- Additional keymaps for visual mode to ensure consistency
		local api = require("Comment.api")
		vim.keymap.set("n", "<leader>c/", function()
			api.toggle.linewise.current()
		end, { desc = "Toggle comment" })

		vim.keymap.set("v", "<leader>c/", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
			api.toggle.linewise(vim.fn.visualmode())
		end, { desc = "Toggle comment (visual)" })
	end,
}
