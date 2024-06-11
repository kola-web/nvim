local get_typescript_server_path = require('utils.init').get_typescript_server_path

return {
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
  init_options = {
    vue = {
      hybridMode = 'false',
    },
  },
}
