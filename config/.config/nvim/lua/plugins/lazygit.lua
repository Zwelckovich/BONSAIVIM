-- BONSAI lazygit.nvim configuration
-- Visual git operations with dedicated plugin integration

return {
	"kdheepak/lazygit.nvim",
	cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		{ "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit current file" },
		{ "<leader>gF", "<cmd>LazyGitFilter<cr>", desc = "LazyGit filter (project)" },
	},
	config = function()
		-- Configure floating window to match BONSAI style (90% size)
		vim.g.lazygit_floating_window_winblend = 0 -- No transparency
		vim.g.lazygit_floating_window_scaling_factor = 0.9 -- 90% of screen
		vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- Rounded borders
		vim.g.lazygit_floating_window_use_plenary = 0 -- Use neovim native window
		vim.g.lazygit_use_neovim_remote = 1 -- Better nvim integration

		-- Set up custom config path if BONSAI lazygit config exists
		local config_path = vim.fn.stdpath("config") .. "/lazygit.yml"
		if vim.fn.filereadable(config_path) == 1 then
			vim.g.lazygit_use_custom_config_file_path = 1
			vim.g.lazygit_config_file_path = config_path
		end

		-- Auto-refresh gitsigns after lazygit operations
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("lazygit_gitsigns_refresh", { clear = true }),
			pattern = "*",
			callback = function()
				-- Check if we're returning from lazygit
				if vim.g.lazygit_opened and vim.g.lazygit_opened == 1 then
					vim.g.lazygit_opened = 0
					-- Refresh gitsigns
					if package.loaded["gitsigns"] then
						require("gitsigns").refresh()
					end
				end
			end,
		})

		-- Mark when lazygit is opened
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyGitOpen",
			callback = function()
				vim.g.lazygit_opened = 1
			end,
		})

		-- Apply BONSAI colors to lazygit float window
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "lazygit",
			callback = function()
				vim.opt_local.winhl = "Normal:NormalFloat,FloatBorder:FloatBorder"
			end,
		})
	end,
}
