return {
  'nvimdev/indentmini.nvim',
  config = function(_, opts)
    require('indentmini').setup(opts)

    vim.cmd [[highlight IndentLine guifg=#2e2d2d]]
    vim.cmd [[highlight IndentLineCurrent guifg=#757575]]
  end,
}
