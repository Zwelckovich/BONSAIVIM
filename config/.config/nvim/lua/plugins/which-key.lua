-- BONSAI which-key configuration
-- Interactive keybinding discovery and visualization

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {},
	config = function(_, opts)
		local wk = require("which-key")

		-- BONSAI color definitions
		local colors = {
			bg_primary = "#151922",
			bg_secondary = "#1e242e",
			bg_elevated = "#232933",
			text_primary = "#e6e8eb",
			text_secondary = "#b8bcc8",
			text_muted = "#8b92a5",
			border_subtle = "#2d3441",
			green_primary = "#7c9885",
			blue_primary = "#82a4c7",
			yellow_primary = "#c7a882",
			purple_primary = "#9882c7",
		}

		-- Apply BONSAI colors
		vim.api.nvim_set_hl(0, "WhichKey", { fg = colors.green_primary })
		vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = colors.blue_primary })
		vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = colors.text_secondary })
		vim.api.nvim_set_hl(0, "WhichKeySeperator", { fg = colors.text_muted })
		vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = colors.text_muted })
		vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = colors.bg_primary })
		vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = colors.border_subtle, bg = colors.bg_primary })
		vim.api.nvim_set_hl(0, "WhichKeyValue", { fg = colors.yellow_primary })

		-- Merge opts with our configuration
		local setup_opts = vim.tbl_deep_extend("force", {
			-- Try the helix preset which provides right-side panel
			preset = "helix",
			win = {
				border = "rounded",
				wo = {
					winblend = 0, -- No transparency
				},
			},
		}, opts)

		wk.setup(setup_opts)

		-- Register key groups only - mappings are defined in their respective files
		wk.add({
			-- Groups
			{ "<leader>b", group = "buffer" },
			{ "<leader>c", group = "code" },
			{ "<leader>d", group = "diagnostics" },

			-- Code action placeholders (actual mappings in lsp.lua on_attach)
			{ "<leader>ca", desc = "Code action (LSP required)" },
			{ "<leader>cr", desc = "Code rename (LSP required)" },
			{ "<leader>cd", desc = "Code definition (LSP required)" },
			{ "<leader>ci", desc = "Code implementation (LSP required)" },
			{ "<leader>ch", desc = "Code hover (LSP required)" },
			{ "<leader>cs", desc = "Code signature help (LSP required)" },
			{ "<leader>cw", desc = "Add workspace folder (LSP required)" },
			{ "<leader>cW", desc = "Remove workspace folder (LSP required)" },
			{ "<leader>cl", desc = "List workspace folders (LSP required)" },

			-- Conform formatter info
			{ "<leader>cI", "<cmd>ConformInfo<cr>", desc = "Show formatter info" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>gh", group = "git hunks" },

			-- Git operations (lazygit.nvim mappings)
			{ "<leader>gg", desc = "LazyGit" },
			{ "<leader>gf", desc = "LazyGit current file" },
			{ "<leader>gF", desc = "LazyGit filter (project)" },
			{ "<leader>h", group = "harpoon" },
			{ "<leader>j", group = "jump" },
			{ "<leader>m", group = "markdown" },
			{ "<leader>mp", desc = "Toggle markdown preview" },
			{ "<leader>mr", desc = "Toggle markdown rendering" },
			{ "<leader>p", group = "persistence" },
			{ "<leader>q", group = "quit" },
			{ "<leader>s", group = "search" },
			{ "<leader>t", group = "toggle/terminal" },
			{ "<leader>w", group = "window" },
			{ "<leader>x", group = "execute" },
			{ "<leader>y", group = "yazi" },
			{ "<leader>z", group = "zen" },
		})

		-- Register descriptions for existing mappings (don't duplicate the mappings)
		-- These mappings are defined in other files
		wk.add({
			-- Describe existing navigation mappings
			{ "[f", desc = "Previous function" },
			{ "]f", desc = "Next function" },
			{ "[c", desc = "Previous git hunk" },
			{ "]c", desc = "Next git hunk" },
			{ "[[", desc = "Previous class" },
			{ "]]", desc = "Next class" },

			-- Flash navigation descriptions
			{ "s", desc = "Flash forward" },
			{ "S", desc = "Flash backward" },

			-- Undotree toggle (mapping defined in undotree.lua)
			{ "<leader>u", desc = "Toggle undotree" },

			-- Diagnostic toggles (mappings defined in keymaps.lua)
			{ "<leader>td", desc = "Toggle diagnostics virtual text" },
			{ "<leader>tV", desc = "Cycle diagnostic display modes" },
			{ "<leader>tD", desc = "Toggle all diagnostics" },

			-- Buffer management (mappings defined in bufferline.lua)
			{ "<leader>bp", desc = "Pick buffer (interactive)" },
			{ "<leader>bc", desc = "Pick buffer to close" },
			{ "<leader>bh", desc = "Close buffers to the left" },
			{ "<leader>bl", desc = "Close buffers to the right" },
			{ "<leader>bo", desc = "Close other buffers" },

			-- Harpoon quick navigation (mappings defined in harpoon.lua)
			{ "<leader>1", desc = "Harpoon file 1" },
			{ "<leader>2", desc = "Harpoon file 2" },
			{ "<leader>3", desc = "Harpoon file 3" },
			{ "<leader>4", desc = "Harpoon file 4" },
			{ "<leader>5", desc = "Harpoon file 5" },
			{ "<leader>6", desc = "Harpoon file 6" },
			{ "<leader>7", desc = "Harpoon file 7" },
			{ "<leader>8", desc = "Harpoon file 8" },
			{ "<leader>9", desc = "Harpoon file 9" },

			-- Harpoon attach to specific position (mappings defined in harpoon.lua)
			{ "<leader>h1", desc = "Attach to harpoon 1" },
			{ "<leader>h2", desc = "Attach to harpoon 2" },
			{ "<leader>h3", desc = "Attach to harpoon 3" },
			{ "<leader>h4", desc = "Attach to harpoon 4" },
			{ "<leader>h5", desc = "Attach to harpoon 5" },
			{ "<leader>h6", desc = "Attach to harpoon 6" },
			{ "<leader>h7", desc = "Attach to harpoon 7" },
			{ "<leader>h8", desc = "Attach to harpoon 8" },
			{ "<leader>h9", desc = "Attach to harpoon 9" },

			-- Lazy plugin manager
			{ "<leader>L", "<cmd>Lazy<cr>", desc = "Open Lazy plugin manager" },

			-- Terminal operations (mappings defined in toggleterm.lua)
			{ "<leader>tf", desc = "Terminal float" },
			{ "<leader>th", desc = "Terminal horizontal" },
			{ "<leader>tv", desc = "Terminal vertical" },
			{ "<leader>tp", desc = "Terminal Python REPL" },
			{ "<leader>tn", desc = "Terminal Node REPL" },
			{ "<leader>tr", desc = "Terminal run current file" },
		})
	end,
}
