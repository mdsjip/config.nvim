-- local s = function()
--   print ';a;a;'
--   local ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
--   if ft == 'neo-tree' then
--     vim.cmd 'e #'
--   end
-- end
-- vim.keymap.set('n', 'q', require('lib').bufremove, { desc = 'Switch to Other Buffer', remap = true, silent = true, buffer = true })
-- vim.keymap.set(
--   'n',
--   '<Esc><Esc>',
--   '<cmd>e #<cr>',
--   -- function()
--   --   local ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
--   --   if ft == 'neo-tree' then
--   --     vim.cmd 'e #'
--   --   end
--   -- end,
--   { desc = 'Switch to Other Buffer' }
-- )
-- vim.keymap.set('n', 'q', '<cmd>lclose | cclose<cr>', { desc = 'Close quickfix list', remap = true, silent = true, buffer = true })
