local M = {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets', 'kola-web/blink-alias-path' },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
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

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 200 },
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
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
              kind = {
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
        list = {
          selection = {
            auto_insert = false,
          },
        },
      },
      sources = {
        default = { 'lsp', 'aliasPath', 'snippets', 'buffer', 'lazydev' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100, -- show at a higher priority than lsp
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
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}

return M
