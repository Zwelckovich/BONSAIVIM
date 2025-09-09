-- BONSAI Typst configuration with Tinymist LSP and Zathura preview
-- Provides syntax highlighting, LSP support, and PDF preview with bidirectional navigation

return {
	-- Typst syntax highlighting and base support
	{
		"kaarmu/typst.vim",
		ft = "typst",
		lazy = true,
		config = function()
			-- Configure Typst settings
			vim.g.typst_cmd = "typst"
			vim.g.typst_conceal = 0 -- Disable concealing by default
			vim.g.typst_auto_open_quickfix = false -- Don't auto-open quickfix

			-- Set PDF viewer to Zathura for forward search
			vim.g.typst_pdf_viewer = "zathura"
		end,
	},

	-- Tinymist LSP configuration (handled in lsp.lua)
	-- The LSP provides:
	-- - Code completion
	-- - Go to definition
	-- - Hover documentation
	-- - Diagnostics
	-- - Formatting
	-- - Live preview server

	-- Preview configuration
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		lazy = true,
		version = "1.*",
		build = function()
			require("typst-preview").update()
		end,
		config = function()
			require("typst-preview").setup({
				-- The preview opens in your default browser
				-- Install websocat first: sudo pacman -S websocat

				-- Dependencies for the preview server
				dependencies_bin = {
					["typst-preview"] = "tinymist",
					["websocat"] = "websocat",
				},

				-- Preview server settings
				get_root = function(path_of_main_file)
					-- Use the directory of the main file as root
					return vim.fn.fnamemodify(path_of_main_file, ":p:h")
				end,

				-- Enable automatic refresh on save
				follow_cursor = true,
			})

			-- Keymaps for Typst files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "typst",
				callback = function()
					local opts = { buffer = true, silent = true }

					-- Browser preview commands (using capital T for Typst)
					vim.keymap.set(
						"n",
						"<leader>Tp",
						"<cmd>TypstPreview<cr>",
						vim.tbl_extend("error", opts, { desc = "Typst Preview (browser)" })
					)
					vim.keymap.set(
						"n",
						"<leader>Tt",
						"<cmd>TypstPreviewToggle<cr>",
						vim.tbl_extend("error", opts, { desc = "Toggle Typst Preview" })
					)
					vim.keymap.set(
						"n",
						"<leader>Ts",
						"<cmd>TypstPreviewStop<cr>",
						vim.tbl_extend("error", opts, { desc = "Stop Typst Preview" })
					)

					-- Zathura PDF preview
					vim.keymap.set("n", "<leader>Tz", function()
						-- Compile and open in Zathura
						local file = vim.fn.expand("%:p")
						local pdf = vim.fn.expand("%:r") .. ".pdf"

						-- First compile the file
						vim.fn.system({ "typst", "compile", file })

						-- Then open in Zathura with SyncTeX support
						vim.fn.jobstart({
							"zathura",
							"--synctex-editor-command",
							"nvim --server /tmp/nvimsocket +%{line} %{input}",
							pdf,
						})
						vim.notify("Opened in Zathura", vim.log.levels.INFO)
					end, vim.tbl_extend("error", opts, { desc = "Typst Preview in Zathura" }))

					-- Forward search: Jump from Neovim to PDF location in Zathura
					vim.keymap.set("n", "<leader>Tj", function()
						-- Get current position
						local line = vim.fn.line(".")
						local col = vim.fn.col(".")
						local file = vim.fn.expand("%:p")
						local pdf = vim.fn.expand("%:r") .. ".pdf"

						-- Use synctex to jump to position in PDF
						vim.fn.system({
							"zathura",
							"--synctex-forward",
							string.format("%d:%d:%s", line, col, file),
							pdf,
						})
					end, vim.tbl_extend("error", opts, { desc = "Jump to PDF in Zathura (forward search)" }))

					-- Compile current file to PDF
					vim.keymap.set("n", "<leader>Tc", function()
						local file = vim.fn.expand("%:p")
						vim.cmd("!typst compile " .. file)
						vim.notify("Compiled to PDF", vim.log.levels.INFO)
					end, vim.tbl_extend("error", opts, { desc = "Compile Typst to PDF" }))

					-- Watch and auto-compile
					vim.keymap.set("n", "<leader>Tw", function()
						local file = vim.fn.expand("%:p")
						vim.fn.jobstart({ "typst", "watch", file }, {
							on_stdout = function(_, data)
								if data then
									vim.notify("Typst: " .. table.concat(data, "\n"), vim.log.levels.INFO)
								end
							end,
							on_stderr = function(_, data)
								if data then
									vim.notify("Typst Error: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
								end
							end,
						})
						vim.notify("Typst watch mode started", vim.log.levels.INFO)
					end, vim.tbl_extend("error", opts, { desc = "Typst watch mode (auto-compile)" }))
				end,
			})
		end,
	},
}
