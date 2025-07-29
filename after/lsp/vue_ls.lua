-- vue2

local get_typescript_server_path = require('utils.init').get_typescript_server_path

---@type vim.lsp.Config
return {
  single_file_support = true,
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = get_typescript_server_path(vim.fn.getcwd()),
    },
  },
}
