local M = {
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip/loaders/from_vscode').lazy_load()
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
    config = function(_, opts)
      require('luasnip/loaders/from_vscode').lazy_load({ paths = '~/.config/nvim/snippets' })
      require('luasnip').setup(opts)
    end,
    keys = {},
  },
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      -- 'hrsh7th/cmp-nvim-lua',
      -- 'kola-web/cmp-path',
      'hrsh7th/cmp-path',
      {
        'zbirenbaum/copilot.lua',
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        },
        keys = {
          { '<C-Enter>', '<cmd>Copilot panel<cr>', mode = { 'n' } },
        },
        config = true,
      },
      { 'zbirenbaum/copilot-cmp', fix_pairs = true, config = true },

      {
        'mattn/emmet-vim',
        init = function()
          -- vim.g.user_emmet_leader_key = '<c-y>'
          vim.g.user_emmet_mode = 'i'
          vim.g.user_emmet_settings = {
            variables = {
              lang = 'zh',
            },
          }
        end,
      },
    },
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })

      unpack = unpack or table.unpack
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      local luasnip = require('luasnip')
      local cmp = require('cmp')
      local defaults = require('cmp.config.default')()

      local has_value = require('utils.init').has_value

      return {
        preselect = 'item',
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
          ['<tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.mapping.confirm({ select = true })()
            elseif has_words_before() then
              local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
              local valid_filetypes = { 'css', 'eruby', 'html', 'javascript', 'javascriptreact', 'less', 'sass', 'scss', 'pug', 'typescriptreact', 'vue', 'wxml', 'php', 'blade' } -- 添加你需要的文件类型
              if has_value(valid_filetypes, filetype) then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(emmet-expand-abbr)', true, true, true), 'i', true)
              else
                fallback()
              end
            else
              fallback()
            end
          end, { 'i' }),
          ['<C-j>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-k>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'copilot', group_index = 1, priority = 100 },
          { name = 'nvim_lsp' },
          -- { name = 'nvim_lua' },
          { name = 'luasnip' },
          {
            name = 'path',
            option = {
              -- pathMappings = {
              --   ['@'] = '${folder}/src',
              --   ['~@'] = '${folder}/src',
              --   ['/images'] = '${folder}/src/images',
              --   ['/components'] = '${folder}/src/components',
              -- },
            },
          },
          { name = 'buffer' },
        }),
        formatting = {
          fields = { 'abbr', 'menu', 'kind' },
          format = function(entry, item)
            local short_name = {
              nvim_lsp = 'LSP',
              nvim_lua = 'nvim',
            }

            local menu_name = short_name[entry.source.name] or entry.source.name

            item.menu = string.format('[%s]', menu_name)
            return item
          end,
        },
        experimental = {
          ghost_text = true,
        },
        sorting = defaults.sorting,
      }
    end,
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require('cmp').setup(opts)
    end,
  },
}

return M
