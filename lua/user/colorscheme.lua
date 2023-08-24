local M = {
  -- light
  -- "shaunsingh/solarized.nvim",

  --dark
  -- "folke/tokyonight.nvim",
  -- "projekt0n/github-nvim-theme",
  -- "sainnhe/gruvbox-material",
  -- "Mofiqul/dracula.nvim",
  -- "rebelot/kanagawa.nvim",
  -- "EdenEast/nightfox.nvim",
  "catppuccin/nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    integrations = {
      alpha = true,
      cmp = true,
      flash = true,
      gitsigns = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      lsp_trouble = true,
      mason = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = true, custom_bg = "lualine" },
      neotest = true,
      noice = true,
      notify = true,
      neotree = true,
      semantic_tokens = true,
      telescope = true,
      treesitter = true,
      which_key = true,
    },
  },
}

-- light
-- M.name = "solarized"
-- vim.o.background = "light"

-- dark
vim.o.background = "dark"
M.name = "catppuccin-macchiato"
-- M.name = "github_dark_dimmed"
-- M.name = "gruvbox-material"
-- M.name = "dracula"
-- M.name = "highlite"
-- M.name = "Nightfox"
-- M.name = "kanagawa"
function M.config()
  local status_ok, theme = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
