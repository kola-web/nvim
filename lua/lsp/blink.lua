local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local M = {
  -- add blink.compat
  {
    'saghen/blink.compat',
    version = '*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = '*',
    opts = {
      keymap = {
        preset = 'super-tab',
        --   ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<Tab>'] = {
          function(cmp)
            -- print(vim.inspect(cmp))
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
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      signature = { enabled = true },
      sources = {
        default = {
          -- 'path',
          'lsp',
          'snippets',
          'buffer',
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
  {
    'saghen/blink.cmp',
    opts = function(_, opts)
      opts.appearance = opts.appearance or {}
      opts.appearance.kind_icons = require('utils.icons').kinds
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'folke/lazydev.nvim',
    },
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { 'lazydev' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
          },
        },
      },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'mikavilpas/blink-ripgrep.nvim',
    },
    opts = {
      sources = {
        default = { 'ripgrep' },
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
        },
      },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'kola-web/cmp-path',
    },
    opts = {
      sources = {
        default = { 'cmp-path' },
        providers = {
          ['cmp-path'] = {
            name = 'path',
            module = 'blink.compat.source',
            score_offset = -3,
            opts = {
              pathMappings = {
                ['@'] = '${folder}/src',
                ['/'] = '${folder}/src/',
                -- ['~@'] = '${folder}/src',
                -- ['/images'] = '${folder}/src/images',
                -- ['/components'] = '${folder}/src/components',
              },
            },
          },
        },
      },
    },
  },
}

return M
