local M = {
  'nvim-lualine/lualine.nvim',
  event = { 'VimEnter', 'InsertEnter', 'BufReadPre', 'BufAdd', 'BufNew', 'BufReadPost' },
}

function M.config()
  local status_ok, lualine = pcall(require, 'lualine')
  local icons = require('user.nvim-dev-icons')
  if not status_ok then
    return
  end

  local diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    sections = { 'error', 'warn' },
    symbols = { error = icons.icons.diagnostics.Error, warn = icons.icons.diagnostics.Warn },
    colored = false,
    always_visible = true,
  }

  local diff = {
    'diff',
    symbols = {
      added = icons.icons.git.added,
      modified = icons.icons.git.modified,
      removed = icons.icons.git.removed,
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
    local bufnr = vim.api.nvim_get_current_buf()

    local clients = vim.lsp.buf_get_clients(bufnr)
    if next(clients) == nil then
      return ''
    end

    local c = {}
    for _, client in pairs(clients) do
      table.insert(c, client.name)
    end
    return '\u{f085} ' .. table.concat(c, '|')
  end

  lualine.setup({
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
      lualine_b = { 'branch', diff, diagnostics },
      lualine_c = {
        -- { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
        -- { 'filename', file_status = true, path = 1 },
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
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    winbar = {},
    extensions = { 'neo-tree', 'lazy', 'fzf', 'trouble', 'mason' },
  })
end

return M
