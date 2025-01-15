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
      '<leader>dd',
      function()
        return require('debugprint').debugprint({ above = false, variable = true, ignore_treesitter = false })
      end,
      desc = 'debugprint: cursor',
      expr = true,
      mode = { 'n' },
    },
    {
      '<leader>dd',
      function()
        return require('debugprint').debugprint({ above = false, variable = true, ignore_treesitter = true })
      end,
      desc = 'debugprint: cursor',
      expr = true,
      mode = { 'v' },
    },
  },
}

return M
