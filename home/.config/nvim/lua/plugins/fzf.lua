return {
  {
    'ibhagwan/fzf-lua',
    config = function()
      require('fzf-lua').setup {
        -- 'telescope',
        winopts = {
          preview = {
            hidden = true,
          },
        },
        defaults = {
          formatter = 'path.filename_first',
        },
        files = {
          cwd_prompt = false,
        },
        lsp = {
          code_actions = {
            winopts = {
              height = 0.3,
              width = 0.4,
            },
          },
        },
      }
      require('fzf-lua').register_ui_select()

      local fzf = require 'fzf-lua'

      -- Basic pickers
      vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', fzf.commands, { desc = '[S]elect [S]earch command' })
      vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sW', function()
        fzf.grep_cWORD()
      end, { desc = '[S]earch current [W]ORD' })
      vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sp', function()
        fzf.grep { search = vim.fn.input 'Grep > ' }
      end, { desc = '[S]earch [P]rompted grep' })
      vim.keymap.set('n', '<leader>sd', fzf.diagnostics_workspace, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]ecent commands' })
      vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })

      -- Git pickers
      vim.keymap.set('n', '<leader>gc', fzf.git_commits, { desc = '[G]it [C]ommits' })
      vim.keymap.set('n', '<leader>gb', fzf.git_branches, { desc = '[G]it [B]ranches' })
      vim.keymap.set('n', '<leader>gs', fzf.git_status, { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gS', fzf.git_stash, { desc = '[G]it [S]tash' })
      vim.keymap.set('n', '<leader>gf', fzf.git_files, { desc = '[G]it [F]iles (tracked)' })
      vim.keymap.set('n', '<leader>gB', fzf.git_bcommits, { desc = '[G]it buffer [C]ommits' })

      -- Search in current buffer
      vim.keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Fuzzily search in current buffer' })

      -- Live grep in open files
      vim.keymap.set('n', '<leader>s/', function()
        fzf.live_grep { grep_open_files = true, prompt = 'Live Grep in Open Files' }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Search Neovim config
      vim.keymap.set('n', '<leader>sn', function()
        fzf.files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
