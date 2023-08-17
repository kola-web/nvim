local M = {
  "akinsho/bufferline.nvim",
  event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  dependencies = {
    {
      "famiu/bufdelete.nvim",
    },
    {
      'nvim-tree/nvim-web-devicons'
    },
  },
}

function M.config()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  bufferline.setup {
    options = {
      mode = "buffers",
      close_command = "Bdelete! %d",                        -- can be a string | function, see "Mouse actions"
      right_mouse_command = "Bdelete! %d",                  -- can be a string | function, see "Mouse actions"
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      separator_style = "thin",                             -- | "thick" | "thin" | { 'any', 'any' },
      sort_by = "id",
    },
  }
end

return M
