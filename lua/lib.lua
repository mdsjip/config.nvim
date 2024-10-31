local M = {}

-- copied from https://github.com/LazyVim/LazyVim/blob/a1c3ec4cd43fe61e3b614237a46ac92771191c81/lua/lazyvim/util/ui.lua#L228-L268
---@param buf number?
function M.bufremove(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if vim.bo.modified then
    local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
    if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return
      end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr '#'
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      ---@diagnostic disable-next-line: param-type-mismatch
      local has_previous = pcall(vim.cmd, 'bprevious')
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    ---@diagnostic disable-next-line: param-type-mismatch
    pcall(vim.cmd, 'bdelete! ' .. buf)
  end
end

function M.delete_empty_buffers()
  local buffers = vim.api.nvim_list_bufs()
  if #buffers == 1 then
    return
  end

  -- for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if not bufname == '' then
    goto continue -- If any buffer has a name, skip
  end

  local readonly = vim.api.nvim_get_option_value('readonly', { buf = bufnr })
  if readonly then
    goto continue
  end
  local bufloaded = vim.api.nvim_buf_is_loaded(bufnr)
  -- vim.print('buffer loaded: ' .. tostring(bufloaded) .. ' for buffer: ' .. bufnr)
  if not bufloaded then
    goto continue
  end

  local bufhidden = vim.api.nvim_get_option_value('bufhidden', { buf = bufnr })
  -- vim.print('buffer hidden: ' .. bufhidden .. ' for buffer: ' .. bufnr)
  if not bufhidden == '' then
    goto continue
  end

  local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })
  -- vim.print('buffer type: ' .. buftype .. ' for buffer: ' .. bufnr)
  if not (buftype == '' or buftype == 'nofile') then
    goto continue
  end

  local text = vim.api.nvim_buf_get_text(bufnr, 0, 0, 0, 1, {})
  if not (#text == 0 or string.len(text[1]) == 0) then
    goto continue
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  -- vim.print('buffer lines: ' .. #lines .. ' for buffer: ' .. bufnr)
  if #lines > 1 or (#lines == 1 and #lines[1] > 0) then
    goto continue -- If any buffer has content, skip
  end

  -- vim.print('deleting buffer ' .. bufnr)
  vim.cmd 'BufferLineCycleNext'
  require('lib').bufremove(bufnr)
  -- pcall(vim.cmd, 'bdelete! ' .. bufnr)
  -- vim.api.nvim_buf_delete(bufnr, {
  --  force = true,
  -- })
  goto for_break
  ::continue::
  -- end
  ::for_break::
end

return M
