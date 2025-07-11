local M = {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      { 'folke/neoconf.nvim', cmd = 'Neoconf', opts = {} },
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
      -- local icons = require('utils.icons')
      local lspconfig = require('lspconfig')

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
        flags = { allow_incremental_sync = false },
      })

      local emmet_language_server = require('neoconf').get('emmet_language_server') or {}
      vim.lsp.config('emmet_language_server', emmet_language_server)

      local neoConfig = require('neoconf').get('emmet_language_server') or {}

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client and client.name == 'eslint' then
            client.server_capabilities.documentFormattingProvider = true
          end

          local diagnostic_goto = function(next, severity)
            local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
            severity = severity and vim.diagnostic.severity[severity] or nil
            return function()
              go({ severity = severity })
            end
          end

          local keymap = vim.keymap.set
          local function createKeymap(mode, key, cmd, desc)
            keymap(mode, key, cmd, { buffer = buffer, noremap = true, silent = true, desc = desc })
          end

          createKeymap('n', 'gd', '<cmd>Trouble lsp_definitions<CR>', 'GoTo definition')
          createKeymap('n', 'grr', '<cmd>Trouble lsp_references<CR>', 'GoTo references')
          createKeymap('n', 'gri', '<cmd>Trouble lsp_implementations<CRq', 'GoTo implementation')
          createKeymap('n', 'gy', '<cmd>Trouble lsp_type_definitions<CR>', 'GoTo references')
          createKeymap('n', 'gD', '<cmd>Trouble lsp_declarations<CR>', 'GoTo declaration')
          createKeymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', 'Float diagnostic')
          createKeymap('n', ']d', diagnostic_goto(true), 'Next Diagnostic')
          createKeymap('n', '[d', diagnostic_goto(false), 'Prev Diagnostic')
          createKeymap('n', ']e', diagnostic_goto(true, 'ERROR'), 'Next Error')
          createKeymap('n', '[e', diagnostic_goto(false, 'ERROR'), 'Prev Error')
          createKeymap('n', ']w', diagnostic_goto(true, 'WARN'), 'Next Warning')
          createKeymap('n', '[w', diagnostic_goto(false, 'WARN'), 'Prev Warning')
          createKeymap('n', ']]', function()
            Snacks.words.jump(vim.v.count1)
          end, 'Next Reference')
          createKeymap('n', '[[', function()
            Snacks.words.jump(-vim.v.count1)
          end, 'Prev Reference')
          createKeymap('n', '<leader>lI', '<cmd>LspInfo<cr>', 'lspInfo')
          createKeymap('n', '<leader>li', '<cmd>Trouble lsp_incoming_calls<cr>', 'Lsp incoming_calls')
          createKeymap('n', '<leader>lo', '<cmd>Trouble lsp_outgoing_calls<cr>', 'Lsp outgoing_calls')
          createKeymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')
          createKeymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename')
          createKeymap('n', '<leader>ld', '<cmd>lua vim.diagnostic.setloclist()<CR>', 'Setloclist')
          createKeymap('n', '<leader>lm', '<cmd>EslintFixAll<CR>', 'EslintFixAll')
          createKeymap('n', 'gK', function()
            local new_config = not vim.diagnostic.config().virtual_lines
            vim.diagnostic.config({ virtual_lines = new_config })
          end, 'Toggle diagnostic virtual_lines')
        end,
      })
    end,
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    init = function()
      vim.diagnostic.config({ virtual_text = false })
    end,
    opts = {
      preset = 'classic',
      signs = {
        left = '',
        right = '',
        diag = '●',
        arrow = '    ',
        up_arrow = '    ',
        vertical = ' │',
        vertical_end = ' └',
      },
      multilines = true,
    },
  },
}

return M
