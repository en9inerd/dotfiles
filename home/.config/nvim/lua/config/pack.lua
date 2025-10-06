-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Add all plugin git repos (flat list). Each entry is a table { src = "<git url>" }.
-- This mirrors the plugins you had in lazy.nvim. vim.pack will ensure they are available on disk.
require('plugins.colorscheme').setup()
require('plugins.treesitter').setup()
require('plugins.basic').setup()
require('plugins.fzf').setup()
require('plugins.blink').setup()
require('plugins.lsp').setup()
require('plugins.which-key').setup()
require('plugins.gitsigns').setup()
require('plugins.indentmini').setup()
require('plugins.mini').setup()
require('plugins.conform').setup()
require('plugins.sessions').setup()
require('plugins.arrow').setup()
-- require('plugins.copilot').setup()

-- done. If new plugins are added/changed in this file, run :restart and then
-- :lua vim.pack.update() (or use the interactive update flow).
