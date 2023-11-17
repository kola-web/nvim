local M = {
  {
    'L3MON4D3/LuaSnip',
    build = (not jit.os:find('Windows'))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        local formVscode = require('luasnip/loaders/from_vscode')
        formVscode.lazy_load()
        formVscode.lazy_load({ paths = '~/.config/nvim/snippets' })
      end,
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'kola-web/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      {
        'zbirenbaum/copilot.lua',
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        },
        config = true,
      },
      { 'zbirenbaum/copilot-cmp', fix_pairs = true, config = true },
    },
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
      local cmp = require('cmp')
      local icons = require('user.nvim-dev-icons')
      local defaults = require('cmp.config.default')()
      return {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ['<tab>'] = cmp.mapping.confirm({ select = true }),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
        }),
        sources = cmp.config.sources({
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'luasnip' },
          { name = 'buffer' },
          {
            name = 'path',
            option = {
              pathMappings = {
                ['@'] = {
                  '${folder}/src',
                  '${folder}/miniprogram',
                },
                ['~@'] = '${folder}/src',
                ['@renderer'] = '${folder}/src/renderer/src',
              },
            },
          },
        }),
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            vim_item.kind = icons.icons.kinds[vim_item.kind]
            vim_item.menu = ({
              nvim_lsp = '',
              nvim_lua = '',
              luasnip = '',
              buffer = '',
              path = '',
              emoji = '',
            })[entry.source.name]
            return vim_item
          end,
        },
        experimental = {
          ghost_text = true,
        },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require('cmp').setup(opts)
    end,
  },
}

return M
