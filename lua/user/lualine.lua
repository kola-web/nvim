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
    colored = false,
    symbols = {
      added = icons.icons.git.added,
      modified = icons.icons.git.modified,
      removed = icons.icons.git.removed,
    }, -- changes diff symbols
    cond = hide_in_width,
  }

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
      lualine_c = { diagnostics },
      lualine_x = {
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = { fg = '#ff9e64' },
        },
        -- {
        --   require('noice').api.status.message.get_hl,
        --   cond = require('noice').api.status.message.has,
        -- },
        -- {
        --   require('noice').api.status.command.get,
        --   cond = require('noice').api.status.command.has,
        --   color = { fg = '#ff9e64' },
        -- },
        -- {
        --   require('noice').api.status.mode.get,
        --   cond = require('noice').api.status.mode.has,
        --   color = { fg = '#ff9e64' },
        -- },
        -- {
        --   require('noice').api.status.search.get,
        --   cond = require('noice').api.status.search.has,
        --   color = { fg = '#ff9e64' },
        -- },
        {
          require('lazy.status').updates,
          cond = require('lazy.status').has_updates,
          color = { fg = '#ff9e64' },
        },
        diff,
        spaces,
        'encoding',
        filetype,
      },
      lualine_y = { location },
      lualine_z = { 'progress' },
    },
  })
end

return M
