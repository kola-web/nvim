-- local colorscheme = "tokyonight-night"
-- local colorscheme = " github_*"
local colorscheme = "dracula"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
