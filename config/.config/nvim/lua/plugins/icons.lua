-- BONSAI icon configuration (optional but recommended)
-- Provides file type icons for better visual feedback

return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  opts = {
    -- Override specific icons to match BONSAI aesthetic
    override = {
      lua = {
        icon = "󰢱",
        color = "#7c9885",  -- BONSAI green
        name = "Lua"
      },
      py = {
        icon = "󰌠",
        color = "#c7a882",  -- BONSAI yellow
        name = "Python"
      },
      js = {
        icon = "󰌞",
        color = "#c7a882",  -- BONSAI yellow
        name = "JavaScript"
      },
      ts = {
        icon = "󰛦",
        color = "#82a4c7",  -- BONSAI blue
        name = "TypeScript"
      },
      jsx = {
        icon = "󰜈",
        color = "#82a4c7",  -- BONSAI blue
        name = "JSX"
      },
      tsx = {
        icon = "󰜈",
        color = "#82a4c7",  -- BONSAI blue
        name = "TSX"
      },
      html = {
        icon = "󰌝",
        color = "#c78289",  -- BONSAI red
        name = "HTML"
      },
      css = {
        icon = "󰌜",
        color = "#82a4c7",  -- BONSAI blue
        name = "CSS"
      },
      md = {
        icon = "󰍔",
        color = "#e6e8eb",  -- BONSAI text primary
        name = "Markdown"
      },
    },
    -- Use default icons for other file types
    default = true,
  }
}