local M = {}

function M.setup()
  vim.pack.add { 'https://github.com/Mofiqul/vscode.nvim' }

  -- Load the colorscheme here.
  -- Like many other themes, this one has different styles, and you could load
  -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  vim.cmd.colorscheme 'vscode'

  -- You can configure highlights by doing something like:
  vim.cmd.hi 'Comment gui=none'
end

return M
