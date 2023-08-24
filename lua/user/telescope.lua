local M = {
  "nvim-telescope/telescope.nvim",
  event = "Bufenter",
  cmd = { "Telescope" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "nvim-telescope/telescope-file-browser.nvim",
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
}

M.config = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  local actions = require "telescope.actions"

  local opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      file_ignore_patterns = {
        ".git",
        ".svn",
        "node_modules",
        "miniprogram_npm",
        ".yarn",
      },
      mappings = {
        i = {
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<CR>"] = actions.select_default,
        },
        n = {
          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
      },
    },
    extensions = {
      file_browser = {
        theme = "dropdown",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
            ["<C-w>"] = function()
              vim.cmd "normal vbd"
            end,
          },
          ["n"] = {
            -- your custom normal mode mappings
            ["/"] = function()
              vim.cmd "startinsert"
            end,
          },
        },
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          initial_mode = "normal",
        },
      },
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  }

  telescope.setup(opts)
  telescope.load_extension "file_browser"
  telescope.load_extension "ui-select"
end

return M
