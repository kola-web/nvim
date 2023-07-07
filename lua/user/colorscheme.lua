local M = {
  -- "folke/tokyonight.nvim",
  -- "projekt0n/github-nvim-theme",
  "sainnhe/gruvbox-material",
  -- "Mofiqul/dracula.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

M.name = "gruvbox-material"
-- M.name = "dracula"
function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
