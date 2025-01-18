return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    config = function()
      local scopeHl = {
        'LightGray',
      }
      local indentHl = {
        'DarkGray',
      }

      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'LightGray', { fg = '#757575' })
        vim.api.nvim_set_hl(0, 'DarkGray', { fg = '#2e2d2d' })
      end)

      require('ibl').setup {
        scope = {
          highlight = scopeHl,
        },
        indent = {
          char = '▏',
          tab_char = '▏',
          highlight = indentHl,
        },
      }
    end,
  },
}
