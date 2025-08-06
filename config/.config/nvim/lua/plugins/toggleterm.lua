-- BONSAI toggleterm.nvim configuration
-- Integrated terminal support with multiple terminals and custom styling

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		-- Toggle mappings
		{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = { "n", "i", "v", "t" } },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal float" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal horizontal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal vertical" },

		-- Terminal navigation
		{ "<C-h>", [[<Cmd>wincmd h<CR>]], mode = "t", desc = "Navigate left from terminal" },
		{ "<C-j>", [[<Cmd>wincmd j<CR>]], mode = "t", desc = "Navigate down from terminal" },
		{ "<C-k>", [[<Cmd>wincmd k<CR>]], mode = "t", desc = "Navigate up from terminal" },
		{ "<C-l>", [[<Cmd>wincmd l<CR>]], mode = "t", desc = "Navigate right from terminal" },
	},
	opts = {
		-- Size configuration
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,

		-- Terminal appearance
		open_mapping = [[<C-\>]],
		hide_numbers = true,
		shade_terminals = false, -- Use BONSAI colors as-is
		start_in_insert = true,
		insert_mappings = true,
		terminal_mappings = true,
		persist_size = true,
		persist_mode = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		auto_scroll = true,

		-- Float terminal configuration (matching yazi style)
		float_opts = {
			border = "rounded",
			width = function()
				return math.floor(vim.o.columns * 0.9)
			end,
			height = function()
				return math.floor(vim.o.lines * 0.9)
			end,
			winblend = 0,
			title_pos = "center",
		},

		-- BONSAI color integration
		highlights = {
			Normal = {
				guibg = "#0a0e14", -- BONSAI background deep
			},
			NormalFloat = {
				guibg = "#151922", -- BONSAI background primary
			},
			FloatBorder = {
				guifg = "#2d3441", -- BONSAI border subtle
				guibg = "#151922", -- BONSAI background primary
			},
		},

		-- Window options
		winbar = {
			enabled = false,
		},
	},
	config = function(_, opts)
		-- Windows PowerShell configuration
		if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
			-- Check for PowerShell Core first, then fall back to Windows PowerShell
			local shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"

			-- Set shell options for PowerShell
			vim.opt.shell = shell
			vim.opt.shellcmdflag =
				"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
			vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
			vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
			vim.opt.shellquote = ""
			vim.opt.shellxquote = ""

			-- Override opts.shell for toggleterm to use PowerShell
			opts.shell = shell
		end

		require("toggleterm").setup(opts)

		-- Custom terminal functions for common tasks
		local Terminal = require("toggleterm.terminal").Terminal

		-- Note: Lazygit functionality moved to dedicated lazygit.nvim plugin
		-- See lua/plugins/lazygit.lua for git UI integration

		-- Python REPL terminal
		local python = Terminal:new({
			cmd = "python3",
			direction = "horizontal",
			on_open = function(term)
				vim.cmd("startinsert!")
			end,
		})

		-- Node REPL terminal
		local node = Terminal:new({
			cmd = "node",
			direction = "horizontal",
			on_open = function(term)
				vim.cmd("startinsert!")
			end,
		})

		-- Create commands for custom terminals

		vim.api.nvim_create_user_command("PythonRepl", function()
			python:toggle()
		end, {})

		vim.api.nvim_create_user_command("NodeRepl", function()
			node:toggle()
		end, {})

		-- Add keymaps for custom terminals
		vim.keymap.set("n", "<leader>tp", "<cmd>PythonRepl<cr>", { desc = "Terminal Python REPL" })
		vim.keymap.set("n", "<leader>tn", "<cmd>NodeRepl<cr>", { desc = "Terminal Node REPL" })

		-- Function to run current file in terminal
		vim.api.nvim_create_user_command("RunFile", function()
			local ft = vim.bo.filetype
			local file = vim.fn.expand("%:p")
			local cmd = ""

			if ft == "python" then
				cmd = "python3 " .. file
			elseif ft == "javascript" then
				cmd = "node " .. file
			elseif ft == "lua" then
				cmd = "lua " .. file
			elseif ft == "rust" then
				cmd = "cargo run"
			elseif ft == "go" then
				cmd = "go run " .. file
			else
				vim.notify("No run command configured for filetype: " .. ft, vim.log.levels.WARN)
				return
			end

			require("toggleterm").exec(cmd, 1, 12)
		end, {})

		vim.keymap.set("n", "<leader>tr", "<cmd>RunFile<cr>", { desc = "Terminal run current file" })
	end,
}
