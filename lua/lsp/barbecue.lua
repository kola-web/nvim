local M = {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons', -- optional dependency
  },
  opts = {
    -- configurations go here
    attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
  },
  config = function(_, opts)
    require('barbecue').setup(opts)
  end,
}

return M
