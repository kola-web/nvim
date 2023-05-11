local fun = require "user.function"

return {
  filetypes = fun.is_vue() and { "null" }
    or { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  single_file_support = false,
  init_options = {
    hostInfo = "neovim",
    locale = "zh-CN",
    preferences = {
      importModuleSpecifierPreference = "non-relative",
    },
  },
}
