-- vue2
local vue_project = require('lsp.vue_project')

---@type vim.lsp.Config
return {
  cmd = { 'vls' },
  filetypes = { 'vue' },
  root_markers = { 'package.json', 'vue.config.js' },
  -- 只在 buffer 所属项目是 Vue2 时启动，避免 cwd 决定全局启用。
  root_dir = function(bufnr, on_dir)
    local root = vue_project.root(bufnr)
    if vue_project.version(root) ~= 2 then
      return
    end
    on_dir(root)
  end,
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
}
