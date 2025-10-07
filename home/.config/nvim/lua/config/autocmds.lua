-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
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
