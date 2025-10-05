local M = {}

function M.setup()
  vim.pack.add { 'https://github.com/otavioschwanck/arrow.nvim' }

  require('arrow').setup {
    leader_key = '<leader>;',
    buffer_leader_key = '<leader>m',
  }
end

return M
