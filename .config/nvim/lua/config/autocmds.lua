-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Save current session of project by working directory
-- vim.api.nvim_create_autocmd('VimLeavePre', {
--   desc = 'Save current session of project by working directory',
--   group = vim.api.nvim_create_augroup('save-session', { clear = true }),
--   callback = function()
--     if vim.g.savesession then
--       local cwd = vim.fn.getcwd()
--       local base = vim.fn.fnamemodify(cwd, ':p:h:t')
--       local hash = vim.fn.sha256(cwd):sub(1, 8)
--       local session_file = vim.fn.stdpath 'data' .. '/sessions/' .. base .. '-' .. hash .. '.vim'
--
--       vim.fn.mkdir(vim.fn.stdpath 'data' .. '/sessions', 'p')
--       vim.cmd('mksession! ' .. vim.fn.fnameescape(session_file))
--     end
--   end,
-- })

-- Restore session of project by working directory
-- vim.api.nvim_create_autocmd('VimEnter', {
--   desc = 'Restore session of project by working directory',
--   group = vim.api.nvim_create_augroup('restore-session', { clear = true }),
--   callback = function()
--     if vim.g.savesession then
--       local cwd = vim.fn.getcwd()
--       local base = vim.fn.fnamemodify(cwd, ':p:h:t')
--       local hash = vim.fn.sha256(cwd):sub(1, 8)
--       local session_file = vim.fn.stdpath 'data' .. '/sessions/' .. base .. '-' .. hash .. '.vim'
--
--       if vim.fn.filereadable(session_file) == 1 then
--         vim.cmd('source ' .. vim.fn.fnameescape(session_file))
--       end
--     end
--   end,
--   nested = true,
-- })
