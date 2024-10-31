-- local formatted = string.format('([^%s]+)', require('plenary.path').path.sep)
-- local split_by_separator = function(filepath)
--   local t = {}
--   for str in string.gmatch(filepath, formatted) do
--     table.insert(t, str)
--   end
--   return t
-- end
--
-- local tab_name = function(dirpath)
--   local parts = split_by_separator(dirpath)
--   local _, p1 = string.find(dirpath, '/repos/.')
--   if p1 then
--     local _, p2 = string.find(dirpath, '/repos/.*/.')
--     if p2 then
--       return table.concat(parts, '-', #parts - 2, #parts - 1)
--     end
--   end
--   return parts[#parts - 1]
-- end

return {
  {
    'mdsjip/bufferline.nvim',
    -- event = 'VeryLazy',
    lazy = false,
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle [P]in' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-[P]inned Buffers' },
      { '<leader>bO', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete [O]ther Buffers' },
      { '<leader>bR', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the [R]ight' },
      { '<leader>bL', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the [L]eft' },
      { '<leader>bh', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<leader>bl', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<M-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<M-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<Tab>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    opts = {
      options = {
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        -- numbers = 'both', -- | "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,

        -- close_command = 'bdelete! %d', -- can be a string | function, | false see "Mouse actions"
        -- right_mouse_command = 'bdelete! %d', -- can be a string | function | false, see "Mouse actions"
        -- left_mouse_command = 'buffer %d', -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = false, -- can be a string | function | false, see "Mouse actions"
        middle_mouse_command = false, -- can be a string | function, | false see "Mouse actions"        -- stylua: ignore
        close_command = function(buf)
          require('lib').bufremove(buf)
        end,
        show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
        duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        diagnostics = 'nvim_lsp',
        move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        -- separator_style = 'slant', -- | "slope" | "thick" | "thin" | { 'any', 'any' },
        separator_style = 'thin', -- | "slope" | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = false,
        -- always_show_bufferline = true ,
        -- auto_toggle_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
        sort_by = 'insert_after_current', -- |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
        --     -- add custom logic
        --     local modified_a = vim.fn.getftime(buffer_a.path)
        --     local modified_b = vim.fn.getftime(buffer_b.path)
        --     return modified_a > modified_b
        -- end
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --   return '(' .. count .. ')'
        -- end,
        -- -- NOTE: this will be called a lot so don't do any heavy processing here
        -- custom_filter = function(buf_number, buf_numbers)
        -- -- filter out filetypes you don't want to see
        -- if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
        --   return true
        -- end
        -- -- filter out filetypes you don't want to see
        -- if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
        --   return true
        -- end
        -- -- filter out by buffer name
        -- if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
        --   return true
        -- end
        -- -- filter out based on arbitrary rules
        -- -- e.g. filter out vim wiki buffer from tabline in your work repo
        -- if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
        --   return true
        -- end
        -- filter out by it's index number in list (don't show first buffer)
        -- if buf_numbers[1] ~= buf_number then
        --   return true
        -- end
        -- end,
        tab_size = 2,
        always_show_bufferline = true,
        show_tab_indicators = true,
        always_show_tab_indicators = true,
        -- name_formatter = function(tab)
        --   -- tab contains:
        --   -- cwd                 | str        | current working directory for this tab
        --   -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
        --   -- vim.print(vim.inspect(buf))
        --   if tab and tab.tabnr then
        --     vim.print(string.format("found tabnr, buf: %s", vim.inspect(tab)))
        --     return vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tab.tabnr))
        --   end
        -- end,
        -- tab_name_formatter = function(buf)
        --   -- buf contains:
        --   -- name                | str        | the basename of the active file
        --   -- path                | str        | the full path of the active file
        --   -- bufnr               | int        | the number of the active buffer
        --   -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
        --   -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
        --   vim.print(vim.inspect(buf))
        --   if buf.tabnr then
        --     -- vim.print(string.format("found tabnr, buf: %s", vim.inspect(buf)))
        --     local dirpath = vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(buf.tabnr))
        --     return tab_name(dirpath)
        --     -- return vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(buf.tabnr))
        --   end
        -- end,
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
