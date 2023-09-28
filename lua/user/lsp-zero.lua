local M = {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',

  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' }, -- Required
    { 'williamboman/mason.nvim' }, -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    { 'zbirenbaum/copilot.lua' },
    { 'zbirenbaum/copilot-cmp' },
    { 'b0o/schemastore.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' }, -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' }, -- Required
    { 'rafamadriz/friendly-snippets' },
    { 'kola-web/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- format
    -- { 'creativenull/efmls-configs-nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'stevearc/conform.nvim' },
  },
}

M.config = function()
  local lsp_zero = require('lsp-zero')
  local icons = require('icons')

  lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({
      buffer = bufnr,
      exclude = { '<F2>', '<F3>', '<F4>' },
      preserve_mappings = false,
    })
    local opts = { buffer = bufnr }
    local bind = vim.keymap.set

    -- bind('n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)
    bind('n', 'gr', '<cmd>Lspsaga finder<cr>', opts)
    bind('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', opts)
    bind('n', 'gD', '<cmd>Lspsaga peek_definition<cr>', opts)
    bind('n', 'go', '<cmd>Lspsaga goto_type_definition<cr>', opts)
    bind('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<cr>', opts)
    bind('n', '<leader>m', function()
      require('conform').format({ bufnr = bufnr, lsp_fallback = true })
    end, opts)
  end)
  lsp_zero.set_sign_icons({
    error = icons.diagnostics.Error,
    warn = icons.diagnostics.Warn,
    hint = icons.diagnostics.Hint,
    info = icons.diagnostics.Info,
  })
  lsp_zero.set_server_config({
    capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
  })
  require('mason').setup({})
  local handlers_config = {
    lsp_zero.default_setup,
  }
  local servers = require('utils.init').servers
  for _, server_name in ipairs(servers) do
    local require_ok, conf_opts = pcall(require, 'settings.' .. server_name)
    if require_ok then
      handlers_config[server_name] = function()
        require('lspconfig')[server_name].setup(conf_opts)
      end
    end
  end
  require('mason-lspconfig').setup({
    ensure_installed = servers,
    handlers = handlers_config,
  })

  ----- cmp ------------------------------------------------------------------------------------
  local cmp = require('cmp')
  require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
  require('copilot_cmp').setup()

  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({ paths = '~/.config/nvim/snippets' })

  cmp.setup({
    sources = {
      {
        name = 'copilot',
        trigger_characters = {
          {
            '.',
            ':',
            '(',
            "'",
            '"',
            '[',
            ',',
            '#',
            '*',
            '@',
            '|',
            '=',
            '-',
            '{',
            '/',
            '\\',
            '+',
            '?',
            ' ',
            -- "\t",
            -- "\n",
          },
        },
      },
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'nvim_lua' },
      { name = 'buffer' },
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-g>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-e>'] = cmp.mapping(function(fallback)
        fallback()
      end),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    }),
    formatting = {
      fields = { 'abbr', 'menu', 'kind' },
      format = function(entry, item)
        local kinds = icons.kinds
        if kinds[item.kind] then
          item.kind = kinds[item.kind] .. item.kind
        end
        local short_name = {
          nvim_lsp = 'LSP',
          nvim_lua = 'nvim',
        }

        local menu_name = short_name[entry.source.name] or entry.source.name

        item.menu = string.format('[%s]', menu_name)
        return item
      end,
    },
  })

  ----- format ------------------------------------------------------------------------------------

  require('mason-tool-installer').setup({
    ensure_installed = require('utils.init').null_servers,
    automatic_installation = true,
    run_on_start = false,
  })
  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      -- python = { 'isort', 'black' },
      -- Use a sub-list to run only the first available formatter
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      html = { { 'prettierd', 'prettier' } },
      vue = { { 'prettierd', 'prettier' } },
      css = { { 'prettierd', 'prettier' } },
      scss = { { 'prettierd', 'prettier' } },
      wxss = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      yaml = { { 'prettierd', 'prettier' } },

      sh = { 'shfmt', 'shellcheck' },

      toml = { 'taplo' },
    },
  })
end

return M
