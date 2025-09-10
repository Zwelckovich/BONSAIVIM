-- BONSAI D2 diagram plugin configuration
-- Provides syntax highlighting and support for D2 diagram language

return {
	"terrastruct/d2-vim",
	ft = "d2",
	lazy = true,
	config = function()
		-- Set up D2-specific keymaps
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "d2",
			callback = function()
				local opts = { buffer = true, silent = true }

				-- Compile D2 diagram to SVG
				vim.keymap.set("n", "<leader>Dc", function()
					local file = vim.fn.expand("%:p")
					local output = vim.fn.expand("%:r") .. ".svg"
					vim.cmd("!d2 " .. file .. " " .. output)
					vim.notify("D2 diagram compiled to " .. output, vim.log.levels.INFO)
				end, vim.tbl_extend("error", opts, { desc = "Compile D2 to SVG" }))

				-- Watch and auto-compile D2 diagram
				vim.keymap.set("n", "<leader>Dw", function()
					local file = vim.fn.expand("%:p")
					local output = vim.fn.expand("%:r") .. ".svg"
					vim.fn.jobstart({ "d2", "--watch", file, output }, {
						on_stdout = function(_, data)
							if data then
								vim.notify("D2 Watch: " .. table.concat(data, "\n"), vim.log.levels.INFO)
							end
						end,
						on_stderr = function(_, data)
							if data then
								vim.notify("D2 Error: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
							end
						end,
					})
					vim.notify("D2 watch mode started for " .. output, vim.log.levels.INFO)
				end, vim.tbl_extend("error", opts, { desc = "D2 watch mode (auto-compile)" }))

				-- Open D2 output in browser
				vim.keymap.set("n", "<leader>Do", function()
					local output = vim.fn.expand("%:r") .. ".svg"
					if vim.fn.filereadable(output) == 1 then
						vim.fn.jobstart({ "xdg-open", output })
						vim.notify("Opening " .. output .. " in browser", vim.log.levels.INFO)
					else
						vim.notify("No output file found. Compile first with <leader>Dc", vim.log.levels.WARN)
					end
				end, vim.tbl_extend("error", opts, { desc = "Open D2 output in browser" }))

				-- Export D2 to PNG
				vim.keymap.set("n", "<leader>Dp", function()
					local file = vim.fn.expand("%:p")
					local output = vim.fn.expand("%:r") .. ".png"
					vim.cmd("!d2 " .. file .. " " .. output)
					vim.notify("D2 diagram exported to " .. output, vim.log.levels.INFO)
				end, vim.tbl_extend("error", opts, { desc = "Export D2 to PNG" }))

				-- Export D2 to PDF
				vim.keymap.set("n", "<leader>DP", function()
					local file = vim.fn.expand("%:p")
					local output = vim.fn.expand("%:r") .. ".pdf"
					vim.cmd("!d2 " .. file .. " " .. output)
					vim.notify("D2 diagram exported to " .. output, vim.log.levels.INFO)
				end, vim.tbl_extend("error", opts, { desc = "Export D2 to PDF" }))
			end,
		})
	end,
}
