local M = {
  'willothy/nvim-cokeline',
  event = { 'BufReadPre', 'BufAdd', 'BufNew', 'BufReadPost' },
  dependencies = {
    {
      'echasnovski/mini.bufremove',
    },
    {
      'nvim-tree/nvim-web-devicons',
    },
  },
  opts = function()
    local get_hex = require('cokeline.hlgroups').get_hl_attr

    local green = vim.g.terminal_color_2
    local yellow = vim.g.terminal_color_3

    return {
      show_if_buffers_are_at_least = 0,
      mappings = {
        disable_mouse = true,
      },
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex('Normal', 'fg') or get_hex('Comment', 'fg')
        end,
        bg = get_hex('ColorColumn', 'bg'),
      },
      sidebar = {
        filetype = { 'NvimTree', 'neo-tree' },
        components = {
          {
            text = function(buf)
              return buf.filetype
            end,
            fg = yellow,
            bg = function()
              return get_hex('NvimTreeNormal', 'bg')
            end,
            bold = true,
          },
        },
      },
      components = {
        {
          text = '｜',
          fg = function(buffer)
            return buffer.is_modified and yellow or green
          end,
        },
        {
          text = function(buffer)
            return buffer.devicon.icon .. ' '
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        {
          text = function(buffer)
            return buffer.index .. ': '
          end,
        },
        {
          text = function(buffer)
            return buffer.unique_prefix
          end,
          fg = get_hex('Comment', 'fg'),
          italic = true,
        },
        {
          text = function(buffer)
            return buffer.filename .. ' '
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
        },
        {
          text = ' ',
        },
      },
    }
  end,
  keys = {
    { '<S-tab>', '<Plug>(cokeline-focus-prev)', desc = 'Prev buffer' },
    { '<tab>', '<Plug>(cokeline-focus-next)', desc = 'Next buffer' },
    { '(', '<Plug>(cokeline-switch-prev)', desc = 'move prev' },
    { ')', '<Plug>(cokeline-switch-next)', desc = 'move move' },
  },
}

return M
