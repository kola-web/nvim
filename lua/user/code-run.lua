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
  },
}

return M
