-- Load the shared code to be used as a library from the lib.lua file
require 'lib'
-- Load the options from the config/options.lua file
require 'config.options'
-- Load the keymaps from the config/keymaps.lua file
require 'config.keymaps'
-- Load the auto commands from the config/autocmds.lua file
require 'config.autocmds'

-- Setup lazy, this should always be last
require 'config.lazy'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
