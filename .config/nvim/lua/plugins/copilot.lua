return {
  {
    'github/copilot.vim',
    config = function()
      -- Disable the default <Tab> mapping
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enabled = false

      -- Define a function to toggle Copilot
      local function toggle_copilot()
        if vim.g.copilot_enabled then
          vim.g.copilot_enabled = false
          print 'Copilot disabled'
        else
          vim.g.copilot_enabled = true
          print 'Copilot enabled'
        end
      end

      -- Create a user command to toggle Copilot
      vim.api.nvim_create_user_command('ToggleCopilot', toggle_copilot, { desc = 'Toggle GitHub Copilot' })

      -- Set the default keymap for Copilot
      vim.keymap.set('i', '<M-k>', 'copilot#Accept("\\<CR>")', { expr = true, silent = true, replace_keycodes = false })
      vim.keymap.set('i', '<M-j>', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<M-h>', '<Plug>(copilot-previous)')
      vim.keymap.set('i', '<M-l>', '<Plug>(copilot-suggest)')
      vim.keymap.set('n', '<M-t>', ':ToggleCopilot<CR>')
    end,
  },
}
