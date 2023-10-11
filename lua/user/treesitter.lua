local M = {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPost',
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      event = 'VeryLazy',
    },
    {
      'nvim-tree/nvim-web-devicons',
      event = 'VeryLazy',
    },
  },
}
function M.config()
  local treesitter = require('nvim-treesitter')
  local configs = require('nvim-treesitter.configs')

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
      'php',
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
    indent = { enable = true, disable = { 'python', 'css' } },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
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
