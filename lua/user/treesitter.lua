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
        'blade',
        'css',
        'dart',
        'diff',
        'dockerfile',
        'fish',
        'gitignore',
        'html',
        'javascript',
        'jq',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'kdl',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'php',
        'powershell',
        'python',
        'regex',
        'scss',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
        'yaml',
      },
      matchup = {
        enable = true,
        enable_quotes = true,
        disable_virtual_text = true,
      },
    },
    config = function(_, opts)
      local configs = require('nvim-treesitter.configs')
      configs.setup(opts)
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'andymass/vim-matchup',
    lazy = false,
  },
}

return M
