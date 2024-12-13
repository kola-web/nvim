local M = {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bufdelete = { enabled = true },
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
    notifier = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    lazygit = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    git = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true },
    rename = { enabled = true },
    statuscolumn = { enabled = true }, -- we set this in options.lua
    zen = { enabled = true },
  },
  keys = {
    -- stylua: ignore start
    { '<leader>c', function() Snacks.bufdelete() end, desc = 'buf del', mode = { 'n' }},
    {'<leader>bo', function() Snacks.bufdelete.other() end, desc = 'buf del other', mode = { 'n' }},
    {'<leader>gg', function() Snacks.lazygit() end, desc = 'lazygit', mode = { 'n' }},
    {'<leader>gl', function() Snacks.lazygit.log() end, desc = 'lazygit log file', mode = { 'n' }},
    {'<leader>gb', function() Snacks.git.blame_line() end, desc = 'git blame line', mode = { 'n' }},
    {'<leader>z', function() Snacks.zen() end, desc = 'zen modal', mode = { 'n' }},
    {']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' }},
    {'[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' }},
    -- stylua: ignore end
  },
}
return M
