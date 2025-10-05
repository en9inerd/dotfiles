local M = {}
local loaded = false

function M.setup()
  local load_conform = function()
    if loaded then
      return
    end
    loaded = true

    vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

    require('conform').setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = {} -- { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports', 'gofmt' },
        -- Conform can also run multiple formatters sequentially
        python = { 'isort', 'black' },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettier', 'biome', stop_after_first = true },
        typescript = { 'prettier', 'biome', stop_after_first = true },
        html = { 'prettier', 'biome', stop_after_first = true },
        css = { 'prettier', 'biome', stop_after_first = true },
        scss = { 'prettier', 'biome', stop_after_first = true },
        json = { 'prettier', 'biome', stop_after_first = true },
        htmlangular = { 'prettier', 'biome', stop_after_first = true },
        -- markdown = { 'prettier', 'biome', stop_after_first = true },
      },
    }
  end

  vim.api.nvim_create_autocmd('BufWritePre', { once = true, callback = load_conform })

  vim.keymap.set('', '<leader>f', function()
    load_conform()
    require('conform').format { async = true, lsp_format = 'fallback' }
  end, { desc = '[F]ormat buffer' })
end

return M
