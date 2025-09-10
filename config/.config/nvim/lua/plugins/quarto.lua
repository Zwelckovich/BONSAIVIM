-- BONSAI Quarto plugin configuration
-- Provides support for Quarto scientific and technical publishing

return {
	"quarto-dev/quarto-nvim",
	ft = { "quarto", "markdown" },
	lazy = true,
	opts = {
		lspFeatures = {
			enabled = true,
			chunks = "curly",
		},
		codeRunner = {
			enabled = true,
			default_method = "slime",
		},
	},
	dependencies = {
		-- for language features in code cells
		-- configured in lua/plugins/lsp.lua
		"jmbuhr/otter.nvim",
	},
	config = function(_, opts)
		local quarto = require("quarto")
		quarto.setup(opts)

		-- Set up Quarto-specific keymaps
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "quarto", "markdown" },
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				local file = vim.api.nvim_buf_get_name(buf)

				-- Only set keymaps for .qmd files
				if not file:match("%.qmd$") then
					return
				end

				local opts_local = { buffer = true, silent = true }

				-- Quarto preview
				vim.keymap.set("n", "<leader>Qp", function()
					vim.cmd("QuartoPreview")
				end, vim.tbl_extend("error", opts_local, { desc = "Quarto Preview" }))

				-- Close preview
				vim.keymap.set("n", "<leader>Qc", function()
					vim.cmd("QuartoClosePreview")
				end, vim.tbl_extend("error", opts_local, { desc = "Close Quarto Preview" }))

				-- Quarto help
				vim.keymap.set("n", "<leader>Qh", function()
					vim.cmd("QuartoHelp")
				end, vim.tbl_extend("error", opts_local, { desc = "Quarto Help" }))

				-- Code running keymaps
				local runner = require("quarto.runner")

				-- Run current cell
				vim.keymap.set(
					"n",
					"<leader>Qr",
					runner.run_cell,
					vim.tbl_extend("error", opts_local, { desc = "Run current cell" })
				)

				-- Run cell and above
				vim.keymap.set(
					"n",
					"<leader>Qa",
					runner.run_above,
					vim.tbl_extend("error", opts_local, { desc = "Run cell and above" })
				)

				-- Run all cells
				vim.keymap.set(
					"n",
					"<leader>QA",
					runner.run_all,
					vim.tbl_extend("error", opts_local, { desc = "Run all cells" })
				)

				-- Run current line
				vim.keymap.set(
					"n",
					"<leader>Ql",
					runner.run_line,
					vim.tbl_extend("error", opts_local, { desc = "Run current line" })
				)

				-- Run visual selection
				vim.keymap.set(
					"v",
					"<leader>Qr",
					runner.run_range,
					vim.tbl_extend("error", opts_local, { desc = "Run visual selection" })
				)

				-- Run all cells of all languages
				vim.keymap.set("n", "<leader>QR", function()
					runner.run_all(true)
				end, vim.tbl_extend("error", opts_local, { desc = "Run all cells (all languages)" }))

				-- Send commands
				vim.keymap.set(
					"n",
					"<leader>Qs",
					"<cmd>QuartoSend<cr>",
					vim.tbl_extend("error", opts_local, { desc = "Send to terminal" })
				)

				vim.keymap.set(
					"n",
					"<leader>QS",
					"<cmd>QuartoSendAll<cr>",
					vim.tbl_extend("error", opts_local, { desc = "Send all to terminal" })
				)

				-- Activate Quarto
				vim.keymap.set(
					"n",
					"<leader>Qi",
					"<cmd>QuartoActivate<cr>",
					vim.tbl_extend("error", opts_local, { desc = "Activate Quarto" })
				)

				-- Diagnostics
				vim.keymap.set(
					"n",
					"<leader>Qd",
					"<cmd>QuartoDiagnostics<cr>",
					vim.tbl_extend("error", opts_local, { desc = "Quarto Diagnostics" })
				)
			end,
		})
	end,
}
