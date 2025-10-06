local M = {}

function M.setup()
  vim.pack.add {
    { src = 'https://github.com/NMAC427/guess-indent.nvim' },
    { src = 'https://github.com/tpope/vim-fugitive' },
    { src = 'https://github.com/kylechui/nvim-surround', version = vim.version.range '^3' },
    { src = 'https://github.com/windwp/nvim-autopairs' },
    -- { src = 'https://github.com/ThePrimeagen/vim-be-good' },
  }

  require('guess-indent').setup {}
  require('nvim-surround').setup()
  require('nvim-autopairs').setup {}
end

return M
