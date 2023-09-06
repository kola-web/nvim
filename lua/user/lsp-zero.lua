local M = {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' }, -- Required
    { 'williamboman/mason.nvim' }, -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    {
      'simrat39/symbols-outline.nvim',
      config = function()
        require('symbols-outline').setup({})
      end,
    },
    { 'zbirenbaum/copilot.lua' },
    { 'zbirenbaum/copilot-cmp' },
    { 'b0o/schemastore.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' }, -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' }, -- Required
    { 'rafamadriz/friendly-snippets' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- format
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'creativenull/efmls-configs-nvim' },
  },
}

M.config = function()
  local lsp = require('lsp-zero').preset({})
  local icons = require('icons')
  local formatLsp = {
    efm = true,
    taplo = true,
  }

  lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({
      buffer = bufnr,
      omit = { '<F2>', '<F3>', '<F4>' },
      preserve_mappings = false,
    })
  end)
  lsp.set_sign_icons({
    error = icons.diagnostics.Error,
    warn = icons.diagnostics.Warn,
    hint = icons.diagnostics.Hint,
    info = icons.diagnostics.Info,
  })
  lsp.ensure_installed(require('utils.init').servers)
  lsp.setup_servers(require('utils.init').servers)
  require('mason-lspconfig').setup_handlers({
    function(server_name)
      local Opts = {
        on_init = function(client)
          if formatLsp[client.name] == nil then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end,
      }
      local require_ok, conf_opts = pcall(require, 'settings.' .. server_name)
      if require_ok then
        Opts = vim.tbl_deep_extend('force', conf_opts, Opts)
      end
      require('lspconfig')[server_name].setup(Opts)
    end,
  })
  lsp.setup()

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
      { name = 'copilot' },
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'buffer' },
      { name = 'path' },
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
        local icons = require('icons').kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
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

  ----- null-ls ------------------------------------------------------------------------------------

  -- See mason-null-ls.nvim's documentation for more details:
  -- https://github.com/jay-babu/mason-null-ls.nvim#setup
  require('mason-tool-installer').setup({
    ensure_installed = require('utils.init').null_servers,
    automatic_installation = true,
    run_on_start = false,
  })
end

return M
