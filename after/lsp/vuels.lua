-- vue2

---@type vim.lsp.Config
return {
  cmd = { 'vls' },
  filetypes = { 'vue' },
  root_dir = require('lspconfig').util.root_pattern('package.json', 'vue.config.js'),
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
          tagCasing = 'kebab',
        },
        useWorkspaceDependencies = false,
        validation = {
          template = true,
          script = true,
          style = true,
          templateProps = true,
          interpolation = true,
        },
        format = {
          defaultFormatter = {
            js = 'none',
            ts = 'none',
          },
          defaultFormatterOptions = {},
          scriptInitialIndent = false,
          styleInitialIndent = false,
        },
      },
      css = {},
      html = {
        suggest = {},
      },
      javascript = {
        format = {},
      },
      typescript = {
        format = {},
      },
      emmet = {},
      stylusSupremacy = {},
    },
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentHighlightProvider = false
  end,
}
