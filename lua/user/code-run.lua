local M = {
  {
    'michaelb/sniprun',
    build = 'bash install.sh',
    opts = {
      display = { 'Terminal' },
      live_display = { 'VirtualTextOk', 'TerminalOk' },
      display_options = {
        terminal_position = 'horizontal',
      },
    },
    keys = {
      {
        '<leader>ia',
        function()
          require('sniprun.api').run_range(1, vim.fn.line('$'))
        end,
        desc = 'sniprun all',
      },
      {
        '<leader>ic',
        function()
          require('sniprun.display').close_all()
        end,
        desc = 'sniprun close',
      },
      {
        '<leader>ic',
        function()
          require('sniprun').run()
        end,
        desc = 'sniprun to cursor',
      },
      {
        '<leader>id',
        function()
          require('sniprun').info()
        end,
        desc = 'sniprun info',
      },
      {
        '<leader>il',
        function()
          require('sniprun.live_mode').toggle()
        end,
        desc = 'sniprun live mode',
      },
      {
        '<leader>ir',
        function()
          require('sniprun').reset()
        end,
        desc = 'sniprun reset',
      },
    },
  },
}

return M
