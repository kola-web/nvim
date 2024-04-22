local M = {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html',
  opts = {
    cn = {
      enabled = true,
    },
    lang = 'typescript',
  },
}

return M
