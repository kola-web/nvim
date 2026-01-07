local M = {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      { 'mason.nvim' },
      { 'neoconf.nvim' },
      { 'mason-lspconfig.nvim' },
      { 'b0o/schemastore.nvim' },
      'saghen/blink.cmp',
    },
    opts = {
      inlay_hints = {
        enabled = true,
        exclude = {}, -- filetypes for which you don't want to enable inlay hints
      },
      codelens = {
        enabled = false,
      },
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kola-lsp-attach', { clear = true }),
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          local diagnostic_goto = function(next, severity)
            return function()
              vim.diagnostic.jump({
                count = (next and 1 or -1) * vim.v.count1,
                severity = severity and vim.diagnostic.severity[severity] or nil,
                float = true,
              })
            end
          end

          local keymap = vim.keymap.set

          -- keymap('n', 'gd', vim.lsp.buf.definition, {desc='GoTo definition'})
          -- keymap('n', 'gr', vim.lsp.buf.references, {desc='GoTo references'})
          -- keymap('n', 'gI', vim.lsp.buf.implementation, {desc='GoTo implementation'})
          -- keymap('n', 'gy', vim.lsp.buf.type_definition, {desc='GoTo references'})
          -- keymap('n', 'gD', vim.lsp.buf.declaration, {desc='GoTo declaration'})
          keymap('n', 'gl', vim.diagnostic.open_float, { desc = 'Float diagnostic' })
          keymap('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code action' })
          keymap('n', '<leader>lc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
          keymap('n', '<leader>lC', vim.lsp.codelens.refresh, { desc = 'Refresh & Display Codelens' })
          keymap('n', '<leader>lR', function()
            Snacks.rename.rename_file()
          end, { desc = 'Refresh & Display Codelens' })
          keymap('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename' })
          keymap('n', '<leader>ld', '<cmd>lua vim.diagnostic.setloclist()<CR>', { desc = 'diagnostic' })
          keymap('n', '<leader>le', '<cmd>EslintFixAll<CR>', { desc = 'EslintFixAll' })
          keymap('n', '<leader>lo', function()
            vim.lsp.buf.code_action({ apply = true, context = { only = { 'source.organizeImports' } } })
          end, { desc = 'Organize Imports' })
          keymap('n', ']]', function()
            Snacks.words.jump(vim.v.count1)
          end, { desc = 'Next Reference' })
          keymap('n', '[[', function()
            Snacks.words.jump(-vim.v.count1)
          end, { desc = 'Prev Reference' })

          keymap('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
          keymap('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
          keymap('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
          keymap('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
          keymap('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
          keymap('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

          keymap('n', '<leader>L', '<cmd>LspRestart<cr>', { desc = 'lspRestart' })
        end,
      })

      local icons = require('utils.icons')
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        -- underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          current_line = true,
          virtual_lines = true,
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
      })

      local has_blink, blink = pcall(require, 'blink.cmp')
      local capabilities = vim.tbl_deep_extend('force', {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      }, vim.lsp.protocol.make_client_capabilities(), has_blink and blink.get_lsp_capabilities() or {}, opts.capabilities or {})

      vim.lsp.config('*', {
        capabilities = vim.deepcopy(capabilities),
        root_markers = { '.git' },
      })

      local emmet_language_server = require('neoconf').get('emmet_language_server') or {}
      vim.lsp.config('emmet_language_server', emmet_language_server)

      local is_vue2 = require('utils.init').is_vue2_project()
      local servers = require('utils.init').servers

      for _, server in pairs(servers) do
        local status = true
        if server == 'vue_ls' and is_vue2 then
          status = false
        end
        if server == 'vuels' and not is_vue2 then
          status = false
        end

        vim.lsp.enable(server, status)
      end
    end,
  },
  {
    'folke/neoconf.nvim',
    cmd = 'Neoconf',
    opts = {},
    keys = {
      { '<leader>ln', '<cmd>Neoconf<cr>', desc = 'Neoconf' },
    },
  },
  -- {
  --   'kola-web/css-tools.nvim',
  --   ft = { 'css', 'scss', 'less' },
  --   opts = {
  --     customData = {
  --       vim.fn.expand(vim.fn.stdpath('config') .. '/custom-data/css-data.json'),
  --     },
  --   },
  -- },
}

return M
