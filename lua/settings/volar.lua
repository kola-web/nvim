local fun = require('utils.init')
local util = require('lspconfig.util')

local function get_typescript_server_path(root_dir)
  local global_ts =
    '/Users/lijialin/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib'
  local found_ts = ''
  local function check_dir(path)
    found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

return {
  filetypes = fun.is_vue()
      and { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
    or { 'vue' },
  on_new_config = function(new_config, new_root_dir)
    if
      new_config.init_options
      and new_config.init_options.typescript
      and new_config.init_options.typescript.tsdk == ''
    then
      new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
    end
  end,
  -- documentFeatures = {
  --   documentFormatting = {
  --     defaultPrintWidth = 60,
  --   },
  -- },
  settings = {
    typescript = {
      preferences = {
        -- "relative" | "non-relative" | "auto" | "shortest"(not sure)
        importModuleSpecifier = 'non-relative',
      },
    },
  },
}
