vim.pack.add({
  'https://github.com/folke/ts-comments.nvim',
})

require('ts-comments').setup({
  lang = {
    autohotkey = '; %s',
    ahk = '; %s',
    vue = {
      '<!-- %s -->',
      script_element = '// %s',
    },
  },
})
