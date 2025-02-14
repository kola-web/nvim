local M = {
  {
    'andrewferrier/debugprint.nvim',
    version = '*',
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
        keymaps = {
          normal = {
            plain_below = '',
            plain_above = '',
            variable_below = '<leader>dd',
            variable_above = '<leader>dD',
            variable_below_alwaysprompt = '',
            variable_above_alwaysprompt = '',
            textobj_below = '<leader>dw',
            textobj_above = '<leader>dW',
            toggle_comment_debug_prints = '<leader>d/',
            delete_debug_prints = '<leader>d?',
          },
          insert = {
            plain = '',
            variable = '',
          },
          visual = {
            variable_below = '<leader>dd',
            variable_above = '<leader>dD',
          },
        },
      }
    end,
  },
}

return M
