local M = {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  dependencies = {
    {
      'zbirenbaum/copilot-cmp',
      config = true,
    },
  },
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
  },
}

return M
