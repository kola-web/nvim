local M = {
  {
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
      indent = {enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true }, -- we set this in options.lua
      scroll = {enabled = false },
      words = { enabled = true },
      scratch = {
        win_by_ft = {
          typescript = {
            keys = {
              ['source'] = {
                '<cr>',
                function(self)
                  local command = { 'node', vim.api.nvim_buf_get_name(self.buf) }
                  local result = vim.system(command, { text = true }):wait()
                  Snacks.notify.info(result.stdout)
                end,
                desc = 'Source buffer',
                mode = { 'n', 'x' },
              },
            },
          },
          javascript = {
            keys = {
              ['source'] = {
                '<cr>',
                function(self)
                  local command = { 'node', vim.api.nvim_buf_get_name(self.buf) }
                  local result = vim.system(command, { text = true }):wait()
                  Snacks.notify.info(result.stdout)
                end,
                desc = 'Source buffer',
                mode = { 'n', 'x' },
              },
            },
          },
        },
      },
    },
    keys = {
      -- stylua: ignore start
      { '<leader>z',  function() Snacks.zen() end,                     desc = 'zen modal',        mode = { 'n' }},
      { '<leader>Z',  function() Snacks.zen.zoom() end,                desc = 'Toggle Zoom' },
      { '<leader>c',  function() Snacks.bufdelete() end,               desc = 'buf del',          mode = { 'n' }},
      {'<leader>bo',  function() Snacks.bufdelete.other() end,         desc = 'buf del other',    mode = { 'n' }},
      {'<leader>gg',  function() Snacks.lazygit() end,                 desc = 'lazygit',          mode = { 'n' }},
      {'<leader>gl',  function() Snacks.lazygit.log() end,             desc = 'lazygit log file', mode = { 'n' }},
      { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
      {'<leader>gb',  function() Snacks.git.blame_line() end,          desc = 'git blame line',   mode = { 'n' }},
      { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
      { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
      { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
      { "<C-\\>",     function() Snacks.terminal() end,                desc = "Toggle Terminal" },
      {']]',          function() Snacks.words.jump(vim.v.count1) end,  desc = 'Next Reference',   mode = { 'n', 't' }},
      {'[[',          function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference',   mode = { 'n', 't' }},
      -- stylua: ignore end
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
          Snacks.toggle.diagnostics():map('<leader>ud')
          Snacks.toggle.line_number():map('<leader>ul')
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<leader>uc')
          Snacks.toggle.treesitter():map('<leader>uT')
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
          Snacks.toggle.inlay_hints():map('<leader>uh')
          Snacks.toggle.indent():map('<leader>ug')
          Snacks.toggle.dim():map('<leader>uD')
        end,
      })
    end,
  },
}

return M
