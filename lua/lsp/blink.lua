vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') },
  'https://github.com/kola-web/blink-alias-path',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/folke/lazydev.nvim',
})
local blink = require('blink.cmp')

blink.setup({
  keymap = {
    preset = 'none',
    ['<C-y>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<Tab>'] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      function(cmp)
        if not cmp.is_menu_visible() and require('utils.init').has_words_before() then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(emmet-expand-abbr)', true, false, true), 'n', true)
          return true
        else
          return false
        end
      end,
      'fallback',
    },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'snippet_backward', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'snippet_forward', 'fallback_to_mappings' },
    ['<C-b>'] = { 'scroll_signature_up', 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_signature_down', 'scroll_documentation_down', 'fallback' },
    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    accept = { auto_brackets = { enabled = false } },
    menu = {
      draw = {
        treesitter = { 'lsp' },
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              return kind_icon
            end,
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          },
          kind = {
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          },
        },
        columns = {
          { 'kind_icon' },
          { 'label', 'label_description', gap = 1 },
          { 'source_name' },
        },
      },
    },
    list = {
      selection = {
        auto_insert = false,
      },
    },
  },
  snippets = { preset = 'luasnip' },
  sources = {
    default = { 'lsp', 'aliasPath', 'snippets', 'buffer', 'lazydev' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
      path = {
        opts = {
          ignore_root_slash = true,
        },
      },
      aliasPath = {
        name = 'aliasPath',
        module = 'blink-alias-path',
        opts = {
          ignore_root_slash = false,
          path_mappings = {
            ['@'] = '${folder}/src',
            ['/'] = '${folder}/src/',
          },
        },
      },
      lsp = {
        fallbacks = {},
      },
    },
  },
  cmdline = {
    enabled = true,
  },
})

local luasnip_ok, luasnip = pcall(require, 'luasnip')
if luasnip_ok then
  luasnip.setup({
    history = true,
    delete_check_events = 'TextChanged',
  })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
end

local lazydev_ok, lazydev = pcall(require, 'lazydev')
if lazydev_ok then
  lazydev.setup({
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      { path = 'snacks.nvim', words = { 'Snacks' } },
      { path = 'mini.statusline', words = { 'MiniStatusline' } },
    },
  })
end
