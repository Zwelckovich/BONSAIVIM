-- BONSAI markdown-preview.nvim configuration
-- Live preview with BONSAI dark theme styling

return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = function()
		-- Use the plugin's install function
		vim.fn["mkdp#util#install"]()
		-- Clean up yarn.lock to prevent lazy.nvim sync issues
		local plugin_path = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim"
		vim.fn.delete(plugin_path .. "/app/yarn.lock")
	end,
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
	config = function()
		-- Configure markdown preview options
		vim.g.mkdp_auto_start = 0 -- Don't auto-start (use <leader>mp to toggle)
		vim.g.mkdp_auto_close = 1 -- Auto-close preview when leaving markdown buffer
		vim.g.mkdp_refresh_slow = 0 -- Real-time refresh
		vim.g.mkdp_command_for_global = 0 -- Only available for markdown files
		vim.g.mkdp_open_to_the_world = 0 -- Only accessible from localhost
		vim.g.mkdp_open_ip = ""
		vim.g.mkdp_browser = "" -- Use system default browser
		vim.g.mkdp_echo_preview_url = 0 -- Don't echo preview URL
		vim.g.mkdp_browserfunc = ""

		-- Preview options
		vim.g.mkdp_preview_options = {
			mkit = {}, -- markdown-it options
			katex = {}, -- KaTeX options
			uml = {}, -- plantuml options
			maid = {}, -- mermaid options
			disable_sync_scroll = 0, -- Enable synchronized scrolling
			sync_scroll_type = "middle", -- Sync scroll to middle
			hide_yaml_meta = 1, -- Hide YAML frontmatter
			sequence_diagrams = {}, -- js-sequence-diagrams options
			flowchart_diagrams = {}, -- flowchart.js options
			content_editable = false, -- Make preview non-editable
			disable_filename = 0, -- Show filename in preview
			toc = {}, -- Table of contents options
		}

		-- Use custom preview page with BONSAI theme
		vim.g.mkdp_markdown_css = "" -- We'll use custom theme below
		vim.g.mkdp_highlight_css = "" -- We'll use custom highlight below
		vim.g.mkdp_port = "" -- Use random available port
		vim.g.mkdp_page_title = "「${name}」" -- Page title format
		vim.g.mkdp_images_path = "" -- Default images path
		vim.g.mkdp_filetypes = { "markdown" } -- Only for markdown files
		vim.g.mkdp_theme = "dark" -- Use dark theme

		-- BONSAI custom CSS theme
		vim.g.mkdp_theme_css = [[
			/* BONSAI Dark Theme for Markdown Preview */
			:root {
				/* BONSAI Background Colors */
				--bonsai-bg-deep: #0a0e14;
				--bonsai-bg-primary: #151922;
				--bonsai-bg-secondary: #1e242e;
				--bonsai-bg-elevated: #232933;
				--bonsai-bg-overlay: #2a3040;

				/* BONSAI Text Colors */
				--bonsai-text-primary: #e6e8eb;
				--bonsai-text-secondary: #b8bcc8;
				--bonsai-text-muted: #8b92a5;
				--bonsai-text-disabled: #6b7280;

				/* BONSAI Border Colors */
				--bonsai-border-subtle: #2d3441;
				--bonsai-border-primary: #3d4455;
				--bonsai-border-accent: #4a5568;

				/* BONSAI Accent Colors */
				--bonsai-green-primary: #7c9885;
				--bonsai-red-primary: #c78289;
				--bonsai-blue-primary: #82a4c7;
				--bonsai-yellow-primary: #c7a882;
				--bonsai-purple-primary: #9882c7;
			}

			body {
				background-color: var(--bonsai-bg-deep);
				color: var(--bonsai-text-primary);
				font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;
				line-height: 1.6;
				max-width: 900px;
				margin: 0 auto;
				padding: 2rem;
			}

			/* Headings */
			h1, h2, h3, h4, h5, h6 {
				color: var(--bonsai-green-primary);
				margin-top: 1.5em;
				margin-bottom: 0.5em;
				font-weight: 600;
			}

			h1 { border-bottom: 2px solid var(--bonsai-border-subtle); padding-bottom: 0.3em; }
			h2 { border-bottom: 1px solid var(--bonsai-border-subtle); padding-bottom: 0.2em; }

			/* Links */
			a {
				color: var(--bonsai-blue-primary);
				text-decoration: none;
			}

			a:hover {
				text-decoration: underline;
			}

			/* Code blocks */
			pre {
				background-color: var(--bonsai-bg-primary);
				border: 1px solid var(--bonsai-border-subtle);
				border-radius: 6px;
				padding: 1em;
				overflow-x: auto;
			}

			code {
				background-color: var(--bonsai-bg-secondary);
				padding: 0.2em 0.4em;
				border-radius: 3px;
				font-family: 'JetBrains Mono', 'Fira Code', Consolas, Monaco, monospace;
				font-size: 0.9em;
			}

			pre code {
				background-color: transparent;
				padding: 0;
			}

			/* Blockquotes */
			blockquote {
				border-left: 4px solid var(--bonsai-green-primary);
				padding-left: 1em;
				margin-left: 0;
				color: var(--bonsai-text-secondary);
			}

			/* Tables */
			table {
				border-collapse: collapse;
				width: 100%;
				margin: 1em 0;
			}

			th, td {
				border: 1px solid var(--bonsai-border-primary);
				padding: 0.5em 1em;
			}

			th {
				background-color: var(--bonsai-bg-secondary);
				color: var(--bonsai-green-primary);
			}

			tr:nth-child(even) {
				background-color: var(--bonsai-bg-primary);
			}

			/* Lists */
			ul, ol {
				padding-left: 2em;
			}

			li {
				margin: 0.25em 0;
			}

			/* Horizontal rule */
			hr {
				border: 0;
				border-top: 1px solid var(--bonsai-border-subtle);
				margin: 2em 0;
			}

			/* Images */
			img {
				max-width: 100%;
				height: auto;
				display: block;
				margin: 1em auto;
			}

			/* Mermaid diagrams */
			.mermaid {
				background-color: var(--bonsai-bg-primary);
				border: 1px solid var(--bonsai-border-subtle);
				border-radius: 6px;
				padding: 1em;
				text-align: center;
			}

			/* KaTeX math */
			.katex-display {
				margin: 1em 0;
				overflow-x: auto;
			}

			/* Task lists */
			.task-list-item {
				list-style-type: none;
			}

			.task-list-item input[type="checkbox"] {
				margin-right: 0.5em;
			}

			/* Syntax highlighting (for highlight.js) */
			.hljs {
				background-color: var(--bonsai-bg-primary);
				color: var(--bonsai-text-primary);
			}

			.hljs-keyword { color: var(--bonsai-purple-primary); }
			.hljs-string { color: var(--bonsai-green-primary); }
			.hljs-number { color: var(--bonsai-yellow-primary); }
			.hljs-function { color: var(--bonsai-blue-primary); }
			.hljs-comment { color: var(--bonsai-text-muted); }
		]]

		-- Define keymapping
		vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle markdown preview" })
		
		-- Add cleanup command for yarn.lock issue
		vim.api.nvim_create_user_command("MarkdownPreviewCleanup", function()
			local plugin_path = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim"
			local yarn_lock = plugin_path .. "/app/yarn.lock"
			if vim.fn.filereadable(yarn_lock) == 1 then
				vim.fn.delete(yarn_lock)
				print("Cleaned up yarn.lock from markdown-preview.nvim")
			else
				print("No yarn.lock found to clean up")
			end
		end, { desc = "Clean up yarn.lock from markdown-preview plugin" })
	end,
}
