local M = {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = function()
    ---@type snacks.Config
    return {
      bufdelete = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1 },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = { 2, 2 } },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 2 },
          { section = 'startup' },
        },
      },
      notifier = { enabled = true },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      lazygit = { enabled = true },
      git = { enabled = true },
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
