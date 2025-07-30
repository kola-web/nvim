local vue_language_server_path = vim.fn.expand('$MASON/packages') .. '/vue-language-server' .. '/node_modules/@vue/language-server' .. '/node_modules/@vue/typescript-plugin'

---@type vim.lsp.Config
return {
  filetypes = {},
  init_options = {
    locale = 'zh-CN',
    preferences = {
      importModuleSpecifierPreference = 'non-relative',
    },
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
      },
    },
  },
  settings = {},
}
