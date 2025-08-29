local M = {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      local icons = require('utils.icons')
      local treesitter = require('nvim-treesitter')
      local codecompanion = require('utils.lueline-ai')

      local opts = {
        options = {
          theme = 'auto',
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            {
              'diagnostics',
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            {
              'diff',
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_c = {
            {
              function()
                return require('utils').get_root_dir()
              end,
              icon = '',
            },
          },
          lualine_x = {
            Snacks.profiler.status(),
            codecompanion,
            'lsp_status',
            'filetype',
            {
              'fileformat',
              symbols = {
                unix = 'Unix (LF)',
                dos = 'Windows (CRLF)',
                mac = 'Unix (LF)',
              },
            },
          },
          lualine_y = {
            'progress',
          },
          lualine_z = {
            'location',
          },
        },
        extensions = { 'lazy', 'mason', 'man' },
      }
      return opts
    end,
  },
}

return M
