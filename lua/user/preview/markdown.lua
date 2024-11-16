local M = {
  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    event = 'VeryLazy',
    config = function()
      local status_ok, peek = pcall(require, 'peek')
      if not status_ok then
        return
      end

      -- default config:
      peek.setup({
        syntax = false,
      })
      -- vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      -- vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

      vim.api.nvim_create_user_command('PeekOpen', function()
        if not peek.is_open() and vim.bo[vim.api.nvim_get_current_buf()].filetype == 'markdown' then
          if vim.fn.has('macunix') then
            vim.fn.system('yabai -m space --layout bsp')
            peek.open()
            vim.fn.system('sleep 0.5 ; yabai -m space --rotate 180 ; yabai -m window --focus recent')
          else
            peek.open()
          end
        end
      end, {})

      vim.api.nvim_create_user_command('PeekClose', function()
        if peek.is_open() then
          peek.close()
          vim.fn.system('yabai -m space --layout stack')
        end
      end, {})
    end,
    keys = {
      { '<leader>po', ':PeekOpen<CR>', desc = 'PeekOpen' },
      { '<leader>pc', ':PeekClose<CR>', desc = 'PeekClose' },
    },
  },
  { 'dhruvasagar/vim-table-mode', event = 'VeryLazy' },
}

return M
