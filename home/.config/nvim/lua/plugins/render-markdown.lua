local M = {}

function M.setup()
  vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

  require('render-markdown').setup {
    enabled = false,
    latex = {
      enabled = false,
    },
  }
end

return M
