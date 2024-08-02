local get_typescript_server_path = require('util.init').get_typescript_server_path

return {
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = get_typescript_server_path(vim.fn.getcwd()),
    },
  },
}

