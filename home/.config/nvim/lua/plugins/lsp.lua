local M = {}

function M.setup()
  vim.pack.add {
    { src = 'https://github.com/j-hui/fidget.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  }

  -- Load on Lua filetypes (ft = 'lua'). Run once.
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'lua',
    once = true,
    callback = function()
      vim.pack.add { 'https://github.com/folke/lazydev.nvim' }

      require('lazydev').setup {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      }
    end,
  })

  require('fidget').setup {}
  require('mason').setup {}

  -- make floating preview include a border by default
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'single'
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  -- LspAttach autocommand for buffer-local keymaps and other buffer-specific setup
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
      local fzf = require 'fzf-lua'
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('grr', fzf.lsp_references, '[G]oto [R]eferences')
      map('gri', fzf.lsp_implementations, '[G]oto [I]mplementation')
      map('grd', fzf.lsp_definitions, '[G]oto [D]efinition')
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('gO', fzf.lsp_document_symbols, 'Open Document Symbols')
      map('gW', fzf.lsp_workspace_symbols, 'Open Workspace Symbols')
      map('grt', fzf.lsp_typedefs, '[G]oto [T]ype Definition')

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Diagnostic config
  vim.diagnostic.config {
    update_in_insert = true,
    severity_sort = true,
    float = { border = 'single', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = {
      source = 'if_many',
      spacing = 2,
      format = function(diagnostic)
        local diagnostic_message = {
          [vim.diagnostic.severity.ERROR] = diagnostic.message,
          [vim.diagnostic.severity.WARN] = diagnostic.message,
          [vim.diagnostic.severity.INFO] = diagnostic.message,
          [vim.diagnostic.severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
      numhl = {
        [vim.diagnostic.severity.WARN] = 'WarningMsg',
        [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
        [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
      },
    },
  }

  local servers = {
    -- clangd = {},
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        nilness = true,
      },
    },
    basedpyright = {
      settings = {
        basedpyright = {
          analysis = {
            useLibraryCodeForTypes = true,
            typeCheckingMode = 'off',
            diagnosticSeverityOverrides = {
              reportUnusedVariable = 'warning',
              reportUndefinedVariable = 'error',
            },
          },
        },
      },
    },
    -- pyright = {},
    -- rust_analyzer = {},
    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
    --
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
    --
    -- But for many setups, the LSP (`ts_ls`) will work just fine
    ts_ls = {
      root_dir = function(bufnr, on_dir)
        bufnr = bufnr or 0
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local start_path = nil

        if fname == '' then
          -- unnamed buffer: start from cwd so at least workspace detection works
          start_path = vim.loop.cwd()
        else
          start_path = vim.fs.dirname(fname)
        end

        -- candidate tsconfigs (add more if you need)
        local ts_config_files = {
          'tsconfig.json',
          'tsconfig.app.json',
          'tsconfig.lib.json',
          'tsconfig.base.json',
          'tsconfig.spec.json',
          'jsconfig.json',
        }

        -- helpers
        local function found_dir_for(names, opts)
          opts = opts or {}
          opts.path = opts.path or start_path
          opts.upward = opts.upward == nil and true or opts.upward
          local found = vim.fs.find(names, opts)
          if found and found[1] then
            return vim.fs.dirname(found[1])
          end
          return nil
        end

        -- 1) nearest tsconfig-like file (package/app level)
        local ts_root = found_dir_for(ts_config_files)
        if ts_root and ts_root ~= '' then
          if on_dir then
            on_dir(ts_root)
          else
            return ts_root
          end
        end

        -- 2) nearest package.json (often indicates package root)
        local pkg_root = found_dir_for { 'package.json' }
        if pkg_root and pkg_root ~= '' then
          -- prefer package.json only if it is not the repo root with workspace config below
          if on_dir then
            on_dir(pkg_root)
          else
            return pkg_root
          end
        end

        -- 3) workspace manifests (angular/nx/workspace)
        local workspace_root = found_dir_for { 'angular.json', 'workspace.json', 'nx.json' }
        if workspace_root and workspace_root ~= '' then
          if on_dir then
            on_dir(workspace_root)
          else
            return workspace_root
          end
        end

        -- 4) lockfiles (workspace-level)
        local lockfiles = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb' }
        local lock_root = found_dir_for(lockfiles)
        if lock_root and lock_root ~= '' then
          if on_dir then
            on_dir(lock_root)
          else
            return lock_root
          end
        end

        -- 5) last resort: git root
        local git_root = found_dir_for { '.git' }
        if git_root and git_root ~= '' then
          if on_dir then
            on_dir(git_root)
          else
            return git_root
          end
        end

        -- nothing found
        return nil
      end,
    },
    -- angularls = {
    --   on_attach = function(client, bufnr)
    --     client.server_capabilities.renameProvider = false
    --     client.server_capabilities.definitionProvider = false
    --     client.server_capabilities.referencesProvider = false
    --     client.server_capabilities.implementationProvider = false
    --     client.server_capabilities.documentHighlightProvider = false
    --     client.server_capabilities.documentSymbolProvider = false
    --   end,
    -- },
    cssls = {},
    -- css_variables = {},
    -- html = {},

    lua_ls = {
      -- cmd = { ... },
      -- filetypes = { ... },
      -- capabilities = {},
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
  }

  -- Mason-lspconfig automatic enable
  require('mason-lspconfig').setup {
    automatic_enable = vim.tbl_keys(servers or {}),
  }

  -- Ensure installed (mason-tool-installer)
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, { 'stylua' })
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  -- Apply overrides to lspconfig servers
  for server_name, config in pairs(servers) do
    config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
    vim.lsp.config(server_name, config)
  end

  -- NOTE: Some servers may require an old setup until they are updated. For the full list refer here: https://github.com/neovim/nvim-lspconfig/issues/3705
  -- These servers will have to be manually set up with require("lspconfig").server_name.setup{}
  -- require('lspconfig').angularls.setup {}
end

return M
