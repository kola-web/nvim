-- local colorscheme = 'tokyonight-night'
-- local colorscheme = 'catppuccin-mocha'
-- require 'user.colorscheme.catppuccin'
-- local colorscheme = "onedarker"
local colorscheme = 'github_*'
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  return
end
