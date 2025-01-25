return {
  'tpope/vim-obsession',
  lazy = false, -- Load eagerly since vim-obsession doesn't have events/hooks
  config = function()
    -- Set session options
    vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

    -- Define centralized session directory
    local session_dir = vim.fn.stdpath 'data' .. '/sessions/'
    vim.fn.mkdir(session_dir, 'p') -- Ensure the directory exists

    -- Auto-save session on exit (only if opened a directory)
    vim.api.nvim_create_autocmd('VimLeavePre', {
      group = vim.api.nvim_create_augroup('obsession_auto_save', { clear = true }),
      callback = function()
        -- Only save session if Neovim was opened with a directory (not a file)
        local arg = vim.fn.argv(0) -- Get the first argument passed to nvim
        if vim.fn.isdirectory(arg) == 1 then
          local cwd = vim.fn.getcwd()
          local base = vim.fn.fnamemodify(cwd, ':p:h:t')
          local hash = vim.fn.sha256(cwd):sub(1, 8)
          local session_file = session_dir .. base .. '-' .. hash .. '.vim'

          vim.cmd('Obsession ' .. vim.fn.fnameescape(session_file))
        end
      end,
    })

    -- Auto-restore session on start (only if opened a directory)
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('obsession_auto_restore', { clear = true }),
      callback = function()
        -- Check if the first argument is a directory (nvim . or nvim /path/to/directory)
        local arg = vim.fn.argv(0) -- Get the first argument passed to nvim
        if vim.fn.isdirectory(arg) == 1 then
          local cwd = vim.fn.getcwd()
          local base = vim.fn.fnamemodify(cwd, ':p:h:t')
          local hash = vim.fn.sha256(cwd):sub(1, 8)
          local session_file = session_dir .. base .. '-' .. hash .. '.vim'

          if vim.fn.filereadable(session_file) == 1 then
            vim.cmd('source ' .. vim.fn.fnameescape(session_file))
          end
        end
      end,
    })
  end,
}
