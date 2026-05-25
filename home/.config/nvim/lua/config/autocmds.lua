-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd({ 'TextYankPost', 'TextPutPost' }, {
  desc = 'Highlight operator region',
  group = vim.api.nvim_create_augroup('highlight-op', { clear = true }),
  callback = function()
    vim.hl.hl_op()
  end,
})

-- Define the VeryLazy event (once at startup)
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.schedule(function()
      vim.api.nvim_exec_autocmds('User', { pattern = 'VeryLazy' })
    end)
  end,
})
