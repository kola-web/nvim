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
    { 'hrsh7th/cmp-path' },
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

    bind('n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)
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
  require('mason-lspconfig').setup({
    ensure_installed = require('utils.init').servers,
    handlers = {
      -- lsp_zero.default_setup,
      function(server_name)
        local Opts = {
          -- on_init = function(client)
          --   local formatLsp = {
          --     efm = true,
          --   }
          --   if formatLsp[client.name] == nil then
          --     client.server_capabilities.documentFormattingProvider = false
          --     client.server_capabilities.documentRangeFormattingProvider = false
          --   end
          -- end,
        }
        local require_ok, conf_opts = pcall(require, 'settings.' .. server_name)
        if require_ok then
          Opts = vim.tbl_deep_extend('force', conf_opts, Opts)
        end
        require('lspconfig')[server_name].setup(Opts)
      end,
    },
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
    completion = {
      completeopt = 'menu,menuone,noselect',
      keyword_pattern = '\\k\\+',
      keyword_length = 2,
      get_trigger_characters = function(trigger_characters)
        return trigger_characters
      end,
      -- 自定义路径匹配函数，将别名替换为实际路径
      match = {
        base = function(_, completion_item)
          -- 这里添加你的路径别名映射，例如：
          local alias_map = {
            ['@'] = '/src',
            -- 添加其他别名映射，如果需要的话
          }
          local path = alias_map[completion_item.word] or completion_item.word
          return path
        end,
      },
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
