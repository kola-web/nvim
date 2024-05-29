local M = {
  'Bekaboo/dropbar.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    {
      '<C-;>',
      function()
        require('dropbar.api').pick()
      end,
      desc = 'color convert',
    },
  },
  opts = {
    general = {
      enable = function(buf, win, _)
        return vim.fn.win_gettype(win) == ''
          and vim.wo[win].winbar == ''
          and vim.bo[buf].bt == ''
          and (vim.bo[buf].ft == 'markdown' or (buf and vim.api.nvim_buf_is_valid(buf) and (pcall(vim.treesitter.get_parser, buf, vim.bo[buf].ft)) and true or false))
      end,
    },
  },
  config = function()
    vim.cmd([[highlight Winbar gui=none]])
  end,
}

return M
