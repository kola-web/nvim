-- local colorscheme = "gruvbox-material"
local colorscheme = "everforest"
-- local colorscheme = "tokyonight"
vim.g.everforest_background = "hard"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
