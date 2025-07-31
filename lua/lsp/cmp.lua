local M = {
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    enabled = false,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'kola-web/cmp-path',
    },
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
      unpack = unpack or table.unpack

      local luasnip = require('luasnip')
      local cmp = require('cmp')
      local defaults = require('cmp.config.default')()

      local has_value = require('utils.init').has_value

      return {
        preselect = cmp.PreselectMode.Item,
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = function(fallback)
            local opts = {
              select = true,
              behavior = cmp.ConfirmBehavior.Insert,
            }
            if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
              require('utils.init').create_undo()
              if cmp.confirm(opts) then
                return
              end
            elseif require('utils.init').has_words_before() then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(emmet-expand-abbr)', true, true, true), 'i', true)
              return
            end
            return fallback()
          end,
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        }),
        sources = cmp.config.sources({
          { name = 'lazydev' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          {
            name = 'path',
            option = {
              path_mappings = {
                ['@'] = '${folder}/src',
                ['/'] = '${folder}/src/',
                -- ['~@'] = '${folder}/src',
                -- ['/images'] = '${folder}/src/images',
                -- ['/components'] = '${folder}/src/components',
              },
            },
          },
        }),
        formatting = {
          format = function(entry, item)
            local icons = require('utils.icons').kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end

            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. '…'
              end
            end

            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText',
          },
        },
        sorting = defaults.sorting,
      }
    end,
    config = function(_, opts)
      require('cmp').setup(opts)
    end,
  },
  -- {
  --   'L3MON4D3/LuaSnip',
  --   lazy = true,
  --   build = 'make install_jsregexp',
  --   enabled = false,
  --   dependencies = {
  --     {
  --       'rafamadriz/friendly-snippets',
  --       config = function()
  --         require('luasnip.loaders.from_vscode').lazy_load()
  --         require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
  --       end,
  --     },
  --   },
  --   opts = {
  --     history = true,
  --     delete_check_events = 'TextChanged',
  --   },
  -- },
}
return M
