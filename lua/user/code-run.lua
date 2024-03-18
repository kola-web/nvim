local M = {
  'michaelb/sniprun',
  branch = 'master',
  build = 'sh install.sh',
  opts = {
    display = { 'Terminal' },
    display_options = {
      terminal_scrollback = vim.o.scrollback, -- change terminal display scrollback lines
      terminal_line_number = true, -- whether show line number in terminal window
      terminal_signcolumn = true, -- whether show signcolumn in terminal window
      terminal_position = 'horizontal', --# or "horizontal", to open as horizontal split instead of vertical split
      terminal_width = 45, --# change the terminal display option width (if vertical)
      terminal_height = 20, --# change the terminal display option height (if horizontal)
    },
  },
}

return M
