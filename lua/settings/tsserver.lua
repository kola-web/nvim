local fun = require "utils.init"

return {
  filetypes = fun.is_vue() and { "null" }
    or { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  single_file_support = false,
  init_options = {
    locale = "zh-CN",
    preferences = {
      importModuleSpecifierPreference = "non-relative",
    },
  },
}
