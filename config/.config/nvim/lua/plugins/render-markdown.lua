-- BONSAI render-markdown.nvim configuration
-- Beautiful in-editor markdown rendering with BONSAI themes

return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	ft = { "markdown" },
	config = function()
		local render_markdown = require("render-markdown")

		-- BONSAI color definitions
		local colors = {
			-- Backgrounds
			bg_deep = "#0a0e14",
			bg_primary = "#151922",
			bg_secondary = "#1e242e",
			bg_elevated = "#232933",
			-- Text
			text_primary = "#e6e8eb",
			text_secondary = "#b8bcc8",
			text_muted = "#8b92a5",
			-- Borders
			border_subtle = "#2d3441",
			border_primary = "#3d4455",
			-- Accents
			green_primary = "#7c9885",
			green_secondary = "#9db4a6",
			green_muted = "#677a70",
			blue_primary = "#82a4c7",
			blue_secondary = "#9bb5d4",
			yellow_primary = "#c7a882",
			red_primary = "#c78289",
			purple_primary = "#9882c7",
			orange_primary = "#c7975c",
		}

		-- Apply BONSAI colors to render-markdown highlights
		vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = colors.green_primary, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = colors.green_secondary, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = colors.blue_primary, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = colors.blue_secondary, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = colors.yellow_primary, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = colors.purple_primary, bold = true })

		-- Code blocks
		vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = colors.bg_secondary })
		vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = colors.bg_elevated, fg = colors.orange_primary })

		-- Lists
		vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = colors.green_primary })
		vim.api.nvim_set_hl(0, "RenderMarkdownChecked", { fg = colors.green_primary })
		vim.api.nvim_set_hl(0, "RenderMarkdownUnchecked", { fg = colors.text_muted })

		-- Tables
		vim.api.nvim_set_hl(0, "RenderMarkdownTableHead", { fg = colors.green_primary, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownTableRow", { fg = colors.text_secondary })
		vim.api.nvim_set_hl(0, "RenderMarkdownTableFill", { bg = colors.bg_secondary })

		-- Links and emphasis
		vim.api.nvim_set_hl(0, "RenderMarkdownLink", { fg = colors.blue_primary, underline = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownBold", { fg = colors.text_primary, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownItalic", { fg = colors.text_secondary, italic = true })

		-- Quotes
		vim.api.nvim_set_hl(0, "RenderMarkdownQuote", { fg = colors.text_muted, italic = true })

		-- Dash/rules
		vim.api.nvim_set_hl(0, "RenderMarkdownDash", { fg = colors.border_primary })

		render_markdown.setup({
			-- General configuration
			enabled = true,
			render_modes = { "n", "c" }, -- Normal and command mode
			anti_conceal = {
				enabled = true, -- Preserve raw markdown when needed
			},
			log_level = "error", -- Minimal logging

			-- Heading configuration with BONSAI styling
			heading = {
				enabled = true,
				sign = true,
				position = "overlay",
				icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
				signs = { "󰫎 " },
				width = "full",
				left_pad = 0,
				right_pad = 0,
				min_width = 0,
				border = false,
				border_prefix = false,
				above = "▄",
				below = "▀",
				backgrounds = {
					"RenderMarkdownH1Bg",
					"RenderMarkdownH2Bg",
					"RenderMarkdownH3Bg",
					"RenderMarkdownH4Bg",
					"RenderMarkdownH5Bg",
					"RenderMarkdownH6Bg",
				},
				foregrounds = {
					"RenderMarkdownH1",
					"RenderMarkdownH2",
					"RenderMarkdownH3",
					"RenderMarkdownH4",
					"RenderMarkdownH5",
					"RenderMarkdownH6",
				},
			},

			-- Code block configuration
			code = {
				enabled = true,
				sign = true,
				style = "normal",
				position = "left",
				language_pad = 0,
				disable_background = { "diff" },
				width = "full",
				left_pad = 0,
				right_pad = 0,
				min_width = 0,
				border = "thin",
				above = "▄",
				below = "▀",
				highlight = "RenderMarkdownCode",
				highlight_inline = "RenderMarkdownCodeInline",
			},

			-- Dash configuration
			dash = {
				enabled = true,
				icon = "─",
				width = "full",
				highlight = "RenderMarkdownDash",
			},

			-- Bullet configuration
			bullet = {
				enabled = true,
				icons = { "•", "◦", "▪", "▫" },
				right_pad = 1,
				highlight = "RenderMarkdownBullet",
			},

			-- Checkbox configuration
			checkbox = {
				enabled = true,
				unchecked = {
					icon = "󰄱 ",
					highlight = "RenderMarkdownUnchecked",
				},
				checked = {
					icon = "󰱒 ",
					highlight = "RenderMarkdownChecked",
				},
				custom = {
					todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
				},
			},

			-- Quote configuration
			quote = {
				enabled = true,
				icon = "▌",
				repeat_linebreak = false,
				highlight = "RenderMarkdownQuote",
			},

			-- Pipe table configuration
			pipe_table = {
				enabled = true,
				preset = "round",
				style = "full",
				cell = "padded",
				min_width = 0,
				border = {
					"╭", "─", "┬", "╮",
					"│", "│", "│",
					"├", "─", "┼", "┤",
					"│", "│", "│",
					"╰", "─", "┴", "╯",
				},
				alignment_indicator = "━",
				head = "RenderMarkdownTableHead",
				row = "RenderMarkdownTableRow",
				filler = "RenderMarkdownTableFill",
			},

			-- Callout configuration
			callout = {
				note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
				tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
				important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
				warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
				caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
			},

			-- Link configuration
			link = {
				enabled = true,
				image = "󰥶 ",
				email = "󰊷 ",
				hyperlink = "󰌹 ",
				highlight = "RenderMarkdownLink",
				custom = {},
			},

			-- Sign configuration
			sign = {
				enabled = true,
				highlight = "RenderMarkdownSign",
			},

			-- File types where plugin is active
			file_types = { "markdown" },

			-- Disable for large files
			latex = {
				enabled = true,
				converter = "latex2text",
				highlight = "RenderMarkdownMath",
				top_pad = 0,
				bottom_pad = 0,
			},

			-- Performance optimization for large files
			win_options = {
				conceallevel = {
					default = vim.api.nvim_get_option_value("conceallevel", {}),
					rendered = 3,
				},
				concealcursor = {
					default = vim.api.nvim_get_option_value("concealcursor", {}),
					rendered = "",
				},
			},
		})

		-- Define additional highlight groups for backgrounds
		vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = colors.bg_secondary })
		-- H2-H6 use the same background
		for i = 2, 6 do
			vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i .. "Bg", { bg = colors.bg_primary })
		end

		-- Additional highlight groups
		vim.api.nvim_set_hl(0, "RenderMarkdownInfo", { fg = colors.blue_primary })
		vim.api.nvim_set_hl(0, "RenderMarkdownSuccess", { fg = colors.green_primary })
		vim.api.nvim_set_hl(0, "RenderMarkdownHint", { fg = colors.purple_primary })
		vim.api.nvim_set_hl(0, "RenderMarkdownWarn", { fg = colors.yellow_primary })
		vim.api.nvim_set_hl(0, "RenderMarkdownError", { fg = colors.red_primary })
		vim.api.nvim_set_hl(0, "RenderMarkdownTodo", { fg = colors.orange_primary })
		vim.api.nvim_set_hl(0, "RenderMarkdownSign", { fg = colors.text_muted })
		vim.api.nvim_set_hl(0, "RenderMarkdownMath", { fg = colors.purple_primary })

		-- Keymapping for toggling render
		vim.keymap.set("n", "<leader>mr", function()
			render_markdown.toggle()
		end, { desc = "Toggle markdown rendering" })
	end,
}