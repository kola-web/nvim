local M = {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  keys = {
    { '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>', 'Explorer', mode = { 'n' } },
  },
  opts = function()
    local icons = require('user.nvim-dev-icons').icons

    local function copy_file_to(name)
      return function()
        local api = require('nvim-tree.api')
        local node = api.tree.get_node_under_cursor()
        local file_src = node['absolute_path']
        local dir = vim.fn.fnamemodify(file_src, ':h')
        vim.fn.system({ 'cp', '-r', '/Users/lijialin/.config/nvim/template/' .. name, dir })
        api.tree.find_file(dir .. '/' .. name)
      end
    end

    local function open_in_finder()
      vim.system({ 'open', vim.fn.expand('%:p:h') })
    end

    local on_attach = function(bufnr)
      local api = require('nvim-tree.api')
      api.config.mappings.default_on_attach(bufnr)

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      vim.keymap.set('n', 'f', open_in_finder, opts('Live Filter: Start '))

      vim.keymap.set('n', '/', api.live_filter.start, opts('Live Filter: Start '))
      vim.keymap.set('n', '?', api.live_filter.clear, opts('Live Filter: Clear '))

      vim.keymap.set('n', '<C-y>c', copy_file_to('wxmlComponent'), opts('Copy File To'))
      vim.keymap.set('n', '<C-y>p', copy_file_to('wxmlPage'), opts('Copy File To'))
    end

    return {
      on_attach = on_attach,
      sync_root_with_cwd = false,
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = 'none',
        root_folder_label = ':t',
        indent_width = 2,
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = '└',
            edge = '│',
            item = '│',
            none = ' ',
          },
        },
        icons = {
          git_placement = 'before',
          padding = ' ',
          symlink_arrow = ' ➛ ',
          glyphs = {
            default = icons.ui.Text,
            symlink = icons.ui.FileSymlink,
            bookmark = icons.ui.BookMark,
            folder = {
              arrow_closed = icons.ui.ChevronRight,
              arrow_open = icons.ui.ChevronShortDown,
              default = icons.ui.Folder,
              open = icons.ui.FolderOpen,
              empty = icons.ui.EmptyFolder,
              empty_open = icons.ui.EmptyFolderOpen,
              symlink = icons.ui.FolderSymlink,
              symlink_open = icons.ui.FolderOpen,
            },
            git = {
              unstaged = icons.git.FileUnstaged,
              staged = icons.git.FileStaged,
              unmerged = icons.git.FileUnmerged,
              renamed = icons.git.FileRenamed,
              untracked = icons.git.FileUntracked,
              deleted = icons.git.FileDeleted,
              ignored = icons.git.FileIgnored,
            },
          },
        },
        special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
        symlink_destination = true,
      },
      update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = icons.diagnostics.BoldHint,
          info = icons.diagnostics.BoldInformation,
          warning = icons.diagnostics.BoldWarning,
          error = icons.diagnostics.BoldError,
        },
      },
      notify = {
        threshold = vim.log.levels.ERROR,
        absolute_path = true,
      },
    }
  end,
}

return M
