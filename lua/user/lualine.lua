local M = {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'bwpge/lualine-pretty-path',
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require('lualine_require')
      lualine_require.require = require

      local icons = require('utils.icons')

      vim.o.laststatus = vim.g.lualine_laststatus

      -- LSP clients attached to buffer
      local clients_lsp = function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if next(clients) == nil then
          return ''
        end

        local c = {}
        for _, client in pairs(clients) do
          table.insert(c, client.name)
        end
        return '\u{f085} ' .. table.concat(c, '|')
      end

      local trouble = require('trouble')
      local symbols = trouble.statusline({
        mode = 'symbols',
        groups = {},
        title = false,
        filter = { range = true },
        format = '{kind_icon}{symbol.name:Normal}',
        hl_group = 'lualine_c_normal',
      })

      local opts = {
        options = {
          theme = 'auto',
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = {
            {
              'diagnostics',
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            -- { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            -- {
            --   'filename',
            --   file_status = true, -- Displays file status (readonly status, modified status)
            --   newfile_status = false, -- Display new file status (new file means no write after created)
            --   separator = '',
            --   padding = { left = 0, right = 1 },
            --   path = 1,
            --   shorting_target = 500, -- Shortens path to leave 40 spaces in the window
            -- },
            'pretty_path',
            {
              symbols and symbols.get,
              cond = function()
                return vim.b.trouble_lualine ~= false and symbols.has()
              end,
            },
          },
          lualine_x = {
            Snacks.profiler.status(),
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return { fg = Snacks.util.color("Statement") } end,
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
            clients_lsp,
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = Snacks.util.color("Special") } end,
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
          lualine_y = {
            { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
            { 'location', padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return ' ' .. os.date('%R')
            end,
          },
        },
        extensions = { 'neo-tree', 'lazy' },
      }
      return opts
    end,
  },

  -- {
  --   'echasnovski/mini.statusline',
  --   version = '*',
  --   opts = {
  --     content = {
  --       active = function()
  --         local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
  --         local git = MiniStatusline.section_git({ trunc_width = 40 })
  --         local diff = MiniStatusline.section_diff({ trunc_width = 75 })
  --         local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
  --         local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
  --         local filename = MiniStatusline.section_filename({ trunc_width = 140 })
  --         local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
  --         local location = MiniStatusline.section_location({ trunc_width = 75 })
  --         local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
  --         local noice = require('noice')
  --
  --         return MiniStatusline.combine_groups({
  --           { hl = mode_hl, strings = { mode } },
  --           { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
  --           '%<', -- Mark general truncate point
  --           { hl = 'MiniStatuslineFilename', strings = { filename } },
  --           '%=', -- End left alignment
  --           noice ~= nil and { strings = { noice.api.status.command.get() } }, -- noice statusline command
  --           vim.bo.filetype == 'http' and { hl = mode_hl, strings = { '', require('kulala').get_selected_env() } }, -- kulala environment
  --           noice ~= nil and { hl = mode_hl, strings = { noice.api.status.mode.get() } }, -- noice statusline mode (eg: recording)
  --           { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
  --           { hl = mode_hl, strings = { search, location } },
  --         })
  --       end,
  --     },
  --   },
  -- },
}

return M
