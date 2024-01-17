local M = {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
    opts = { style = 'moon', transparent = true },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- {
  --   priority = 1000,
  --   lazy = false,
  --   'sainnhe/gruvbox-material',
  --   config = function()
  --     vim.cmd([[colorscheme gruvbox-material]])
  --     vim.api.nvim_set_hl(0, 'NormalFloat', { fg = 'LightGrey' })
  --   end,
  -- },
  {
    'xiyaowong/transparent.nvim',
    cond = not vim.g.neovide,
    opts = {
      extra_groups = {},
      exclude_groups = {
        'CursorLine',
        'CursorLineNr',
      },
    },
    config = true,
  },
}

return M
