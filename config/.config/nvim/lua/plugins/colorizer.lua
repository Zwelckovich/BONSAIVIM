-- BONSAI nvim-colorizer configuration
-- Visual inline preview of hex colors, RGB, HSL values

return {
	"catgoose/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		filetypes = {
			"*", -- Enable for all files by default
			-- Specific configurations for certain filetypes
			css = { rgb_fn = true, hsl_fn = true },
			html = { mode = "background" },
			javascript = { mode = "background" },
			typescript = { mode = "background" },
			javascriptreact = { mode = "background", tailwind = true },
			typescriptreact = { mode = "background", tailwind = true },
			lua = { mode = "background" },
		},
		user_default_options = {
			RGB = true, -- #RGB hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			names = true, -- "Name" codes like Blue or red
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = false, -- 0xAARRGGBB hex codes
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			css = true, -- Enable all CSS features
			css_fn = true, -- Enable all CSS *functions*
			-- Available modes for display: foreground / background / virtualtext
			mode = "background", -- Set the display mode
			-- Available methods: false / "normal" / "lsp" / "both"
			tailwind = "both", -- Enable tailwind colors
			-- parsers can contain values used in |user_default_options|
			sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
			virtualtext = "■", -- Virtual text character to use
			-- update color values even if buffer is not focused
			always_update = false,
		},
		-- all the sub-options of filetypes apply to buftypes
		buftypes = {},
	},
	config = function(_, opts)
		require("colorizer").setup(opts)

		-- Add keybinding for toggling colorizer (plugin provides ColorizerToggle command)
		vim.keymap.set("n", "<leader>tc", "<cmd>ColorizerToggle<cr>", { desc = "Toggle colorizer" })
	end,
}
