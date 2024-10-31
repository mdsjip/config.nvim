-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      -- https://github.com/tiagovla/scope.nvim?tab=readme-ov-file#-telescope
      'tiagovla/scope.nvim',
      -- https://github.com/scottmckendry/telescope-resession.nvim?tab=readme-ov-file#-extension-installation
      'scottmckendry/telescope-resession.nvim',
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        defaults = {
          mappings = {
            i = {
              ['<C-Down>'] = require('telescope.actions').cycle_history_next,
              ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
              --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            },
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },

          ['resession'] = {
            prompt_title = 'Find Sessions', -- telescope prompt title
            dir = 'session', -- directory where resession stores sessions
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'scope')
      pcall(require('telescope').load_extension, 'resession')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch [T]elescope' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
      vim.keymap.set('n', '<leader>sH', builtin.highlights, { desc = '[S]earch [H]ighlight Groups' })

      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sF', function()
        builtin.find_files { root = false }
      end, { desc = '[S]earch [F]iles (cwd)' })

      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('v', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      -- vim.keymap.set('n', '<leader>sw', function()
      --   builtin.grep_string { word_match = '-w' }
      -- end, { desc = 'Word (Root Dir)' })
      vim.keymap.set('n', '<leader>sW', function()
        builtin.grep_string { word_match = '-w', root = false }
      end, { desc = '[S]earch current [W]ord (cwd)' })
      vim.keymap.set('v', '<leader>sW', function()
        builtin.grep_string { root = false }
      end, { desc = '[S]earch current [W]ord (cwd)' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })
      vim.keymap.set('n', '<leader>sG', function()
        builtin.live_grep { root = false }
      end, { desc = '[S]earch by [G]rep (cwd)' })

      vim.keymap.set('n', '<leader>sD', builtin.diagnostics, { desc = '[S]earch [D]iagnostics (workspace)' })
      vim.keymap.set('n', '<leader>sd', function()
        builtin.diagnostics { bufnr = 0 }
      end, { desc = '[S]earch [D]iagnostics (document)' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      -- vim.keymap.set('n', '<leader>sR', function()
      --   builtin.oldfiles { cwd = vim.uv.cwd() }
      -- end, { desc = 'Recent (cwd)' })

      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Search existing buffers' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })

      -- vim.keymap.set('n', '<leader>,', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Switch Buffer' })
      vim.keymap.set('n', '<leader>s:', builtin.command_history, { desc = '[S]earch [:] command history' })
      -- find
      vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
      -- git
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [C]ommits' })
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })
      -- search
      vim.keymap.set('n', '<leader>s"', builtin.registers, { desc = '[S]earch ["] registers' })
      -- vim.keymap.set('n', '<leader>sa', builtin.autocommands, { desc = 'Auto Commands' })
      -- vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = 'Buffer' })
      vim.keymap.set('n', '<leader>sC', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader>sj', builtin.jumplist, { desc = '[S]earch [J]umplist' })
      vim.keymap.set('n', '<leader>sl', builtin.loclist, { desc = '[S]earch [L]ocation List' })
      vim.keymap.set('n', '<leader>sM', builtin.man_pages, { desc = '[S]earch [M]an Pages' })
      vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })
      vim.keymap.set('n', '<leader>so', builtin.vim_options, { desc = '[S]earch [O]ptions' })
      vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix List' })
      vim.keymap.set('n', '<leader>ss', function()
        require('telescope.builtin').lsp_document_symbols {}
      end, { desc = '[S]earch Document [S]ymbol (LSP)' })
      vim.keymap.set('n', '<leader>sS', function()
        require('telescope.builtin').lsp_dynamic_workspace_symbols {}
      end, {
        desc = '[S]earch Workspace [S]ymbol (LSP)',
      })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>uC', function()
        builtin.colorscheme { enable_preview = true }
      end, { desc = '[U]I [C]olorscheme with Preview' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
