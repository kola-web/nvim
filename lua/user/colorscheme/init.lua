-- local colorscheme = 'tokyonight-night'
-- local colorscheme = 'catppuccin-mocha'
-- require 'user.colorscheme.catppuccin-rc'
-- local colorscheme = 'gruvbox'
local colorscheme = 'gruvbox-material'
-- local colorscheme = 'dracula'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  return
end
