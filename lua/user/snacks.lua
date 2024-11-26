local M = {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = function()
    return {
      bufdelete = { enabled = true },
      dashboard = { enabled = true },
      notifier = { enabled = true },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      lazygit = { enabled = true },
      git = { enabled = true },
      words = { enabled = true },
      rename = { enabled = true },
    }
  end,
  keys = {
    {
      '<leader>c',
      function()
        Snacks.bufdelete()
      end,
      desc = 'buf del',
      mode = { 'n' },
    },
    {
      '<leader>bo',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'buf del other',
      mode = { 'n' },
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'lazygit',
      mode = { 'n' },
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'lazygit log file',
      mode = { 'n' },
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'git blame line',
      mode = { 'n' },
    },
  },
}
return M
