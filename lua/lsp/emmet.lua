local M = {
  {
    'kola-web/emmet-vim',
    lazy = false,
    init = function()
      vim.g.user_emmet_leader_key = '<nop>'
      vim.g.user_emmet_install_global = 1
      -- vim.g.emmet_install_only_plug = 1
      vim.g.user_emmet_settings = {
        variables = {
          lang = 'zh',
        },
      }
    end,
    -- keys = {
    --   {
    --     '<C-y>',
    --     '<Plug>(emmet-expand-abbr)',
    --     desc = 'emmet',
    --     silent = true,
    --     mode = { 'i' },
    --   },
    -- },
  },
}

return M
