-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local function augroup(name)
  return vim.api.nvim_create_augroup('my_' .. name, { clear = true })
end

-- Remove empty buffer at start-up if other buffers are present
-- https://vi.stackexchange.com/a/44625
-- https://vi.stackexchange.com/questions/44807/check-if-there-are-non-empty-or-named-buffers-open
vim.api.nvim_create_autocmd('UIEnter', {
  desc = 'Remove empty buffer at start-up if other buffers are present',
  group = augroup 'remove_empty_buffers',
  callback = function()
    vim.schedule(function()
      require('lib').delete_empty_buffers()
    end)
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup 'highlight_yank',
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    -- vim.print(vim.bo[event.buf].filetype)
    if vim.bo[event.buf].filetype == 'checkhealth' then
      -- vim.print 'inside if'
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        -- vim.print('filetype: ' .. vim.bo[0].filetype)
        -- if not vim.bo[0].filetype == 'neo-tree' then
        require('lib').bufremove(event.buf)
        -- end
      end, { buffer = event.buf, silent = true })
    else
      vim.bo[event.buf].buflisted = false
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'man_unlisted',
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup 'auto_create_dir',
  callback = function(event)
    if event.match:match '^%w%w+://' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

local function remove_qf_item()
  local curqfidx = vim.fn.line '.' - 1
  local qfall = vim.fn.getqflist()
  table.remove(qfall, curqfidx + 1) -- Lua indexing starts at 1
  vim.fn.setqflist(qfall, 'r')
  vim.cmd(curqfidx + 1 .. 'cfirst')
  vim.cmd 'copen'
end

vim.api.nvim_create_user_command('RemoveQFItem', remove_qf_item, { desc = 'Use `dd` to delete an item in quickfix list' })

vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'quickfix_mappings',
  pattern = { 'qf' },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'dd', '<cmd>RemoveQFItem<CR>', { noremap = true, silent = true })
  end,
})
