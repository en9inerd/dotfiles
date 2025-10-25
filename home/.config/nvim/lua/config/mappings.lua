-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Close current buffer
vim.keymap.set('n', '<leader>bd', ':bp | bd#<CR>', { desc = 'Delete buffer, keep window' })

vim.keymap.set('n', '<leader>w', ':up<CR>', { desc = 'Save current buffer' })

-- Keymap for netrw
vim.keymap.set('n', '<leader>e', '<cmd>Explore<CR>', { desc = 'Open netrw' })

--) Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Move lines up and down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Joining lines should not remove the cursor position
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines' })

-- Keep cursor centered when navigating up and down
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down half a page' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up half a page' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Search next' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Search previous' })

-- Restart LSP
vim.keymap.set('n', '<leader>zig', '<cmd>LspRestart<cr>', { desc = 'Restart LSP' })

-- Paste from clipboard in visual mode
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste from clipboard' })

-- Clipboard integration
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Copy to clipboard (line)' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without copying to clipboard' })

-- Search and replace
vim.keymap.set('n', '<leader>S', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Substitution' })

-- Make the current file executable
vim.keymap.set('n', '<leader>X', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make file executable' })
