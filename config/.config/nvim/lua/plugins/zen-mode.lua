-- BONSAI zen-mode configuration
-- Distraction-free writing mode for focused work

return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
        { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Toggle zen mode" },
    },
    opts = {
        window = {
            backdrop = 0.95, -- Shade of the backdrop (lower is darker)
            width = 80, -- Width of the zen window (60-80 characters as requested)
            height = 1, -- Height of the zen window (1 = full height)
            options = {
                -- Settings that apply when entering zen mode
                signcolumn = "no", -- Disable signcolumn
                number = false, -- Disable number column
                relativenumber = false, -- Disable relative numbers
                cursorline = false, -- Disable cursor line
                cursorcolumn = false, -- Disable cursor column
                foldcolumn = "0", -- Disable fold column
                list = false, -- Disable whitespace characters
            },
        },
        plugins = {
            -- Disable various UI elements
            options = {
                enabled = true,
                ruler = false, -- Disable the ruler text in the cmd line area
                showcmd = false, -- Disable the command in the last line
                laststatus = 0, -- Turn off the statusline
            },
            twilight = { enabled = true }, -- Enable twilight for dimming
            gitsigns = { enabled = false }, -- Disable gitsigns
            tmux = { enabled = true }, -- Allow disabling tmux statusline
            kitty = {
                enabled = false, -- Kitty font size changes disabled by default
                font = "+2", -- Font size increment
            },
            alacritty = {
                enabled = false, -- Alacritty font size changes disabled by default
                font = "12", -- Font size
            },
        },
        -- Callback functions
        on_open = function(win)
            -- Things to do when zen mode opens
            -- Can be used to save current settings, set up special mappings, etc.

            -- Auto-enable for markdown/text files if configured
            local ft = vim.bo.filetype
            if ft == "markdown" or ft == "text" then
                -- Set additional markdown-specific options
                vim.wo[win].wrap = true
                vim.wo[win].linebreak = true
            end
        end,
        -- on_close callback not needed for current implementation
    },
    config = function(_, opts)
        require("zen-mode").setup(opts)

        -- Set up Twilight colors to match BONSAI theme
        vim.api.nvim_set_hl(0, "TwilightDimmed", { fg = "#8b92a5" }) -- BONSAI text_muted
        vim.api.nvim_set_hl(0, "TwilightActive", { fg = "#e6e8eb" }) -- BONSAI text_primary

        -- Optional: Create auto-command for markdown/text files
        -- Uncomment the following to auto-enable zen mode for specific file types
        --[[
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "markdown", "text" },
            callback = function()
                -- Only auto-enable if the file is not empty and we're not in diff mode
                if vim.fn.line("$") > 1 and not vim.wo.diff then
                    vim.defer_fn(function()
                        vim.cmd("ZenMode")
                    end, 100)
                end
            end,
            group = vim.api.nvim_create_augroup("BonsaiZenMode", { clear = true }),
        })
        --]]
    end,
    dependencies = {
        -- Twilight dims inactive portions of the code
        {
            "folke/twilight.nvim",
            opts = {
                dimming = {
                    alpha = 0.25, -- Amount of dimming
                    color = { "Normal", "#8b92a5" }, -- Use BONSAI muted color
                    term_bg = "#0a0e14", -- BONSAI background deep
                    inactive = false, -- Don't dim inactive windows
                },
                treesitter = true, -- Use treesitter for accurate code regions
                context = 10, -- Amount of lines to show around cursor
                expand = { -- Additional filetypes to expand
                    "function",
                    "method",
                    "table",
                    "if_statement",
                },
                exclude = {}, -- Exclude these filetypes
            },
        },
    },
}