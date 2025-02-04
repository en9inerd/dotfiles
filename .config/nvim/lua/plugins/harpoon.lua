return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  depenedencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add current file to harpoon' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open harpoon window' })
    vim.keymap.set('n', '<C-j>', function()
      harpoon:list():next()
    end, { desc = 'Navigate to next file' })
    vim.keymap.set('n', '<C-k>', function()
      harpoon:list():prev()
    end, { desc = 'Navigate to previous file' })
  end,
}
