local fun = require "utils.init"

return {
  filetypes = fun.is_vue() and { "null" }
    or { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    locale = "zh-CN",
  },
}
