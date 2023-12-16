local M = {
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    config = function()
      local present, marks = pcall(require, 'marks')
      if not present then
        return
      end
      marks.setup({})
    end,
  },
}

return M
