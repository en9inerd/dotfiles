local M = {}

function M.setup()
  vim.pack.add { 'https://github.com/rmagatti/auto-session' }

  require('auto-session').setup {
    auto_create = function()
      local cmd = 'git rev-parse --is-inside-work-tree'
      return vim.fn.system(cmd) == 'true\n'
    end,
  }
end

return M
