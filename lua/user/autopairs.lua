local M = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
  },
}

return M
