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
  print(file_src)
  -- The args of input are {prompt}, {default}, {completion}
  -- Read in the new file path using the existing file's path as the baseline.
  -- local file_out = vim.fn.input("COPY TO: ", file_src, "file")
  -- Create any parent dirs as required
  -- local dir = vim.fn.fnamemodify(file_out, ":h")
  -- vim.fn.system { "mkdir", "-p", dir }
  -- Copy the file
  -- vim.fn.system { "cp", "-R", "~/.config/nvim/template/wxmlComponent", file_out }
end

M.on_attach = function(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- vim.keymap.set("n", "]a", copy_file_to, opts "copy_file_to")
  vim.keymap.set("n", "]a", copy_file_to, opts "Copy File To")
end

function M.config()
  require("nvim-tree").setup {
    on_attach = M.on_attach(),
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

