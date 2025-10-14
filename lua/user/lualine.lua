local M = {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      local icons = require('utils.icons')
      local treesitter = require('nvim-treesitter')
      local codecompanion = require('utils.lueline-ai')

      local sideIcons = {
        Error = { ' ', 'DiagnosticError' },
        Inactive = { ' ', 'MsgArea' },
        Warning = { ' ', 'DiagnosticWarn' },
        Normal = { require('utils.icons').kinds.Copilot, 'Special' },
      }

      local opts = {
        options = {
          theme = 'auto',
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
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
              function()
                local status = require('sidekick.status').get()
                return status and vim.tbl_get(sideIcons, status.kind, 1)
              end,
              cond = function()
                return require('sidekick.status').get() ~= nil
              end,
              color = function()
                local status = require('sidekick.status').get()
                local hl = status and (status.busy and 'DiagnosticWarn' or vim.tbl_get(sideIcons, status.kind, 2))
                return { fg = Snacks.util.color(hl) }
              end,
            },
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
