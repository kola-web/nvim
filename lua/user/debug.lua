local M = {
  'andrewferrier/debugprint.nvim',
  version = '*',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- Only needed for NeoVim 0.8
  },
  opts = function()
    local web = {
      left = 'console.log("',
      right = '")',
      mid_var = '", ',
      right_var = ')',
    }
    return {
      filetypes = {
        javascript = web,
        typescript = web,
        vue = web,
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
