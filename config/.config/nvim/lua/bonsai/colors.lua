-- BONSAI Color Palette
-- Complete color definitions for the BONSAI colorscheme

local M = {}

-- BONSAI Color Definitions
M.colors = {
  -- Background colors
  bg_deep = "#0a0e14",        -- Deepest background (main editor)
  bg_primary = "#151922",     -- Primary background (UI elements)
  bg_secondary = "#1e242e",   -- Secondary background (inactive elements)
  bg_elevated = "#232933",    -- Elevated surfaces (popups, menus)
  bg_overlay = "#2a3040",     -- Overlay backgrounds

  -- Text colors
  text_primary = "#e6e8eb",   -- Primary text (bright)
  text_secondary = "#b8bcc8", -- Secondary text
  text_muted = "#8b92a5",     -- Muted text (comments)
  text_disabled = "#6b7280",  -- Disabled text
  text_inverted = "#0a0e14",  -- Text on light backgrounds

  -- Border colors
  border_subtle = "#2d3441",  -- Subtle borders
  border_primary = "#3d4455", -- Primary borders
  border_accent = "#4a5568",  -- Accent borders
  border_strong = "#5a6578",  -- Strong emphasis borders

  -- Core accent colors
  green_primary = "#7c9885",    -- Nature, growth, success
  green_secondary = "#9db4a6",  -- Lighter green
  green_tertiary = "#a8c0b1",   -- Very light green
  green_muted = "#677a70",      -- Darker green

  red_primary = "#c78289",      -- Attention, errors
  red_secondary = "#d4999f",    -- Lighter red
  red_tertiary = "#dfa8ad",     -- Very light red
  red_muted = "#a56b71",        -- Darker red

  blue_primary = "#82a4c7",     -- Information, links, functions
  blue_secondary = "#9bb5d4",   -- Lighter blue
  blue_tertiary = "#adc2db",    -- Very light blue
  blue_muted = "#6b8aa5",       -- Darker blue

  yellow_primary = "#c7a882",   -- Warning, warmth
  yellow_secondary = "#d4b99b", -- Lighter yellow
  yellow_tertiary = "#dbc5ad",  -- Very light yellow
  yellow_muted = "#a5906b",     -- Darker yellow

  purple_primary = "#9882c7",   -- Creative elements, keywords
  purple_secondary = "#ab9bd4", -- Lighter purple
  purple_tertiary = "#bcb0db",  -- Very light purple
  purple_muted = "#7f6ba5",     -- Darker purple

  orange_primary = "#c7975c",   -- Notifications, energy
  orange_secondary = "#d4a975", -- Lighter orange
  orange_tertiary = "#dbb88d",  -- Very light orange
  orange_muted = "#a57f4d",     -- Darker orange

  teal_primary = "#5cc7a8",     -- Fresh, modern accents
  teal_secondary = "#75d4b9",   -- Lighter teal
  teal_tertiary = "#8ddbc5",    -- Very light teal
  teal_muted = "#4da58d",       -- Darker teal
}

-- Function to set highlight groups
function M.setup()
  local colors = M.colors
  local hl = vim.api.nvim_set_hl

  -- Editor UI
  hl(0, "Normal", { fg = colors.text_primary, bg = colors.bg_deep })
  hl(0, "NormalFloat", { fg = colors.text_primary, bg = colors.bg_primary })
  hl(0, "FloatBorder", { fg = colors.border_subtle, bg = colors.bg_primary })
  hl(0, "Cursor", { bg = colors.text_primary })
  hl(0, "CursorLine", { bg = colors.bg_primary })
  hl(0, "CursorLineNr", { fg = colors.green_primary, bg = colors.bg_primary, bold = true })
  hl(0, "LineNr", { fg = colors.text_muted })
  hl(0, "SignColumn", { fg = colors.text_muted, bg = colors.bg_deep })
  hl(0, "StatusLine", { fg = colors.text_secondary, bg = colors.bg_secondary })
  hl(0, "StatusLineNC", { fg = colors.text_muted, bg = colors.bg_primary })
  hl(0, "VertSplit", { fg = colors.border_subtle })
  hl(0, "WinSeparator", { fg = colors.border_subtle })
  hl(0, "Pmenu", { fg = colors.text_secondary, bg = colors.bg_elevated })
  hl(0, "PmenuSel", { fg = colors.text_primary, bg = colors.bg_overlay })
  hl(0, "PmenuSbar", { bg = colors.bg_secondary })
  hl(0, "PmenuThumb", { bg = colors.bg_overlay })
  hl(0, "TabLine", { fg = colors.text_muted, bg = colors.bg_secondary })
  hl(0, "TabLineSel", { fg = colors.text_primary, bg = colors.bg_elevated })
  hl(0, "TabLineFill", { bg = colors.bg_primary })

  -- Search and Selection
  hl(0, "Search", { fg = colors.bg_deep, bg = colors.yellow_primary })
  hl(0, "IncSearch", { fg = colors.bg_deep, bg = colors.orange_primary })
  hl(0, "Visual", { bg = colors.bg_elevated })
  hl(0, "VisualNOS", { bg = colors.bg_secondary })

  -- Syntax Highlighting - Following concept.md strategy
  hl(0, "Comment", { fg = colors.text_muted, italic = true })
  hl(0, "Constant", { fg = colors.orange_primary })
  hl(0, "String", { fg = colors.green_primary })
  hl(0, "Character", { fg = colors.green_primary })
  hl(0, "Number", { fg = colors.orange_primary })
  hl(0, "Boolean", { fg = colors.orange_primary })
  hl(0, "Float", { fg = colors.orange_primary })

  hl(0, "Identifier", { fg = colors.text_primary })
  hl(0, "Function", { fg = colors.blue_primary, bold = true }) -- Bold as per concept.md

  hl(0, "Statement", { fg = colors.purple_primary })
  hl(0, "Conditional", { fg = colors.purple_primary })
  hl(0, "Repeat", { fg = colors.purple_primary })
  hl(0, "Label", { fg = colors.purple_primary })
  hl(0, "Operator", { fg = colors.text_secondary })
  hl(0, "Keyword", { fg = colors.purple_primary })
  hl(0, "Exception", { fg = colors.red_primary })

  hl(0, "PreProc", { fg = colors.yellow_primary })
  hl(0, "Include", { fg = colors.purple_primary })
  hl(0, "Define", { fg = colors.purple_primary })
  hl(0, "Macro", { fg = colors.yellow_primary })
  hl(0, "PreCondit", { fg = colors.yellow_primary })

  hl(0, "Type", { fg = colors.teal_primary })
  hl(0, "StorageClass", { fg = colors.purple_primary })
  hl(0, "Structure", { fg = colors.teal_primary })
  hl(0, "Typedef", { fg = colors.teal_primary })

  hl(0, "Special", { fg = colors.blue_primary })
  hl(0, "SpecialChar", { fg = colors.orange_primary })
  hl(0, "Tag", { fg = colors.blue_primary })
  hl(0, "Delimiter", { fg = colors.text_primary }) -- Bright as per concept.md
  hl(0, "SpecialComment", { fg = colors.yellow_primary, italic = true })
  hl(0, "Debug", { fg = colors.red_primary })

  hl(0, "Underlined", { fg = colors.blue_primary, underline = true })
  hl(0, "Error", { fg = colors.red_primary }) -- Soft red as per concept.md
  hl(0, "Todo", { fg = colors.yellow_primary, bold = true })

  -- Diagnostics
  hl(0, "DiagnosticError", { fg = colors.red_primary })
  hl(0, "DiagnosticWarn", { fg = colors.yellow_primary })
  hl(0, "DiagnosticInfo", { fg = colors.blue_primary })
  hl(0, "DiagnosticHint", { fg = colors.green_primary })
  hl(0, "DiagnosticVirtualTextError", { fg = colors.red_muted })
  hl(0, "DiagnosticVirtualTextWarn", { fg = colors.yellow_muted })
  hl(0, "DiagnosticVirtualTextInfo", { fg = colors.blue_muted })
  hl(0, "DiagnosticVirtualTextHint", { fg = colors.green_muted })
  hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = colors.red_primary })
  hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = colors.yellow_primary })
  hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = colors.blue_primary })
  hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = colors.green_primary })

  -- Treesitter
  hl(0, "@variable", { fg = colors.text_primary })
  hl(0, "@variable.builtin", { fg = colors.orange_primary })
  hl(0, "@variable.parameter", { fg = colors.text_secondary })
  hl(0, "@variable.member", { fg = colors.text_primary })
  hl(0, "@constant", { fg = colors.orange_primary })
  hl(0, "@constant.builtin", { fg = colors.orange_primary })
  hl(0, "@constant.macro", { fg = colors.yellow_primary })
  hl(0, "@module", { fg = colors.text_primary })
  hl(0, "@module.builtin", { fg = colors.purple_primary })
  hl(0, "@label", { fg = colors.purple_primary })

  hl(0, "@string", { fg = colors.green_primary })
  hl(0, "@string.documentation", { fg = colors.green_secondary })
  hl(0, "@string.regex", { fg = colors.orange_primary })
  hl(0, "@string.escape", { fg = colors.orange_primary })
  hl(0, "@string.special", { fg = colors.orange_primary })
  hl(0, "@string.special.symbol", { fg = colors.text_primary })
  hl(0, "@string.special.path", { fg = colors.blue_primary })
  hl(0, "@string.special.url", { fg = colors.blue_primary, underline = true })
  hl(0, "@character", { fg = colors.green_primary })
  hl(0, "@character.special", { fg = colors.orange_primary })

  hl(0, "@boolean", { fg = colors.orange_primary })
  hl(0, "@number", { fg = colors.orange_primary })
  hl(0, "@number.float", { fg = colors.orange_primary })

  hl(0, "@type", { fg = colors.teal_primary })
  hl(0, "@type.builtin", { fg = colors.teal_primary })
  hl(0, "@type.definition", { fg = colors.teal_primary })
  hl(0, "@type.qualifier", { fg = colors.purple_primary })
  hl(0, "@attribute", { fg = colors.yellow_primary })
  hl(0, "@attribute.builtin", { fg = colors.yellow_primary })
  hl(0, "@property", { fg = colors.text_primary })

  hl(0, "@function", { fg = colors.blue_primary, bold = true })
  hl(0, "@function.builtin", { fg = colors.blue_primary, bold = true })
  hl(0, "@function.call", { fg = colors.blue_primary })
  hl(0, "@function.macro", { fg = colors.yellow_primary })
  hl(0, "@function.method", { fg = colors.blue_primary })
  hl(0, "@function.method.call", { fg = colors.blue_primary })
  hl(0, "@constructor", { fg = colors.teal_primary })
  hl(0, "@operator", { fg = colors.text_secondary })

  hl(0, "@keyword", { fg = colors.purple_primary })
  hl(0, "@keyword.coroutine", { fg = colors.purple_primary })
  hl(0, "@keyword.function", { fg = colors.purple_primary })
  hl(0, "@keyword.operator", { fg = colors.purple_primary })
  hl(0, "@keyword.import", { fg = colors.purple_primary })
  hl(0, "@keyword.storage", { fg = colors.purple_primary })
  hl(0, "@keyword.repeat", { fg = colors.purple_primary })
  hl(0, "@keyword.return", { fg = colors.purple_primary })
  hl(0, "@keyword.debug", { fg = colors.red_primary })
  hl(0, "@keyword.exception", { fg = colors.red_primary })
  hl(0, "@keyword.conditional", { fg = colors.purple_primary })
  hl(0, "@keyword.conditional.ternary", { fg = colors.purple_primary })
  hl(0, "@keyword.directive", { fg = colors.yellow_primary })
  hl(0, "@keyword.directive.define", { fg = colors.yellow_primary })

  hl(0, "@punctuation.delimiter", { fg = colors.text_primary }) -- Bright as per concept.md
  hl(0, "@punctuation.bracket", { fg = colors.text_primary }) -- Bright as per concept.md
  hl(0, "@punctuation.special", { fg = colors.text_primary })

  hl(0, "@comment", { fg = colors.text_muted, italic = true })
  hl(0, "@comment.documentation", { fg = colors.text_muted, italic = true })
  hl(0, "@comment.error", { fg = colors.red_primary })
  hl(0, "@comment.warning", { fg = colors.yellow_primary })
  hl(0, "@comment.todo", { fg = colors.yellow_primary, bold = true })
  hl(0, "@comment.note", { fg = colors.blue_primary })

  hl(0, "@markup.strong", { bold = true })
  hl(0, "@markup.italic", { italic = true })
  hl(0, "@markup.strikethrough", { strikethrough = true })
  hl(0, "@markup.underline", { underline = true })
  hl(0, "@markup.heading", { fg = colors.blue_primary, bold = true })
  hl(0, "@markup.heading.1", { fg = colors.blue_primary, bold = true })
  hl(0, "@markup.heading.2", { fg = colors.blue_secondary, bold = true })
  hl(0, "@markup.heading.3", { fg = colors.blue_tertiary, bold = true })
  hl(0, "@markup.heading.4", { fg = colors.text_primary, bold = true })
  hl(0, "@markup.heading.5", { fg = colors.text_secondary, bold = true })
  hl(0, "@markup.heading.6", { fg = colors.text_muted, bold = true })
  hl(0, "@markup.quote", { fg = colors.text_muted, italic = true })
  hl(0, "@markup.math", { fg = colors.orange_primary })
  hl(0, "@markup.environment", { fg = colors.purple_primary })
  hl(0, "@markup.link", { fg = colors.blue_primary, underline = true })
  hl(0, "@markup.link.label", { fg = colors.blue_secondary })
  hl(0, "@markup.link.url", { fg = colors.blue_primary, underline = true })
  hl(0, "@markup.raw", { fg = colors.green_primary })
  hl(0, "@markup.raw.block", { fg = colors.green_primary })
  hl(0, "@markup.list", { fg = colors.text_primary })
  hl(0, "@markup.list.checked", { fg = colors.green_primary })
  hl(0, "@markup.list.unchecked", { fg = colors.text_muted })

  hl(0, "@diff.plus", { fg = colors.green_primary })
  hl(0, "@diff.minus", { fg = colors.red_primary })
  hl(0, "@diff.delta", { fg = colors.yellow_primary })

  hl(0, "@tag", { fg = colors.blue_primary })
  hl(0, "@tag.attribute", { fg = colors.teal_primary })
  hl(0, "@tag.delimiter", { fg = colors.text_primary })

  -- LSP
  hl(0, "LspReferenceText", { bg = colors.bg_secondary })
  hl(0, "LspReferenceRead", { bg = colors.bg_secondary })
  hl(0, "LspReferenceWrite", { bg = colors.bg_elevated })
  hl(0, "LspCodeLens", { fg = colors.text_muted })
  hl(0, "LspCodeLensSeparator", { fg = colors.text_muted })
  hl(0, "LspSignatureActiveParameter", { bg = colors.bg_elevated })

  -- Git
  hl(0, "GitSignsAdd", { fg = colors.green_primary })
  hl(0, "GitSignsChange", { fg = colors.yellow_primary })
  hl(0, "GitSignsDelete", { fg = colors.red_primary })
  hl(0, "GitSignsCurrentLineBlame", { fg = colors.text_muted })
  hl(0, "DiffAdd", { bg = colors.green_muted })
  hl(0, "DiffChange", { bg = colors.yellow_muted })
  hl(0, "DiffDelete", { bg = colors.red_muted })
  hl(0, "DiffText", { bg = colors.blue_muted })

  -- Telescope (already set in telescope.lua but included for completeness)
  hl(0, "TelescopeNormal", { fg = colors.text_secondary, bg = colors.bg_primary })
  hl(0, "TelescopeBorder", { fg = colors.border_subtle, bg = colors.bg_primary })
  hl(0, "TelescopePromptNormal", { bg = colors.bg_secondary })
  hl(0, "TelescopePromptBorder", { fg = colors.border_subtle, bg = colors.bg_secondary })
  hl(0, "TelescopePromptTitle", { fg = colors.green_primary })
  hl(0, "TelescopePreviewTitle", { fg = colors.blue_primary })
  hl(0, "TelescopeResultsTitle", { fg = colors.purple_primary })
  hl(0, "TelescopeSelection", { bg = colors.bg_elevated })
  hl(0, "TelescopeSelectionCaret", { fg = colors.green_primary })
  hl(0, "TelescopeMatching", { fg = colors.orange_primary })

  -- Which-key (already set in which-key.lua but included for completeness)
  hl(0, "WhichKey", { fg = colors.green_primary })
  hl(0, "WhichKeyGroup", { fg = colors.blue_primary })
  hl(0, "WhichKeyDesc", { fg = colors.text_secondary })
  hl(0, "WhichKeySeperator", { fg = colors.text_muted })
  hl(0, "WhichKeySeparator", { fg = colors.text_muted })
  hl(0, "WhichKeyFloat", { bg = colors.bg_primary })
  hl(0, "WhichKeyBorder", { fg = colors.border_subtle, bg = colors.bg_primary })
  hl(0, "WhichKeyValue", { fg = colors.yellow_primary })

  -- Flash
  hl(0, "FlashLabel", { fg = colors.bg_deep, bg = colors.orange_primary, bold = true })
  hl(0, "FlashMatch", { fg = colors.text_primary, bg = colors.bg_elevated })
  hl(0, "FlashCurrent", { fg = colors.text_primary, bg = colors.bg_overlay })

  -- nvim-cmp
  hl(0, "CmpItemAbbrDeprecated", { fg = colors.text_muted, strikethrough = true })
  hl(0, "CmpItemAbbrMatch", { fg = colors.blue_primary })
  hl(0, "CmpItemAbbrMatchFuzzy", { fg = colors.blue_secondary })
  hl(0, "CmpItemMenu", { fg = colors.text_muted })
  hl(0, "CmpItemKindText", { fg = colors.text_secondary })
  hl(0, "CmpItemKindMethod", { fg = colors.blue_primary })
  hl(0, "CmpItemKindFunction", { fg = colors.blue_primary })
  hl(0, "CmpItemKindConstructor", { fg = colors.teal_primary })
  hl(0, "CmpItemKindField", { fg = colors.text_primary })
  hl(0, "CmpItemKindVariable", { fg = colors.text_primary })
  hl(0, "CmpItemKindClass", { fg = colors.teal_primary })
  hl(0, "CmpItemKindInterface", { fg = colors.teal_primary })
  hl(0, "CmpItemKindModule", { fg = colors.purple_primary })
  hl(0, "CmpItemKindProperty", { fg = colors.text_primary })
  hl(0, "CmpItemKindUnit", { fg = colors.orange_primary })
  hl(0, "CmpItemKindValue", { fg = colors.orange_primary })
  hl(0, "CmpItemKindEnum", { fg = colors.teal_primary })
  hl(0, "CmpItemKindKeyword", { fg = colors.purple_primary })
  hl(0, "CmpItemKindSnippet", { fg = colors.green_primary })
  hl(0, "CmpItemKindColor", { fg = colors.yellow_primary })
  hl(0, "CmpItemKindFile", { fg = colors.blue_primary })
  hl(0, "CmpItemKindReference", { fg = colors.blue_secondary })
  hl(0, "CmpItemKindFolder", { fg = colors.blue_primary })
  hl(0, "CmpItemKindEnumMember", { fg = colors.teal_secondary })
  hl(0, "CmpItemKindConstant", { fg = colors.orange_primary })
  hl(0, "CmpItemKindStruct", { fg = colors.teal_primary })
  hl(0, "CmpItemKindEvent", { fg = colors.purple_primary })
  hl(0, "CmpItemKindOperator", { fg = colors.text_secondary })
  hl(0, "CmpItemKindTypeParameter", { fg = colors.teal_secondary })

  -- Undotree
  hl(0, "UndotreeBranch", { fg = colors.text_muted })
  hl(0, "UndotreeCurrent", { fg = colors.green_primary })
  hl(0, "UndotreeNext", { fg = colors.blue_primary })
  hl(0, "UndotreeNode", { fg = colors.text_primary })
  hl(0, "UndotreeNodeCurrent", { fg = colors.green_primary, bold = true })
  hl(0, "UndotreeSavedBig", { fg = colors.yellow_primary, bold = true })
  hl(0, "UndotreeSavedSmall", { fg = colors.yellow_secondary })
  hl(0, "UndotreeSeq", { fg = colors.text_muted })
  hl(0, "UndotreeTimeStamp", { fg = colors.purple_primary })

  -- Misc
  hl(0, "Directory", { fg = colors.blue_primary })
  hl(0, "Question", { fg = colors.green_primary })
  hl(0, "MoreMsg", { fg = colors.green_primary })
  hl(0, "WarningMsg", { fg = colors.yellow_primary })
  hl(0, "ErrorMsg", { fg = colors.red_primary })
  hl(0, "Title", { fg = colors.blue_primary, bold = true })
  hl(0, "NonText", { fg = colors.text_muted })
  hl(0, "Whitespace", { fg = colors.bg_elevated })
  hl(0, "SpecialKey", { fg = colors.text_muted })
  hl(0, "Conceal", { fg = colors.text_muted })
  hl(0, "MatchParen", { bg = colors.bg_overlay, bold = true })
  hl(0, "ModeMsg", { fg = colors.text_secondary })
  hl(0, "MsgArea", { fg = colors.text_secondary })
  hl(0, "MsgSeparator", { fg = colors.border_subtle })
  hl(0, "SpellBad", { undercurl = true, sp = colors.red_primary })
  hl(0, "SpellCap", { undercurl = true, sp = colors.yellow_primary })
  hl(0, "SpellLocal", { undercurl = true, sp = colors.blue_primary })
  hl(0, "SpellRare", { undercurl = true, sp = colors.purple_primary })
  hl(0, "EndOfBuffer", { fg = colors.bg_deep })
  hl(0, "QuickFixLine", { bg = colors.bg_elevated })
  hl(0, "Substitute", { fg = colors.bg_deep, bg = colors.yellow_primary })
  hl(0, "WildMenu", { fg = colors.text_primary, bg = colors.bg_overlay })

  -- Folding
  hl(0, "Folded", { fg = colors.text_muted, bg = colors.bg_primary })
  hl(0, "FoldColumn", { fg = colors.text_muted, bg = colors.bg_deep })
end

return M