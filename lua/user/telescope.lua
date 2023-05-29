local M = {
  "nvim-telescope/telescope.nvim",
  event = "Bufenter",
  cmd = { "Telescope" },
  dependencies = {
    {
      "ahmedkhalf/project.nvim",
    },
    {
      "nvim-telescope/telescope-file-browser.nvim"
    },
    {
      "nvim-telescope/telescope-ui-select.nvim"
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make"
    },
  },
}

local actions = require "telescope.actions"

M.opts = {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = {
      '.git',
      '.svn',
      'node_modules',
      'miniprogram_npm',
    },
    mappings = {
      i = {
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = 'dropdown',
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ['i'] = {
          -- your custom insert mode mappings
          ['<C-w>'] = function()
            vim.cmd 'normal vbd'
          end,
        },
        ['n'] = {
          -- your custom normal mode mappings
          ['/'] = function()
            vim.cmd 'startinsert'
          end,
        },
      },
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {},
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}


M.config = function()
  local status_ok, telescope = pcall(require, 'telescope')
  if not status_ok then
    return
  end
  telescope.load_extension 'file_browser'
  telescope.load_extension 'ui-select'
end


return M