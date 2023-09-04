local M = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
}

function M.config()
  local status_ok, lualine = pcall(require, 'lualine')
  local icons = require('icons')
  if not status_ok then
    return
  end

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    sections = { 'error', 'warn' },
    symbols = { error = icons.diagnostics.Error, warn = icons.diagnostics.Warn },
    colored = false,
    always_visible = true,
  }

  local diff_source = function()
    ---@diagnostic disable-next-line: undefined-field
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end

  local filetype = {
    'filetype',
    icons_enabled = false,
  }

  local location = {
    'location',
    padding = 0,
  }

  local spaces = function()
    return 'spaces: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
  end

  local codeium = function()
    return vim.fn['codeium#GetStatusString']()
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
      lualine_b = { { 'b:gitsigns_head', icon = '' } },
      lualine_c = {
        diagnostics,
        { 'filename', file_status = false, path = 1 },
        'filesize',
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
        {
          require('noice').api.status.search.get,
          cond = require('noice').api.status.search.has,
          color = { fg = '#ff9e64' },
        },
        {
          'diff',
          -- source = diff_source,
          symbols = { added = ' ', modified = ' ', removed = ' ' },
          cond = hide_in_width,
        },
        'encoding',
        filetype,
        spaces,
      },
      lualine_y = { location },
      lualine_z = { 'progress' },
    },
    extensions = { 'neo-tree', 'lazy' },
  })
end

return M