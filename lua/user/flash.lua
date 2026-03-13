local M = {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          highlight = { backdrop = false },
        },
      },
      highlight = { backdrop = false },
      label = {
        uppercase = false,
        current = true,
        rainbow = {
          enabled = true,
          -- 颜色深浅度（1-9）
          shade = 1,
        },
      },
    },
    keys = {
      {
        '<cr>',
        mode = { 'n', 'x', 'o' },
        function()
          -- 参考 mini.jump2d 的实现，排除特殊窗口类型
          local buftype = vim.bo.buftype
          local filetype = vim.bo.filetype

          -- 排除的 buftype: quickfix, nofile, help, prompt, terminal
          local exclude_buftypes = { quickfix = true, nofile = true, help = true, prompt = true, terminal = true }
          -- 排除的 filetype: TelescopePrompt, snacks_input, snacks_picker_list 等
          local exclude_filetypes = { ['TelescopePrompt'] = true, ['snacks_input'] = true }

          if exclude_buftypes[buftype] or exclude_filetypes[filetype] then
            -- 使用 feedkeys 模拟默认的 <CR> 行为，更可靠
            local key = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
            vim.api.nvim_feedkeys(key, 'n', false)
            return
          end

          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        '<S-CR>',
        mode = { 'n', 'o', 'x' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
}

return M
