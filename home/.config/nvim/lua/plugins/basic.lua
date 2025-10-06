local M = {}

function M.setup()
  vim.pack.add {
    { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  {src = 'https://github.com/tpope/vim-fugitive'}
    -- { src = 'https://github.com/ThePrimeagen/vim-be-good' },
  }

  require('guess-indent').setup {}

  vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function()
      vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }
      require('nvim-autopairs').setup {}
    end,
  })

  vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
      vim.pack.add {
        { src = 'https://github.com/kylechui/nvim-surround', version = vim.version.range '^3' },
      }
      require('nvim-surround').setup()
    end,
  })
end

return M
