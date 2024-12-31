local M = {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>pr", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>pp", function() require("persistence").select() end,desc = "Select Session" },
    { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>pd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
}

return M
