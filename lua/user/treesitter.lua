local M = {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require('lazy.core.loader').add_to_rtp(plugin)
      require('nvim-treesitter.query_predicates')
    end,
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    opts_extend = { 'ensure_installed' },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
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
      },
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
    keys = {
      { '<cr>', desc = 'Increment Selection' },
      { '<bs>', desc = 'Decrement Selection', mode = 'x' },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
}

return M
