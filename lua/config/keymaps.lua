-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Resize with arrows
vim.keymap.set('n', '<C-S-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-S-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-S-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-S-Right>', ':vertical resize +2<CR>')

-- -- Resize window using <ctrl> arrow keys
-- map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
-- map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
-- map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
-- map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Visual --
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left in visual mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right in visual mode' })

-- Move block
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Search for highlighted text in buffer
vim.keymap.set('v', '//', 'y/<C-R>"<CR>')

-- from LazyVim
-- ============

-- https://github.com/LazyVim/LazyVim/blob/a1c3ec4cd43fe61e3b614237a46ac92771191c81/lua/lazyvim/util/init.lua#L200
-- Wrapper around vim.keymap.set that will
-- not create a keymap if a lazy key handler exists.
-- It will also set `silent` to true by default.
local map = function(mode, lhs, rhs, opts)
  local modes = type(mode) == 'string' and { mode } or mode

  opts = opts or {}
  opts.silent = opts.silent ~= false
  if opts.remap and not vim.g.vscode then
    ---@diagnostic disable-next-line: no-unknown
    opts.remap = nil
  end
  vim.keymap.set(modes, lhs, rhs, opts)
end

-- https://github.com/LazyVim/LazyVim/blob/a1c3ec4cd43fe61e3b614237a46ac92771191c81/lua/lazyvim/config/keymaps.lua
-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Keybinds to make windows navigation easier.
-- Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move Lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- buffers
-- !!!check bufferline pluging configuration!!!
-- map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
-- map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
-- map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
-- map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>bd', require('lib').bufremove, { desc = '[D]elete Buffer' })
map('n', '<leader>bD', '<cmd>:bd<cr>', { desc = '[D]elete Buffer and Window' })

-- Clear search with <esc>
map({ 'i', 'n' }, '<esc>', '<cmd>nohlsearch<cr><esc>', { desc = 'Escape and Clear hlsearch', noremap = true })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map('n', '<leader>ur', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / Clear hlsearch / Diff Update' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- -- Find and center
-- vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
-- vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })

-- -- Vertical scroll and center
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- Buffers
-- !!!check bufferline pluging configuration!!!
-- vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', { noremap = true, silent = true }) -- close buffer
-- vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', { noremap = true, silent = true }) -- new buffer

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- save file
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

--keywordprg
map('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', { desc = 'Keep last yanked when pasting' })

-- commenting
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- -- new file
-- map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- map('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
-- map('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix List' })
map('n', '<leader>xl', function()
  local win = vim.api.nvim_get_current_win()
  local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
  local action = qf_winid > 0 and 'lclose' or 'lopen'
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, action)
end, { desc = 'Toggle [L]ocation List', silent = true })

map('n', '<leader>xx', function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and 'cclose' or 'copen'
  vim.cmd('botright ' .. action)
end, { desc = 'Toggle Quickfi[X] List', silent = true })

map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- -- formatting
-- map({ 'n', 'v' }, '<leader>cf', function()
--   LazyVim.format { force = true }
-- end, { desc = 'Format' })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

map('n', '<leader>cd', vim.diagnostic.open_float, { desc = '[C]urrent Line Diagnostics' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next [D]iagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev [D]iagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next [E]rror' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev [E]rror' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next [W]arning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev [W]arning' })
-- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- General keymaps
-- map('n', '<leader>wq', ':wq<CR>') -- save and quit
-- map('n', '<leader>ww', ':w<CR>') -- save
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })
-- map('n', '<leader>qq', ':q!<CR>') -- quit without saving
map('n', 'gx', ':!open <c-r><c-a><CR>') -- open URL under cursor

-- highlights under cursor
map('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
map('n', '<leader>uI', '<cmd>InspectTree<cr>', { desc = 'Inspect Tree' })

-- Terminal Mappings
-- vim.keymap.set('n', [[<C-\>]], '<cmd>ToggleTermToggleAll<CR>', { desc = 'Show Terminal', noremap = true, silent = true })
-- vim.keymap.set('n', [[<C-\>]], '<cmd>ToggleTerm<CR>', { desc = 'Show Terminal', noremap = true, silent = true })
vim.keymap.set({ 'n', 't', 'i', 'v' }, [[<C-\>]], function()
  ---@diagnostic disable-next-line: unused-local
  local was_open, term_wins = require('toggleterm.ui').find_open_windows()
  require('toggleterm').toggle_all(true)
  if not was_open then
    ---@diagnostic disable-next-line: unused-local, redefined-local
    local is_open, term_wins = require('toggleterm.ui').find_open_windows()
    if not is_open then
      require('toggleterm').toggle()
    end
  end
end, { desc = 'Toggle or create terminal', noremap = true, silent = true })
vim.keymap.set({ 'n', 't', 'i', 'v' }, [[<M-\>]], function()
  vim.print 'something'
  ---@diagnostic disable-next-line: unused-local
  local was_open, term_wins = require('toggleterm.ui').find_open_windows()
  if not was_open then
    require('toggleterm').toggle_all(true)
    ---@diagnostic disable-next-line: unused-local, redefined-local
    local is_open, term_wins = require('toggleterm.ui').find_open_windows()
    if not is_open then
      require('toggleterm').toggle()
    end
  else
    require('toggleterm.terminal').Terminal:new():open()
  end
end, { desc = 'Create new terminal', noremap = true, silent = true })

-- '<cmd>ToggleTerm<CR>', { desc = 'Show Terminal', noremap = true, silent = true })
-- require('toggleterm.ui').find_open_windows()

-- map('t', [[<C-\>]], '<cmd>close<cr>', function()
-- map('t', [[<C-\>]], function()
--   ---@diagnostic disable-next-line: unused-local
--   local is_open, term_wins = require('toggleterm.ui').find_open_windows()
--   if is_open then
--     require('toggleterm').toggle_all(true)
--   else
--     require('toggleterm').toggle_all(true)
--     ---@diagnostic disable-next-line: redefined-local, unused-local
--     local is_open, term_wins = require('toggleterm.ui').find_open_windows()
--     if not is_open then
--       require('toggleterm').toggle()
--     end
--   end
-- end, { desc = 'Hide Terminal', noremap = true, silent = true })
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
map('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })
map('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Go to Left Window' })
map('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Go to Lower Window' })
map('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Go to Upper Window' })
map('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Go to Right Window' })
map('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- windows
-- map('n', '<leader>w', '<c-w>', { desc = 'Windows', remap = true })
map('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })
-- Easily split windows
map('n', '<leader>wv', ':vsplit<cr>', { desc = '[W]indow Split [V]ertical' })
map('n', '<leader>wh', ':split<cr>', { desc = '[W]indow Split [H]orizontal' })
map('n', '<leader>wd', '<C-W>c', { desc = '[D]elete Window', remap = true })
-- LazyVim.toggle.map('<leader>wm', LazyVim.toggle.maximize)

-- tabs
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = '[L]ast Tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close [O]ther Tabs' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = '[F]irst Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New [⇥]Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = '[D]elete Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
map('n', '<c-tab>', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<c-s-tab>', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- Toggle line wrapping
vim.keymap.set('n', '<leader>tw', '<cmd>set wrap!<CR>', { desc = '[T]oggle Line [W]rapping', noremap = true, silent = true })

-- https://stackoverflow.com/questions/2978451/vim-cant-map-c-tab-to-tabnext
-- vim.cmd [[set timeout timeoutlen=1000 ttimeoutlen=100]]
-- vim.cmd [[set <F13>=[27;5;9~]]
-- vim.cmd [[nnoremap <F13> gt]]
-- vim.cmd [[set <F14>=[27;6;9~]]
-- vim.cmd [[nnoremap <F14> gT]]

-- vim: ts=2 sts=2 sw=2 et
