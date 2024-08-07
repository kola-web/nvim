local M = {
  'nvim-lualine/lualine.nvim',
  event = { 'VimEnter', 'InsertEnter', 'BufReadPre', 'BufAdd', 'BufNew', 'BufReadPost' },
  opts = function()
    local status_ok, lualine = pcall(require, 'lualine')
    local icons = require('util.icons')
    if not status_ok then
      return
    end

    local diagnostics = {
      'diagnostics',
      symbols = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warn,
        info = icons.diagnostics.Info,
        hint = icons.diagnostics.Hint,
      },
    }

    local diff = {
      'diff',
      symbols = {
        added = icons.git.added,
        modified = icons.git.modified,
        removed = icons.git.removed,
      }, -- changes diff symbols
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
    }

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
      mode = 'lsp_document_symbols',
      groups = {},
      title = false,
      filter = { range = true },
      format = '{kind_icon}{symbol.name:Normal}',
    })

    local opts = {
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'dashboard' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          diagnostics,
          { 'filename', file_status = true, path = 1 },
          {
            symbols and symbols.get,
            cond = symbols and symbols.has,
          },
        },
        lualine_x = {
          {
            require('noice').api.status.command.get,
            cond = require('noice').api.status.command.has,
            color = { fg = '#ff9e64' },
          },
          {
            require('noice').api.status.mode.get,
            cond = require('noice').api.status.mode.has,
            color = { fg = '#ff9e64' },
          },
          clients_lsp,
          diff,
          'encoding',
          'fileformat',
          'filetype',
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = { fg = '#54A5FF' },
          },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {},
      winbar = {},
      extensions = { 'neo-tree', 'lazy', 'fzf', 'trouble', 'mason' },
    }
    return opts
  end,
}

return M
