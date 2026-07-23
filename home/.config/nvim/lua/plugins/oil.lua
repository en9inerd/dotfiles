local M = {}

function M.setup()
  vim.pack.add { 'https://github.com/stevearc/oil.nvim' }

  local oil = require 'oil'

  oil.setup {
    default_file_explorer = false,
    view_options = {
      show_hidden = true,
    },
  }

  vim.keymap.set('n', '<leader>e', function()
    oil.open()
  end, {
    desc = 'Open file browser',
  })
end

return M
