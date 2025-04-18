return {
  'nvimdev/indentmini.nvim',
  config = function(_, opts)
    require('indentmini').setup(opts)

    vim.cmd [[highlight IndentLine guifg=#757575]]
    vim.cmd [[highlight IndentLineCurrent guifg=#2e2d2d]]
  end,
}
