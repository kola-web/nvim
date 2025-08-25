local M = {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      { 'mason.nvim' },
      { 'neoconf.nvim' },
      { 'mason-lspconfig.nvim' },
      { 'b0o/schemastore.nvim' },
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
            local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
            severity = severity and vim.diagnostic.severity[severity] or nil
            return function()
              go({ severity = severity })
            end
          end

          local keymap = vim.keymap.set
          local function map(mode, key, cmd, desc)
            keymap(mode, key, cmd, { buffer = buffer, noremap = true, silent = true, desc = desc })
          end

          -- map('n', 'gd', vim.lsp.buf.definition, 'GoTo definition')
          -- map('n', 'gr', vim.lsp.buf.references, 'GoTo references')
          -- map('n', 'gI', vim.lsp.buf.implementation, 'GoTo implementation')
          -- map('n', 'gy', vim.lsp.buf.type_definition, 'GoTo references')
          -- map('n', 'gD', vim.lsp.buf.declaration, 'GoTo declaration')
          map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', 'Float diagnostic')
          map('n', '<leader>la', vim.lsp.buf.code_action, 'Code action')
          map('n', '<leader>lc', vim.lsp.codelens.run, 'Run Codelens')
          map('n', '<leader>lC', vim.lsp.codelens.refresh, 'Refresh & Display Codelens')
          map('n', '<leader>lR', function()
            Snacks.rename.rename_file()
          end, 'Refresh & Display Codelens')
          map('n', '<leader>lr', vim.lsp.buf.rename, 'Rename')
          map('n', '<leader>ld', '<cmd>lua vim.diagnostic.setloclist()<CR>', 'diagnostic')
          map('n', '<leader>le', '<cmd>EslintFixAll<CR>', 'EslintFixAll')
          map('n', ']]', function()
            Snacks.words.jump(vim.v.count1)
          end, 'Next Reference')
          map('n', '[[', function()
            Snacks.words.jump(-vim.v.count1)
          end, 'Prev Reference')

          map('n', ']d', diagnostic_goto(true), 'Next Diagnostic')
          map('n', '[d', diagnostic_goto(false), 'Prev Diagnostic')
          map('n', ']e', diagnostic_goto(true, 'ERROR'), 'Next Error')
          map('n', '[e', diagnostic_goto(false, 'ERROR'), 'Prev Error')
          map('n', ']w', diagnostic_goto(true, 'WARN'), 'Next Warning')
          map('n', '[w', diagnostic_goto(false, 'WARN'), 'Prev Warning')

          map('n', '<leader>L', '<cmd>LspRestart<cr>', 'lspRestart')
        end,
      })

      local icons = require('utils.icons')
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
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

      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      local has_blink, blink = pcall(require, 'blink.cmp')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

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

        if status then
          vim.lsp.enable(server)
        end
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
}

return M
