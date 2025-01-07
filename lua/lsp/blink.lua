local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local M = {
  {
    'saghen/blink.cmp',
    lazy = false,
    enabled = false,
    dependencies = {
      'rafamadriz/friendly-snippets',

      'mikavilpas/blink-ripgrep.nvim',
      'folke/lazydev.nvim',
    },
    version = '*',
    opts = {
      keymap = {
        preset = 'super-tab',
        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          function()
            if has_words_before() then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(emmet-expand-abbr)', true, true, true), 'i', true)
              return 'fallback'
            end
          end,
          'snippet_forward',
          'fallback',
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
        kind_icons = require('utils.icons').kinds,
      },
      sources = {
        default = {
          'path',
          'lsp',
          'snippets',
          'buffer',
          'ripgrep',
          'lazydev',
        },
        providers = {
          ripgrep = {
            module = 'blink-ripgrep',
            name = 'Ripgrep',
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              prefix_min_len = 3,
              context_size = 5,
              max_filesize = '1M',
              additional_rg_options = {},
            },
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}

return M
