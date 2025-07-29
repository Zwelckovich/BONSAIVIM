-- BONSAI diagnostic utilities
-- Helper commands to inspect diagnostic sources

local M = {}

-- Show all diagnostics in current buffer with their sources
function M.show_diagnostics_with_source()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics == 0 then
    print("No diagnostics in current buffer")
    return
  end
  
  print("Diagnostics in current buffer:")
  print("─────────────────────────────")
  
  for _, diag in ipairs(diagnostics) do
    local severity = vim.diagnostic.severity[diag.severity]
    local source = diag.source or "unknown"
    local line = diag.lnum + 1
    local message = diag.message:gsub("\n", " ")
    
    print(string.format("[%s] Line %d: %s (from: %s)", 
      severity, line, message, source))
  end
end

-- Show diagnostic source under cursor
function M.show_diagnostic_source_at_cursor()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics == 0 then
    print("No diagnostics on current line")
    return
  end
  
  print("Diagnostics on current line:")
  for _, diag in ipairs(diagnostics) do
    local source = diag.source or "unknown"
    local severity = vim.diagnostic.severity[diag.severity]
    print(string.format("  [%s] from: %s", severity, source))
  end
end

-- Create user commands
vim.api.nvim_create_user_command('DiagnosticsSources', function()
  M.show_diagnostics_with_source()
end, { desc = "Show all diagnostics with their sources" })

vim.api.nvim_create_user_command('DiagnosticSource', function()
  M.show_diagnostic_source_at_cursor()
end, { desc = "Show diagnostic source at cursor" })

-- Optional keymaps (uncomment if desired)
-- vim.keymap.set('n', '<leader>ds', M.show_diagnostics_with_source, { desc = "Show diagnostic sources" })
-- vim.keymap.set('n', '<leader>dS', M.show_diagnostic_source_at_cursor, { desc = "Show diagnostic source at cursor" })

return M