local M = {
  {
    'github/copilot.vim',
    enabled = true,
    event = 'VeryLazy',
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = {
        ['grug-far'] = false,
        ['grug-far-history'] = false,
        ['grug-far-help'] = false,
        ['codecompanion'] = false,
      }
    end,
    keys = {
      { '<C-l>', 'copilot#Accept("")', desc = 'Copilot panel', mode = { 'i' }, expr = true, replace_keycodes = false, silent = true },
      { '<C-j>', '<Plug>(copilot-next)', desc = 'Copilot next', mode = { 'i' }, noremap = true, silent = true },
      { '<C-k>', '<Plug>(copilot-previous)', desc = 'Copilot prev', mode = { 'i' }, noremap = true, silent = true },
      { '<C-]>', '<Plug>(copilot-dismiss)', desc = 'Copilot dismiss', mode = { 'i' }, noremap = true, silent = true },
    },
  },
  {
    'monkoose/neocodeium',
    event = 'VeryLazy',
    config = function()
      local neocodeium = require('neocodeium')
      neocodeium.setup({
        enabled = false,
        debounce = true,
        silent = true,
        show_label = false,
      })
    end,
  },
  -- {
  --   'olimorris/codecompanion.nvim',
  --   lazy = false,
  --   event = { 'InsertEnter', 'CmdlineEnter' },
  --   dependencies = {
  --     'franco-ruggeri/codecompanion-spinner.nvim',
  --   },
  --   opts = {
  --     display = {},
  --     opts = {
  --       log_level = 'DEBUG',
  --       language = 'Chinese',
  --     },
  --     extensions = {
  --       spinner = {},
  --     },
  --     strategies = {
  --       chat = { adapter = 'copilot' },
  --       inline = { adapter = 'copilot' },
  --       agent = { adapter = 'copilot' },
  --     },
  --   },
  --   keys = {
  --     { '<leader>aa', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanionActions', mode = { 'n', 'v' }, noremap = true, silent = true },
  --     { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'CodeCompanionChat Toggle', mode = { 'n', 'v' }, noremap = true, silent = true },
  --     { '<leader>al', '<cmd>CodeCompanionChat Add<cr>', desc = 'CodeCompanionChat Add', mode = { 'v' }, noremap = true, silent = true },
  --   },
  -- },
  {
    'yetone/avante.nvim',
    build = vim.fn.has('win32') ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
    event = 'VeryLazy',
    version = false, -- 永远不要将此值设置为 "*"！永远不要！
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'copilot',
      selection = {
        hint_display = 'none',
      },
    },
    dependencies = {
      {
        -- 支持图像粘贴
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- 推荐设置
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- Windows 用户必需
            use_absolute_path = true,
          },
        },
      },
      {
        -- 如果您有 lazy=true，请确保正确设置
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
}

return M
