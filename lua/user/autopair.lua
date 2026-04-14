local autopair_ok, autopair = pcall(require, 'nvim-autopairs')
if autopair_ok then
  autopair.setup({})
end
