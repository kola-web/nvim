local vue_language_server_path = vim.fn.expand('$MASON/packages') .. '/vue-language-server' .. '/node_modules/@vue/language-server'

---@type vim.lsp.Config
return {
  -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
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
  on_attach = function(client, bufnr)
    local existing_capabilities = client.server_capabilities

    if existing_capabilities == nil then
      return
    end

    existing_capabilities.documentFormattingProvider = nil

    if client.name == 'vtsls' then
      local existing_filters = existing_capabilities.workspace.fileOperations.didRename.filters or {}
      local new_glob = '**/*.{ts,cts,mts,tsx,js,cjs,mjs,jsx,vue}'

      for _, filter in ipairs(existing_filters) do
        if filter.pattern and filter.pattern.matches == 'file' then
          filter.pattern.glob = new_glob
          break
        end
      end

      existing_capabilities.workspace.fileOperations.didRename.filters = existing_filters
    end

    -- vue 3.0.3
    if vim.bo.filetype == 'vue' then
      existing_capabilities.semanticTokensProvider.full = false
    else
      existing_capabilities.semanticTokensProvider.full = true
    end
  end,
}
