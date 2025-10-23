local M = {}

function M.setup()
  vim.pack.add {
    {
      src = 'https://github.com/nvim-treesitter/nvim-treesitter',
      version = 'main',
    },
  }

  require('nvim-treesitter').install {
    'c',
    'bash',
    'go',
    'gomod',
    'gosum',
    'gowork',
    'html',
    'htmlangular',
    'css',
    'scss',
    'make',
    'javascript',
    'typescript',
    'lua',
    'vim',
    'vimdoc',
    'query',
    'markdown',
    'markdown_inline',
    'zig',
    'yaml',
    'dockerfile',
    'json',
  }

  vim.api.nvim_create_autocmd('PackChanged', {
    pattern = '*',
    callback = function(ev)
      vim.notify(ev.data.spec.name .. ' has been updated.')
      if ev.data.spec.name == 'nvim-treesitter' and ev.data.spec.kind ~= 'deleted' then
        vim.cmd [[TSUpdate]]
      end
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function()
      pcall(vim.treesitter.start)
    end,
  })
end

return M
