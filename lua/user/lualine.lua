---@diagnostic disable: undefined-field
local M = {
  'nvim-lualine/lualine.nvim',
  event = { 'VimEnter', 'InsertEnter', 'BufReadPre', 'BufAdd', 'BufNew', 'BufReadPost' },
}
local icons = require('user.nvim-dev-icons')

function M.config()
  local status_ok, lualine = pcall(require, 'lualine')
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

  lualine.setup({
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = 'auto',
      -- component_separators = { left = '', right = '' },
      -- section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = { 'alpha', 'dashboard' },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { diagnostics, { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } }, { 'filename', file_status = true, path = 1 } },
      lualine_x = {
        {
          require('noice').api.status.command.get,
          cond = require('noice').api.status.command.has,
          color = { fg = '#A57CFF' },
        },
        {
          require('noice').api.status.mode.get,
          cond = require('noice').api.status.mode.has,
          color = { fg = '#F07652' },
        },
        {
          require('lazy.status').updates,
          cond = require('lazy.status').has_updates,
          color = { fg = '#54A5FF' },
        },
        diff,
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
  })
end

return M
