local M = {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'folke/neodev.nvim', opts = {} },
      {
        'folke/neoconf.nvim',
        opts = {
          import = {
            vscode = false, -- local .vscode/settings.json
            coc = false, -- global/local coc-settings.json
            nlsp = false, -- global/local nlsp-settings.nvim json settings
          },
        },
      },

      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      { 'SmiteshP/nvim-navic' },

      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },

      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'kola-web/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
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
    config = function()
      local lsp_zero = require('lsp-zero')
      local icons = require('user.nvim-dev-icons').icons
      local utils = require('utils')

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        -- lsp_zero.default_keymaps({ buffer = bufnr })

        -- diagnostic
        local diagnostic_goto = function(next, severity)
          local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
          severity = severity and vim.diagnostic.severity[severity] or nil
          return function()
            go({ severity = severity })
          end
        end

        local keymap = vim.keymap.set
        -- stylua: ignore start
        local function createKeymap(mode, key, cmd, desc)
            keymap(mode, key, cmd, { buffer=bufnr, noremap = true, silent = true, desc = desc })
        end

        createKeymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "GoTo definition")
        createKeymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "GoTo declaration")
        createKeymap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "GoTo type_definition")
        createKeymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
        createKeymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "GoTo implementation")
        createKeymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "GoTo references")
        createKeymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Float diagnostic")
        createKeymap("n", "]d", diagnostic_goto(true), "Next Diagnostic")
        createKeymap("n", "[d", diagnostic_goto(false), "Prev Diagnostic")
        createKeymap("n", "]e", diagnostic_goto(true, "ERROR"), "Next Error")
        createKeymap("n", "[e", diagnostic_goto(false, "ERROR"), "Prev Error")
        createKeymap("n", "]w", diagnostic_goto(true, "WARN"), "Next Warning")
        createKeymap("n", "[w", diagnostic_goto(false, "WARN"), "Prev Warning")
        createKeymap("n", "<leader>lI", "<cmd>LspInfo<cr>", "lspInfo")
        createKeymap("n", "<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", "Lsp incoming_calls")
        createKeymap("n", "<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", "Lsp outgoing_calls")
        createKeymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action")
        createKeymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename")
        createKeymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help")
        createKeymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Setloclist")
        createKeymap("n", "<leader>lm", "<cmd>EslintFixAll<CR>", "EslintFixAll")
        -- stylua: ignore end

        if client.server_capabilities.documentSymbolProvider then
          local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
          if filetype == 'vue' and client.name == 'tsserver' then
            return
          end
          require('nvim-navic').attach(client, bufnr)
          -- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        end
      end)

      lsp_zero.set_sign_icons({
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warning,
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Information,
      })

      require('mason').setup({
        ensure_installed = utils.null_servers,
      })

      require('mason-lspconfig').setup({
        ensure_installed = utils.servers,
        handlers = {
          function(server_name)
            local server_config = {
              capabilities = lsp_zero.get_capabilities(),
            }

            if server_name == 'emmet_language_server' then
              local neoConfig = require('neoconf').get(server_name) or {}
              server_config = vim.tbl_deep_extend('force', neoConfig, server_config) or {}
            end

            local require_ok, conf_opts = pcall(require, 'settings.' .. server_name)
            if require_ok then
              server_config = vim.tbl_deep_extend('force', conf_opts, server_config) or {}
            end

            require('lspconfig')[server_name].setup(server_config)
          end,
        },
      })

      local cmp = require('cmp')

      local luasnip = require('luasnip')
      local luasnip_from_vscode = require('luasnip.loaders.from_vscode')

      -- this is the function that loads the extra snippets
      -- from rafamadriz/friendly-snippets
      luasnip_from_vscode.lazy_load()
      luasnip_from_vscode.lazy_load({ paths = '~/.config/nvim/snippets' })

      unpack = unpack or table.unpack
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      local has_value = utils.has_value

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip', keyword_length = 2 },
          { name = 'nvim_lua' },
          { name = 'buffer', keyword_length = 3 },
          {
            name = 'path',
            option = {
              pathMappings = {
                ['@'] = '${folder}/src',
                -- ['/'] = '${folder}/src/public/',
                -- ['~@'] = '${folder}/src',
                -- ['/images'] = '${folder}/src/images',
                -- ['/components'] = '${folder}/src/components',
              },
            },
          },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
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
              local filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
              local valid_filetypes = { 'css', 'eruby', 'html', 'javascript', 'javascriptreact', 'less', 'sass', 'scss', 'pug', 'typescriptreact', 'vue', 'wxml', 'php', 'blade' } -- 添加你需要的文件类型
              if has_value(valid_filetypes, filetype) then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-y>,', true, true, true), 'i', true)
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
        formatting = lsp_zero.cmp_format({ details = true }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
      })
    end,
  },
}

return M
