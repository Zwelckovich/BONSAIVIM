-- BONSAI table-mode configuration
-- Efficient markdown table creation and editing

return {
	"dhruvasagar/vim-table-mode",
	ft = { "markdown", "text", "org" },
	keys = {
		{ "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle table mode" },
		{ "<leader>tt", "<cmd>Tableize<cr>", desc = "Tableize CSV/TSV data", mode = "v" },
		{ "<leader>tdd", "<cmd>TableModeDeleteRow<cr>", desc = "Delete table row" },
		{ "<leader>tdc", "<cmd>TableModeDeleteColumn<cr>", desc = "Delete table column" },
		{ "<leader>tic", "<cmd>TableModeInsertColumn<cr>", desc = "Insert table column" },
		{ "<leader>tir", "<cmd>TableModeInsertRow<cr>", desc = "Insert table row" },
	},
	config = function()
		-- Core table mode settings
		vim.g.table_mode_corner = "|"
		vim.g.table_mode_corner_corner = "+"
		vim.g.table_mode_header_fillchar = "-"
		vim.g.table_mode_auto_align = 1
		vim.g.table_mode_delimiter = ","
		vim.g.table_mode_syntax = 1

		-- Table cell navigation
		vim.g.table_mode_motion_up_map = "[t"
		vim.g.table_mode_motion_down_map = "]t"
		vim.g.table_mode_motion_left_map = "[T"
		vim.g.table_mode_motion_right_map = "]T"

		-- Cell text objects
		vim.g.table_mode_cell_text_object_a_map = "atc"
		vim.g.table_mode_cell_text_object_i_map = "itc"

		-- BONSAI color integration
		local function set_table_colors()
			vim.api.nvim_set_hl(0, "TableModeBorder", { fg = "#7c9885" })
			vim.api.nvim_set_hl(0, "TableModeHeader", { fg = "#82a4c7", bold = true })
			vim.api.nvim_set_hl(0, "TableModeSeparator", { fg = "#8b92a5" })
		end

		-- Apply colors immediately and on colorscheme changes
		set_table_colors()
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = set_table_colors,
		})
	end,
}
