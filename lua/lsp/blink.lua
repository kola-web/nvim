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
        -- add lazydev to your completion providers
        default = { 'ripgrep' },
        providers = {
          -- 👇🏻👇🏻 add the ripgrep provider config below
          ripgrep = {
            module = 'blink-ripgrep',
            name = 'Ripgrep',
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              -- For many options, see `rg --help` for an exact description of
              -- the values that ripgrep expects.

              -- the minimum length of the current word to start searching
              -- (if the word is shorter than this, the search will not start)
              prefix_min_len = 3,

              -- The number of lines to show around each match in the preview
              -- (documentation) window. For example, 5 means to show 5 lines
              -- before, then the match, and another 5 lines after the match.
              context_size = 5,

              -- The maximum file size of a file that ripgrep should include in
              -- its search. Useful when your project contains large files that
              -- might cause performance issues.
              -- Examples:
              -- "1024" (bytes by default), "200K", "1M", "1G", which will
              -- exclude files larger than that size.
              max_filesize = '1M',

              -- (advanced) Any additional options you want to give to ripgrep.
              -- See `rg -h` for a list of all available options. Might be
              -- helpful in adjusting performance in specific situations.
              -- If you have an idea for a default, please open an issue!
              --
              -- Not everything will work (obviously).
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
        -- add lazydev to your completion providers
        default = { 'cmp-path' },
        providers = {
          -- create provider
          ['cmp-path'] = {
            name = 'path', -- IMPORTANT: use the same name as you would for nvim-cmp
            module = 'blink.compat.source',

            -- all blink.cmp source config options work as normal:
            score_offset = -3,

            -- this table is passed directly to the proxied completion source
            -- as the `option` field in nvim-cmp's source config
            --
            -- this is NOT the same as the opts in a plugin's lazy.nvim spec
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
