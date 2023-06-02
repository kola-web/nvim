local M = {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
}

M.config = function()
  require("copilot").setup {
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      wxml = false,
      html = false,
      css = false,
      scss = false,
      json = false,
    },
  }
end

return M
