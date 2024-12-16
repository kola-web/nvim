local M = {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'VeryLazy' },
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'dart',
        'diff',
        'dockerfile',
        'fish',
        'gitignore',
        'html',
        'javascript',
        'css',
        'scss',
        'jq',
        'json',
        'json5',
        'jsdoc',
        'jsonc',
        'kdl',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'php',
        'tsx',
        'vim',
        'vimdoc',
        'vue',
        'toml',
        'typescript',
        'yaml',
        'regex',
        'blade',
      }, -- put the language you want in this array
      -- ensure_installed = "all", -- one of "all" or a list of languages
      ignore_install = { '' }, -- List of parsers to ignore installing
      sync_install = false,
      auto_install = false,

      highlight = {
        enable = true, -- false will disable the whole extension
        -- disable = { 'html', 'vue' }, -- list of language that will be disabled
      },
      autopairs = {
        enable = true,
      },
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<cr>',
          node_incremental = '<cr>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    },
    config = function(_, opts)
      local configs = require('nvim-treesitter.configs')
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

      parser_config.blade = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = { 'src/parser.c' },
          branch = 'main',
        },
        filetype = 'blade',
      }

      configs.setup(opts)
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
  },
}

return M
