local M = {
  'gbprod/substitute.nvim',
  opts = {
    on_substitute = nil,
    yank_substituted_text = false,
    range = {
      prefix = 's',
      prompt_current_text = false,
      confirm = false,
      complete_word = false,
      motion1 = false,
      motion2 = false,
      suffix = '',
    },
  },
  keys = {
    {
      's',
      "<cmd>lua require('substitute').operator()<cr>",
      desc = 'substitute operator',
    },
    {
      'ss',
      "<cmd>lua require('substitute').line()<cr>",
      desc = 'substitute line',
    },
    {
      'S',
      "<cmd>lua require('substitute').eol()<cr>",
      desc = 'substitute eol',
    },
    {
      mode = { 'x' },
      's',
      "<cmd>lua require('substitute').visual()<cr>",
      desc = 'substitute visual',
    },

    {
      'sx',
      "<cmd>lua require('substitute.exchange').operator()<cr>",
      desc = 'substitute exchange operator',
    },
    {
      'sxx',
      "<cmd>lua require('substitute.exchange').line()<cr>",
      desc = 'substitute exchange line',
    },
    {
      mode = { 'x' },
      'X',
      "<cmd>lua require('substitute.exchange').visual()<cr>",
      desc = 'substitute exchange line',
    },
    {
      'sxc',
      "<cmd>lua require('substitute.exchange').cancel()<cr>",
      desc = 'substitute exchange cancel',
    },
  },
}

return M
