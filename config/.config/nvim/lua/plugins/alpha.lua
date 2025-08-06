-- BONSAI Startup Screen with alpha-nvim
return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- BONSAI ASCII art (minimal, clean)
		local header = {
			[[██████╗  ██████╗ ███╗   ██╗███████╗ █████╗ ██╗]],
			[[██╔══██╗██╔═══██╗████╗  ██║██╔════╝██╔══██╗██║]],
			[[██████╔╝██║   ██║██╔██╗ ██║███████╗███████║██║]],
			[[██╔══██╗██║   ██║██║╚██╗██║╚════██║██╔══██║██║]],
			[[██████╔╝╚██████╔╝██║ ╚████║███████║██║  ██║██║]],
			[[╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝]],
		}

		-- Zen quotes to rotate
		local quotes = {
			"Grow purposefully, prune regularly",
			"Simplicity is the ultimate sophistication",
			"Less code, more clarity",
			"Start minimal, evolve mindfully",
			"The way of BONSAI: patient cultivation",
		}

		-- Select random quote
		math.randomseed(os.time())
		local quote = quotes[math.random(#quotes)]

		-- Get startup time
		local stats = require("lazy").stats()
		local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

		-- Build header with quote and stats
		local full_header = vim.list_extend({}, header)
		vim.list_extend(
			full_header,
			{ "", "", quote, "", "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins | " .. ms .. "ms", "" }
		)

		dashboard.section.header.val = full_header
		dashboard.section.header.opts.hl = "AlphaHeader"

		-- Set up buttons with single-key shortcuts
		dashboard.section.buttons.val = {
			dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "  Find files", ":Telescope find_files <CR>"),
			dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
			dashboard.button("c", "  Config", ":e $MYVIMRC | :cd %:p:h <CR>"),
			dashboard.button("s", "  Restore session", function()
				require("persistence").load()
			end),
			dashboard.button("l", "  Lazy", ":Lazy <CR>"),
			dashboard.button("m", "  Mason", ":Mason <CR>"),
			dashboard.button("q", "  Quit", ":qa <CR>"),
		}

		-- Configure button highlights
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end

		-- Get recent files (last 5)
		local function get_recent_files()
			local oldfiles = {}
			for _, v in pairs(vim.v.oldfiles) do
				if #oldfiles >= 5 then
					break
				end
				local cwd = vim.fn.getcwd()
				-- Only show files from current directory
				if vim.startswith(v, cwd) then
					local file = string.sub(v, #cwd + 2)
					local icon = require("nvim-web-devicons").get_icon(file) or ""
					table.insert(oldfiles, icon .. "  " .. file)
				end
			end
			return oldfiles
		end

		-- Recent files section
		local recent_files_section = {
			type = "group",
			val = function()
				local files = get_recent_files()
				local elements = {
					{
						type = "text",
						val = "Recent files",
						opts = {
							hl = "AlphaHeaderLabel",
							position = "center",
						},
					},
					{ type = "padding", val = 1 },
				}

				if #files == 0 then
					table.insert(elements, {
						type = "text",
						val = "No recent files in this directory",
						opts = {
							hl = "AlphaEmpty",
							position = "center",
						},
					})
				else
					for i, file in ipairs(files) do
						local filename = file:match("^%S+%s+(.+)$")
						table.insert(elements, {
							type = "button",
							val = file,
							on_press = function()
								vim.cmd("edit " .. filename)
							end,
							opts = {
								position = "center",
								shortcut = tostring(i),
								cursor = 3,
								width = 50,
								align_shortcut = "right",
								hl = "AlphaFile",
								hl_shortcut = "AlphaFileShortcut",
								keymap = {
									"n",
									tostring(i),
									"<cmd>e " .. filename .. "<CR>",
									{ noremap = true, silent = true, nowait = true },
								},
							},
						})
					end
				end

				return elements
			end,
		}

		-- Footer with Neovim version
		dashboard.section.footer.val = {
			"",
			"BONSAI Neovim v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
		}
		dashboard.section.footer.opts.hl = "AlphaFooter"

		-- Layout configuration
		local layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 2 },
			recent_files_section,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		dashboard.opts.layout = layout

		-- Setup alpha with dashboard config
		alpha.setup(dashboard.opts)

		-- Define BONSAI colors for alpha elements
		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7c9885", bold = true })
		vim.api.nvim_set_hl(0, "AlphaHeaderLabel", { fg = "#e6e8eb", bold = true })
		vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#b8bcc8" })
		vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#7c9885", bold = true })
		vim.api.nvim_set_hl(0, "AlphaFile", { fg = "#8b92a5" })
		vim.api.nvim_set_hl(0, "AlphaFileShortcut", { fg = "#82a4c7", bold = true })
		vim.api.nvim_set_hl(0, "AlphaEmpty", { fg = "#6b7280", italic = true })
		vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#8b92a5", italic = true })

		-- Disable folding on alpha buffer
		vim.cmd([[
			autocmd FileType alpha setlocal nofoldenable
		]])
	end,
}
