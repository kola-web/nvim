local M = {
  "nvim-tree/nvim-tree.lua",
  event = "VimEnter",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
    },
  },
}

local function copy_file_to()
  local api = require "nvim-tree.api"
  local node = api.tree.get_node_under_cursor()
  local file_src = node["absolute_path"]
  local dir = vim.fn.fnamemodify(file_src, ":h")
  vim.fn.system { "mkdir", "-p", dir }
  -- -- Copy the file
  vim.fn.system { "cp", "-R", "~/.config/nvim/template/wxmlComponent", dir }
end

local on_attach = function(bufnr)
  local api = require "nvim-tree.api"
  api.config.mappings.default_on_attach(bufnr)

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "<C-y>", copy_file_to, opts "Copy File To")
end

M.config = function()
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
