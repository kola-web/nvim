local M = {
  'andrewferrier/debugprint.nvim',
  version = '*',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- Only needed for NeoVim 0.8
  },
  opts = function()
    return {
      filetypes = {
        javascript = {
          left = 'console.log("',
          right = '")',
          mid_var = '", ',
          right_var = ')',
        },
      },
    }
  end,
  keys = {
    {
      '<C-S-L>',
      function()
        return require('debugprint').debugprint({ variable = true })
      end,
      desc = 'debugprint: cursor',
      expr = true,
    },
  },
}

return M
