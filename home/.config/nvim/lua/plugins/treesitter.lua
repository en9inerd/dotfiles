local M = {}

function M.setup()
  vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }

  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'c',
      'go',
      'html',
      'javascript',
      'typescript',
      'lua',
      'vim',
      'vimdoc',
      'query',
      'markdown',
      'markdown_inline',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  }
end

return M
