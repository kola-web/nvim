local M = {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        { 'b0o/schemastore.nvim' },
        { 'folke/neodev.nvim', config = true },
      },
    },
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        { 'hrsh7th/cmp-buffer' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'mattn/emmet-vim' },
        { 'dcampos/cmp-emmet-vim' },
        {
          'zbirenbaum/copilot.lua',
          opts = { suggestion = { enabled = false }, panel = { enabled = false } },
        },
        { 'zbirenbaum/copilot-cmp', config = true },
      },
    },
  },
}

M.config = function()
  local lsp_zero = require('lsp-zero')

  lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr, exclude = { '<F3>', '<F4>', '<F4>' } })

    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', "<cmd>lua require('trouble').toggle('lsp_references')<CR>", opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>M', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  end)

  -- see :help lsp-zero-guide:integrate-with-mason-nvim
  -- to learn how to use mason.nvim with lsp-zero
  require('mason').setup()
  require('mason-lspconfig').setup({
    automatic_installation = true,
    ensure_installed = require('utils.init').servers,
    handlers = {
      lsp_zero.default_setup,
      cssls = function()
        local opts = require('settings.cssls')
        require('lspconfig').cssls.setup(opts)
      end,
      emmet_language_server = function()
        local opts = require('settings.emmet_language_server')
        require('lspconfig').emmet_language_server.setup(opts)
      end,
      eslint = function()
        local opts = require('settings.eslint')
        require('lspconfig').eslint.setup(opts)
      end,
      jsonls = function()
        local opts = require('settings.jsonls')
        require('lspconfig').jsonls.setup(opts)
      end,
      lua_ls = function()
        local opts = require('settings.lua_ls')
        require('lspconfig').lua_ls.setup(opts)
      end,
      tsserver = function()
        local opts = require('settings.tsserver')
        require('lspconfig').volar.setup(opts)
      end,
      volar = function()
        local opts = require('settings.volar')
        require('lspconfig').volar.setup(opts)
      end,
      yamlls = function()
        local opts = require('settings.yamlls')
        require('lspconfig').yamlls.setup(opts)
      end,
    },
  })

  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()
  local cmp_format = require('lsp-zero').cmp_format()
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip/loaders/from_vscode').lazy_load({ paths = '~/.config/nvim/snippets' })

  cmp.setup({
    preselect = 'item',
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    sources = {
      {
        name = 'emmet_vim',
        option = {
          -- filetypes = {  },
        },
      },
      { name = 'copilot' },
      { name = 'path' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip', keyword_length = 2 },
      { name = 'buffer', keyword_length = 3 },
    },
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),

      ['<C-k>'] = cmp_action.luasnip_shift_supertab(),
      ['<C-j>'] = cmp_action.luasnip_supertab(),

      ['<tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.mapping.confirm({ select = true })()
        elseif has_words_before() then
          cmp.mapping.complete({
            config = {
              sources = {
                { name = 'emmet_vim' },
              },
            },
          })()

          if cmp.visible() then
            cmp.mapping.confirm({ select = true })()
          else
            fallback()
          end

          -- cmp.mapping.complete({
          --   config = {
          --     sources = {
          --       {
          --         name = 'nvim_lsp',
          --         entry_filter = function(entry)
          --           return entry.source:get_debug_name() == 'nvim_lsp:emmet_language_server'
          --         end,
          --       },
          --     },
          --   },
          -- })()
          -- cmp.mapping.confirm({ select = true })()
        else
          fallback()
        end
      end),

      ['<C-e>'] = cmp.mapping.complete(),

      ['<C-l>'] = cmp.mapping.complete({
        config = {
          sources = {
            -- Add Emmet from dcampos/cmp-emmet-vim
            { name = 'emmet_vim' },
          },
        },
      }),
    }),
  })
end

return M
