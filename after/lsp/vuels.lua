-- vue2

---@type vim.lsp.Config
return {
  cmd = { 'vls' },
  filetypes = { 'vue' },
  init_options = {
    config = {
      -- 添加路径别名配置 ,项目的根目录中也要配置（https://vuejs.github.io/vetur/guide/setup.html#project-setup）
      alias = {
        ['@'] = '${workspaceFolder}/src',
        ['~@'] = '${workspaceFolder}/src',
        ['@components'] = '${workspaceFolder}/src/components',
        -- 添加其他别名...
      },
      vetur = {
        completion = {
          autoImport = true,
          useScaffoldSnippets = true,
        },
        validation = {
          template = true,
          script = true,
          style = true,
          templateProps = true,
          interpolation = true,
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentHighlightProvider = false
  end,
}
