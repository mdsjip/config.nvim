-- [[ Setting options ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.numberwidth = 4 -- set width of line number columns

-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- https://neovim.io/doc/user/options.html#'laststatus'
vim.opt.laststatus = 3

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
-- Tab spacing/behavior
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- number of spaces inserted for each indentation level
vim.opt.tabstop = 4 -- number of spaces inserted for tab character
vim.opt.softtabstop = 4 -- number of spaces inserted for <Tab> key
vim.opt.smartindent = true -- enable smart indentation
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
-- Searching Behaviors
vim.opt.hlsearch = true -- highlight all matches in search
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- match case if explicitly stated

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
-- vim.opt.timeoutlen = 1000 -- set timeout for mapped sequences

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
-- Minimal number of screen lines to keep left and right the cursor.
vim.opt.sidescrolloff = 10

-- https://neovim.io/doc/user/russian.html
vim.opt.langmap =
  'Ж;:,ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

-- :help sd
-- shared data file options
-- ! When included, save and restore global variables that start with an uppercase letter, and don't contain a lowercase letter
-- ' Maximum number of previously edited files for which the marks are remembered.
-- < Maximum number of lines saved for each register.
-- s Maximum size of an item contents in KiB.
vim.opt.shada = "!,'100000000,<10000000,s10000000,%"
-- max value is 10000, unfortunately
vim.opt.history = 10000
-- vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.sessionoptions = {
  'blank',
  'buffers',
  'curdir',
  'folds',
  'globals',
  'help',
  'tabpages',
  'terminal',
  'skiprtp',
  'winsize',
}

-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25

-- modern cursor behavior that actually makes sense
-- switch to next/previous line with cursor movements
-- char   key     mode
--  b    <BS>     Normal and Visual
--  s    <Space>  Normal and Visual
--  h    "h"      Normal and Visual (not recommended)
--  l    "l"      Normal and Visual (not recommended)
--  <    <Left>   Normal and Visual
--  >    <Right>  Normal and Visual
--  ~    "~"      Normal
--  [    <Left>   Insert and Replace
--  ]    <Right>  Insert and Replace
vim.opt.whichwrap = 'b,s,<,>,h,l,[,]'
-- allow to move cursor after last character
vim.opt.virtualedit = 'onemore'
-- also put cursor after last character when $ is pressed
--vim.keymap.set('n', '$', '$l')
vim.api.nvim_set_keymap('n', '$', "col('$')==1?'$':'$l'", {
  expr = true,
  noremap = false,
  nowait = true,
  silent = true,
})
-- also put cursor after last character when h is pressed in the beginning of the next line
vim.api.nvim_set_keymap('n', 'h', "col('.')==1?'k$':'h'", {
  expr = true,
  noremap = false,
  nowait = true,
  silent = true,
})
-- also put cursor after last character when <Left> is pressed in the beginning of the next line
vim.api.nvim_set_keymap('n', '<Left>', "col('.')==1?'k$':'h'", {
  expr = true,
  noremap = false,
  nowait = true,
  silent = true,
})

vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = 'utf-8' -- set file encoding to UTF-8
vim.opt.termguicolors = true -- enable term GUI colors

-- Folding
vim.opt.foldlevel = 20
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' -- Utilize Treesitter folds

-- Backspace
vim.opt.backspace = 'indent,eol,start'

-- https://github.com/hendrikmi/neovim-kickstart-config/blob/main/lua/core/options.lua
-- vim.o.showtabline = 2 -- Always show tabs (default: 1)
-- vim.opt.iskeyword:append '-'
-- vim.opt.iskeyword:append '.'

vim.o.wrap = true -- Wrap long lines (default: true)
vim.o.linebreak = true -- Companion to wrap, don't split words (default: false)

vim.o.pumheight = 10 -- Pop up menu height (default: 0)
vim.o.cmdheight = 1 -- More space in the Neovim command line for displaying messages (default: 1)
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience (default: 'menu,preview')
vim.opt.shortmess:append 'c' -- Don't give |ins-completion-menu| messages (default: does not include 'c')
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')

-- https://github.com/hendrikmi/neovim-kickstart-config/blob/9456c21ee89c315ea27a006b25429e2b5952c873/lua/core/snippets.lua#L7-L26
-- Appearance of diagnostics
vim.diagnostic.config {
  virtual_text = {
    prefix = '●',
    -- Add a custom format function to show error codes
    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },
  underline = false,
  update_in_insert = true,
  float = {
    source = true, -- Or "if_many"
  },
  -- Make diagnostic background transparent
  on_ready = function()
    vim.cmd 'highlight DiagnosticVirtualText guibg=NONE'
  end,
}

-- vim: ts=2 sts=2 sw=2 et
