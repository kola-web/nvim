local M = {
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   event = 'VeryLazy',
  --   init = function()
  --     vim.g.lualine_laststatus = vim.o.laststatus
  --     if vim.fn.argc(-1) > 0 then
  --       -- set an empty statusline till lualine loads
  --       vim.o.statusline = ' '
  --     else
  --       -- hide the statusline on the starter page
  --       vim.o.laststatus = 0
  --     end
  --   end,
  --   opts = function()
  --     local status_ok, lualine = pcall(require, 'lualine')
  --     local icons = require('utils.icons')
  --     if not status_ok then
  --       return
  --     end
  --
  --     local diagnostics = {
  --       'diagnostics',
  --       symbols = {
  --         error = icons.diagnostics.BoldError,
  --         warn = icons.diagnostics.BoldWarning,
  --         info = icons.diagnostics.BoldInformation,
  --         hint = icons.diagnostics.BoldHint,
  --       },
  --     }
  --
  --     local diff = {
  --       'diff',
  --       symbols = {
  --         added = icons.git.LineAdded,
  --         modified = icons.git.LineModified,
  --         removed = icons.git.LineRemoved,
  --       }, -- changes diff symbols
  --       source = function()
  --         local gitsigns = vim.b.gitsigns_status_dict
  --         if gitsigns then
  --           return {
  --             added = gitsigns.added,
  --             modified = gitsigns.changed,
  --             removed = gitsigns.removed,
  --           }
  --         end
  --       end,
  --     }
  --
  --     -- LSP clients attached to buffer
  --     local clients_lsp = function()
  --       local clients = vim.lsp.get_clients({ bufnr = 0 })
  --       if next(clients) == nil then
  --         return ''
  --       end
  --
  --       local c = {}
  --       for _, client in pairs(clients) do
  --         table.insert(c, client.name)
  --       end
  --       return '\u{f085} ' .. table.concat(c, '|')
  --     end
  --
  --     local trouble = require('trouble')
  --     local symbols = trouble.statusline({
  --       mode = 'symbols',
  --       groups = {},
  --       title = false,
  --       filter = { range = true },
  --       format = '{kind_icon}{symbol.name:Normal}',
  --       hl_group = 'lualine_c_normal',
  --     })
  --
  --     local opts = {
  --       options = {
  --         theme = 'auto',
  --         globalstatus = vim.o.laststatus == 3,
  --         disabled_filetypes = {
  --           'dashboard',
  --           'alpha',
  --           'snacks_dashboard',
  --           winbar = {
  --             'neo-tree',
  --             'NvimTree',
  --           },
  --         },
  --         always_divide_middle = true,
  --       },
  --       sections = {
  --         lualine_a = { 'mode' },
  --         lualine_b = { 'branch' },
  --         lualine_c = {
  --           diff,
  --           diagnostics,
  --           'filename',
  --           {
  --             symbols.get,
  --             cond = symbols.has,
  --           },
  --         },
  --         lualine_x = {
  --           {
  --             function()
  --               return require('noice').api.status.command.get()
  --             end,
  --             cond = function()
  --               return package.loaded['noice'] and require('noice').api.status.command.has()
  --             end,
  --             color = { fg = '#ff9e64' },
  --           },
  --           {
  --             function()
  --               return require('noice').api.status.mode.get()
  --             end,
  --             cond = function()
  --               return package.loaded['noice'] and require('noice').api.status.mode.has()
  --             end,
  --             color = { fg = '#ff9e64' },
  --           },
  --           clients_lsp,
  --           'encoding',
  --           'fileformat',
  --           'filetype',
  --         },
  --         lualine_y = { 'progress' },
  --         lualine_z = { 'location' },
  --       },
  --       inactive_sections = {},
  --       winbar = {},
  --       extensions = { 'neo-tree', 'lazy', 'fzf', 'trouble', 'mason', 'quickfix', 'oil' },
  --     }
  --     return opts
  --   end,
  -- },

  {
    'echasnovski/mini.statusline',
    version = '*',
    opts = {
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = MiniStatusline.section_location({ trunc_width = 75 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local noice = require('noice')

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            noice ~= nil and { strings = { noice.api.status.command.get() } }, -- noice statusline command
            vim.bo.filetype == 'http' and { hl = mode_hl, strings = { '', require('kulala').get_selected_env() } }, -- kulala environment
            noice ~= nil and { hl = mode_hl, strings = { noice.api.status.mode.get() } }, -- noice statusline mode (eg: recording)
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          })
        end,
      },
    },
  },
}

return M
