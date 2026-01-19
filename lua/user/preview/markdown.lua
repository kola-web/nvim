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
        app = 'browser',
      })

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
          if vim.fn.has('macunix') then
            peek.close()
            vim.fn.system('yabai -m space --layout stack')
          else
            peek.close()
          end
        end
      end, {})
    end,
    keys = {
      { '<leader>qo', ':PeekOpen<CR>', desc = 'PeekOpen' },
      { '<leader>qc', ':PeekClose<CR>', desc = 'PeekClose' },
    },
  },
  -- {
  --   'dhruvasagar/vim-table-mode',
  --   ft = { 'markdown' },
  --   init = function()
  --     vim.g.table_mode_disable_mappings = 1
  --     vim.g.table_mode_disable_tableize_mappings = 1
  --   end,
  -- },
}

return M
