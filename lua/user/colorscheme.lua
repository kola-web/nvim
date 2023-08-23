local M = {
  -- light
  -- "shaunsingh/solarized.nvim",

  --dark
  -- "folke/tokyonight.nvim",
  -- "projekt0n/github-nvim-theme",
  "sainnhe/gruvbox-material",
  -- "Mofiqul/dracula.nvim",
  -- "catppuccin/nvim",
  -- "rebelot/kanagawa.nvim",
  -- "EdenEast/nightfox.nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

-- light
-- M.name = "solarized"
-- vim.o.background = "light"

-- dark
vim.o.background = "dark"
-- M.name = "catppuccin-frappe"
-- M.name = "github_dark_dimmed"
M.name = "gruvbox-material"
-- M.name = "dracula"
-- M.name = "highlite"
-- M.name = "Nightfox"
-- M.name = "kanagawa"
function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
