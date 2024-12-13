local M = {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        -- stylua: ignore start
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- stylua: ignore end
      },
    },
    git = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
    statuscolumn = { enabled = true }, -- we set this in options.lua
  },
  keys = {
    -- stylua: ignore start
    { '<leader>c', function() Snacks.bufdelete() end,               desc = 'buf del',          mode = { 'n' }},
    {'<leader>bo', function() Snacks.bufdelete.other() end,         desc = 'buf del other',    mode = { 'n' }},
    {'<leader>gg', function() Snacks.lazygit() end,                 desc = 'lazygit',          mode = { 'n' }},
    {'<leader>gl', function() Snacks.lazygit.log() end,             desc = 'lazygit log file', mode = { 'n' }},
    {'<leader>gb', function() Snacks.git.blame_line() end,          desc = 'git blame line',   mode = { 'n' }},
    {'<leader>z',  function() Snacks.zen() end,                     desc = 'zen modal',        mode = { 'n' }},
    { "<C-\\>",    function() Snacks.terminal() end,                desc = "Toggle Terminal" },
    {']]',         function() Snacks.words.jump(vim.v.count1) end,  desc = 'Next Reference',   mode = { 'n', 't' }},
    {'[[',         function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference',   mode = { 'n', 't' }},
    -- stylua: ignore end
  },
}
return M
