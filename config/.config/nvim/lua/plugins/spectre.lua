-- BONSAI nvim-spectre configuration
-- Advanced search and replace functionality with live preview

return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>ss",
			function()
				require("spectre").open()
			end,
			desc = "Search (Spectre)",
		},
		{
			"<leader>sw",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Search word (Spectre)",
		},
		{
			"<leader>sw",
			function()
				require("spectre").open_visual()
			end,
			mode = "v",
			desc = "Search selection (Spectre)",
		},
		{
			"<leader>sp",
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			desc = "Search in file (Spectre)",
		},
		{
			"<leader>sr",
			function()
				require("spectre").open()
			end,
			desc = "Search and replace (Spectre)",
		},
	},
	config = function()
		local spectre = require("spectre")

		-- BONSAI color definitions
		local colors = {
			bg_deep = "#0a0e14",
			bg_primary = "#151922",
			bg_secondary = "#1e242e",
			bg_elevated = "#232933",
			text_primary = "#e6e8eb",
			text_secondary = "#b8bcc8",
			text_muted = "#8b92a5",
			border_subtle = "#2d3441",
			border_primary = "#3d4455",
			green_primary = "#7c9885",
			green_secondary = "#9db4a6",
			red_primary = "#c78289",
			red_secondary = "#d4999f",
			blue_primary = "#82a4c7",
			blue_secondary = "#9bb5d4",
			yellow_primary = "#c7a882",
			yellow_secondary = "#d4b99b",
			purple_primary = "#9882c7",
		}

		-- Apply BONSAI colors to Spectre
		local set_hl = vim.api.nvim_set_hl
		set_hl(0, "SpectreSearch", { bg = colors.yellow_primary, fg = colors.bg_deep })
		set_hl(0, "SpectreReplace", { bg = colors.green_primary, fg = colors.bg_deep })
		set_hl(0, "SpectreBorder", { fg = colors.border_subtle })
		set_hl(0, "SpectreDir", { fg = colors.blue_primary })
		set_hl(0, "SpectreFile", { fg = colors.text_secondary })
		set_hl(0, "SpectreBody", { fg = colors.text_muted })
		set_hl(0, "SpectreHeader", { fg = colors.purple_primary })

		spectre.setup({
			color_devicons = true,
			open_cmd = "noswapfile vnew", -- Open in vertical split
			live_update = true, -- Update search results as you type
			line_sep_start = "┌─────────────────────────────────────────",
			result_padding = "│  ",
			line_sep = "└─────────────────────────────────────────",
			highlight = {
				ui = "String",
				search = "SpectreSearch",
				replace = "SpectreReplace",
			},
			mapping = {
				["toggle_line"] = {
					map = "dd",
					cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
					desc = "toggle current item",
				},
				["enter_file"] = {
					map = "<cr>",
					cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
					desc = "go to current file",
				},
				["send_to_qf"] = {
					map = "<leader>q",
					cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
					desc = "send all items to quickfix",
				},
				["replace_cmd"] = {
					map = "<leader>c",
					cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
					desc = "input replace command",
				},
				["show_option_menu"] = {
					map = "<leader>o",
					cmd = "<cmd>lua require('spectre').show_options()<CR>",
					desc = "show options",
				},
				["run_current_replace"] = {
					map = "<leader>rc",
					cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
					desc = "replace current line",
				},
				["run_replace"] = {
					map = "<leader>R",
					cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
					desc = "replace all",
				},
				["change_view_mode"] = {
					map = "<leader>v",
					cmd = "<cmd>lua require('spectre').change_view()<CR>",
					desc = "change result view mode",
				},
				["change_replace_sed"] = {
					map = "trs",
					cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
					desc = "use sed to replace",
				},
				["change_replace_oxi"] = {
					map = "tro",
					cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
					desc = "use oxi to replace",
				},
				["toggle_live_update"] = {
					map = "tu",
					cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
					desc = "toggle live update",
				},
				["toggle_ignore_case"] = {
					map = "ti",
					cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
					desc = "toggle ignore case",
				},
				["toggle_ignore_hidden"] = {
					map = "th",
					cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
					desc = "toggle search hidden",
				},
				["resume_last_search"] = {
					map = "<leader>l",
					cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
					desc = "resume last search before close",
				},
			},
			find_engine = {
				-- rg is default, also supports fd
				["rg"] = {
					cmd = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					options = {
						["ignore-case"] = {
							value = "--ignore-case",
							icon = "[I]",
							desc = "ignore case",
						},
						["hidden"] = {
							value = "--hidden",
							desc = "hidden files",
							icon = "[H]",
						},
						["no-ignore"] = {
							value = "--no-ignore",
							desc = "no ignore",
							icon = "[NI]",
						},
					},
				},
			},
			replace_engine = {
				["sed"] = {
					cmd = "sed",
					args = nil,
					options = {
						["ignore-case"] = {
							value = "--ignore-case",
							desc = "ignore case",
							icon = "[I]",
						},
					},
				},
				["oxi"] = {
					cmd = "oxi",
					args = {},
					options = {
						["ignore-case"] = {
							value = "-i",
							icon = "[I]",
							desc = "ignore case",
						},
					},
				},
			},
			default = {
				find = {
					cmd = "rg",
					options = { "ignore-case" },
				},
				replace = {
					cmd = "sed",
				},
			},
			replace_vim_cmd = "cdo",
			is_open_target_win = true,
			is_insert_mode = false,
		})
	end,
}
