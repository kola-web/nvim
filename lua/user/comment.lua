local M = {
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {
      lang = {
        autohotkey = '; %s',
        ahk = '; %s',
        vue = {
          '<!-- %s -->',
          script_element = '// %s',
        },
      },
    },
  },
}

return M
