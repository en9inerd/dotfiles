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
    'angular',
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
    'yaml',
    'dockerfile',
    'json',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'sql',
    'ssh_config',
    'toml',
    'tmux',
    'zig',
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
