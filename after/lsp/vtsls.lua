local vue_language_server_path = vim.fn.expand('$MASON/packages') .. '/vue-language-server' .. '/node_modules/@vue/language-server'

---@type vim.lsp.Config
return {
  filetypes = { 'vue' },
  single_file_support = true,
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
    typescript = {
      tsserver = { maxTsServerMemory = 8092 },
      inlayHints = {
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      tsserver = { maxTsServerMemory = 8092 },
      inlayHints = {
        enumMemberValues = { enabled = true },
      },
    },
  },
}
