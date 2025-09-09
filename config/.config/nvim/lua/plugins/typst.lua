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

			-- Custom function to clean up extra spaces in Typst content
			local function clean_typst_spaces()
				local bufnr = vim.api.nvim_get_current_buf()
				local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
				local modified = false
				local in_code_block = false
				local in_math_block = false
				
				for i, line in ipairs(lines) do
					-- Check for code block boundaries
					if line:match("^```") then
						in_code_block = not in_code_block
					elseif line:match("^%$") and not line:match("^%$.*%$$") then
						-- Start of multi-line math block
						in_math_block = not in_math_block
					end
					
					-- Determine if current line should be processed
					local should_process = true
					
					if in_code_block or in_math_block then
						should_process = false
					elseif line:match("^%s*#set%s") or      -- #set rules
					       line:match("^%s*#let%s") or      -- #let functions
					       line:match("^%s*#import%s") or    -- #import statements
					       line:match("^%s*#include%s") or   -- #include statements
					       line:match("^%s*//") then         -- Comments
						should_process = false
					end
					
					-- Process the line if it's content (not code)
					if should_process and line ~= "" then
						-- Replace multiple consecutive spaces with single space
						-- Use a simpler pattern that works globally
						local new_line = line:gsub("%s%s+", " ")
						-- Also clean up trailing spaces
						new_line = new_line:gsub("%s+$", "")
						-- Clean up leading spaces (optional, you may want to keep indentation)
						-- new_line = new_line:gsub("^%s+", "")
						
						if new_line ~= line then
							lines[i] = new_line
							modified = true
						end
					end
				end
				
				if modified then
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
					vim.notify("Cleaned up extra spaces in content", vim.log.levels.INFO)
				else
					vim.notify("No extra spaces found in content", vim.log.levels.INFO)
				end
			end

			-- Keymaps for Typst files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "typst",
				callback = function()
					local opts = { buffer = true, silent = true }

					-- Clean up spaces in content (custom formatter for text)
					vim.keymap.set("n", "<leader>cs", clean_typst_spaces, 
						vim.tbl_extend("error", opts, { desc = "Clean spaces in Typst content" }))
					
					-- Format all: First LSP format for code, then clean spaces in content
					vim.keymap.set("n", "<leader>cF", function()
						-- First format code with LSP
						vim.lsp.buf.format({ async = false })
						-- Then clean up content spaces
						vim.defer_fn(clean_typst_spaces, 100)
					end, vim.tbl_extend("error", opts, { desc = "Format Typst completely (code + content)" }))

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