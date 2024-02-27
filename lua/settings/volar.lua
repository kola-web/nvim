local is_vue = require('utils.init').is_vue
local util = require('lspconfig.util')
local function get_typescript_server_path(root_dir)
  local global_ts = '/Users/lijialin/Library/pnpm/global/5/node_modules/typescript/lib'
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
  filetypes = is_vue() and { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' } or { 'vue' },
  autostart = is_vue(),
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
  init_options = {
    languageFeatures = {
      callHierarchy = true,
      codeAction = true,
      codeLens = true,
      completion = {
        defaultAttrNameCase = 'kebabCase',
        defaultTagNameCase = 'both',
      },
      definition = true,
      diagnostics = true,
      documentHighlight = true,
      documentLink = true,
      hover = true,
      implementation = true,
      references = true,
      rename = true,
      renameFileRefactoring = true,
      schemaRequestService = true,
      semanticTokens = false,
      signatureHelp = true,
      typeDefinition = true,
    },
  },
  settings = {
    typescript = {
      locale = 'zh-CN',
      inlayHints = {
        parameterNames = {
          enabled = 'all',
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = true,
        },
        enumMemberValues = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = {
          enabled = 'all',
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = true,
        },
        enumMemberValues = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
      },
    },
  },
}
