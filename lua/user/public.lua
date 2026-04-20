vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-mini/mini.nvim',
})

-- 多个插件依赖这个icon
local icons = require('mini.icons')
icons.mock_nvim_web_devicons()
