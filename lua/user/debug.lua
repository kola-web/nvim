vim.pack.add({
  'https://github.com/andrewferrier/debugprint.nvim',
})

local debugprint = require('debugprint')

local web = {
  left = 'console.log("',
  left_var = 'console.log("',
  right = '")',
  right_var = ')',
  mid_var = '", ',
}

-- Neovim 配置调试：print 打在 :messages 里不好找，用 vim.notify 直接弹通知
local lua = {
  left = 'vim.notify("',
  left_var = 'vim.notify("',
  right = '")',
  right_var = ')',
  mid_var = '", ',
}

debugprint.setup({
  highlight_lines = false,
  filetypes = {
    javascript = web,
    typescript = web,
    vue = web,
    lua = lua,
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
})
