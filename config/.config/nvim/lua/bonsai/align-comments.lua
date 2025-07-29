-- BONSAI custom comment aligner for shell scripts
-- Aligns comments in blocks, similar to LazyVim behavior

local M = {}

-- Helper function to find the position of a true comment (not # in strings or paths)
local function find_comment_position(line)
  -- In bash, a # is a comment if:
  -- 1. It's at the start of the line (handled separately)
  -- 2. It's preceded by whitespace (not part of a word/path)
  -- 3. It's not inside quotes
  
  local in_single_quote = false
  local in_double_quote = false
  local escaped = false
  
  for i = 1, #line do
    local char = line:sub(i, i)
    local prev_char = i > 1 and line:sub(i-1, i-1) or ""
    
    -- Handle escape sequences
    if escaped then
      escaped = false
    elseif char == "\\" then
      escaped = true
    -- Handle quotes
    elseif char == "'" and not in_double_quote then
      in_single_quote = not in_single_quote
    elseif char == '"' and not in_single_quote then
      in_double_quote = not in_double_quote
    -- Check for comment
    elseif char == "#" and not in_single_quote and not in_double_quote then
      -- A # is a comment if it's preceded by whitespace or at the start
      if i == 1 or prev_char:match("%s") then
        return i
      end
    end
  end
  
  return nil
end

function M.align_bash_comments()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local modified = false
  
  local i = 1
  while i <= #lines do
    -- Skip empty lines and comment-only lines
    if lines[i]:match("^%s*$") or lines[i]:match("^%s*#") then
      i = i + 1
    else
      -- Find a block of lines with trailing comments
      local block_start = nil
      local block_end = nil
      local max_content_length = 0
      
      -- Look for the start of a block
      for j = i, #lines do
        local line = lines[j]
        local comment_pos = find_comment_position(line)
        
        -- Check if line has content followed by a comment
        if comment_pos and comment_pos > 1 then
          if not block_start then
            block_start = j
          end
          block_end = j
          -- Get the content before the comment
          local content = line:sub(1, comment_pos - 1)
          -- Remove trailing spaces from content
          content = content:gsub("%s+$", "")
          max_content_length = math.max(max_content_length, #content)
        else
          -- End of block (empty line, comment-only line, or line without comment)
          break
        end
      end
      
      -- Align the block if we found one
      if block_start and block_end and block_end >= block_start then
        -- Add some padding (minimum 2 spaces before comment)
        local target_column = max_content_length + 2
        
        for j = block_start, block_end do
          local line = lines[j]
          local comment_pos = find_comment_position(line)
          
          if comment_pos and comment_pos > 1 then
            local content = line:sub(1, comment_pos - 1)
            local comment = line:sub(comment_pos)
            -- Remove trailing spaces from content
            content = content:gsub("%s+$", "")
            -- Calculate padding
            local padding = target_column - #content
            -- Reconstruct the line
            lines[j] = content .. string.rep(" ", padding) .. comment
            modified = true
          end
        end
        
        i = block_end + 1
      else
        i = i + 1
      end
    end
  end
  
  -- Update buffer if modified
  if modified then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  end
end

return M