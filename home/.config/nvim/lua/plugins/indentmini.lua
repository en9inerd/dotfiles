local M = {}

function M.setup()
  vim.pack.add { 'https://github.com/nvimdev/indentmini.nvim' }

  require('indentmini').setup()
  vim.cmd [[highlight IndentLine guifg=#2e2d2d]]
  vim.cmd [[highlight IndentLineCurrent guifg=#757575]]
end

return M
