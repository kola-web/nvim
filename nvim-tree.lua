local M = {
  "nvim-tree/nvim-tree.lua",
  event = "VimEnter",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
    },
  },
}

local function copy_file_to(node)
  local file_src = node["absolute_path"]
  print("111" .. file_src)
end

local on_attach = function(bufnr)
  -- local api = require "nvim-tree.api"
  --
  -- local function opts(desc)
  --   return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  -- end

  vim.keymap.set("n", "<C-y>", copy_file_to, { buffer = bufnr })
end

function M.config()
  require("nvim-tree").setup {
    on_attach = on_attach,
    select_prompts = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    renderer = {
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = {
        hint = "󰌵",
        info = "",
        warning = "",
        error = "",
      },
    },
    view = {
      width = 30,
      side = "left",
    },
  }
end

return M
