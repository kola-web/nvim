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
  },
}
function M.config()
  local treesitter = require('nvim-treesitter')
  local configs = require('nvim-treesitter.configs')

  ---@diagnostic disable-next-line: missing-fields
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
      'phpdoc',
      'tsx',
      'vim',
      'vue',
      'toml',
      'typescript',
      'tsx',
      'yaml',
      'regex',
    }, -- put the language you want in this array
    -- ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { '' }, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {}, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
  })
end

return M
