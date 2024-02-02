local M = {
  'nvim-treesitter/nvim-treesitter',
  version = false, -- last release is way too old and doesn't work on Windows
  build = ':TSUpdate',
  event = { 'VeryLazy' },
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    require('lazy.core.loader').add_to_rtp(plugin)
    require('nvim-treesitter.query_predicates')
  end,
  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
      event = 'VeryLazy',
    },
    {
      'windwp/nvim-ts-autotag',
    },
  },
}
function M.config()
  local treesitter = require('nvim-treesitter')
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

  configs.setup({
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
      'tsx',
      'yaml',
      'regex',
    }, -- put the language you want in this array
    -- ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { '' }, -- List of parsers to ignore installing
    sync_install = true,
    auto_install = true,

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {}, -- list of language that will be disabled
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
  })
end

return M
