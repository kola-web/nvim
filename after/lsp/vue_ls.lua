-- vue3
local vue_project = require('lsp.vue_project')

---@type vim.lsp.Config
return {
  -- 只在 buffer 所属项目是 Vue3 时启动，避免 cwd 决定全局启用。
  root_dir = function(bufnr, on_dir)
    local root = vue_project.root(bufnr)
    if vue_project.version(root) == 2 then
      return
    end
    on_dir(root or vue_project.dir(bufnr))
  end,
}
