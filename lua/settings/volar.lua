local get_typescript_server_path = require('utils.init').get_typescript_server_path

return {
  filetypes = { 'vue' },
  locale = 'zh-cn',
  init_options = {
    locale = 'zh-cn',
    vue = {
      hybridMode = false,
    },
  },
  typescript = {
    tsdk = get_typescript_server_path,
  },
}
