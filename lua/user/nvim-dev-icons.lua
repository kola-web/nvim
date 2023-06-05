local M = {
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
}

function M.config()
  require("nvim-web-devicons").setup {
    override = {
      zsh = {
        icon = "",
        color = "#428850",
        cterm_color = "65",
        name = "Zsh",
      },
      wxml = {
        icon = "",
        color = "#E04422",
        cterm_color = "65",
        name = "Wxml",
      },
    },
    color_icons = true,
    default = true,
  }
end

return M
