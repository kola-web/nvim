local vue_language_server_path = vim.fn.expand('$MASON/packages') .. '/vue-language-server' .. '/node_modules/@vue/language-server'

local vue_project = require('lsp.vue_project')
local filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' }

local inlayHints = {
  includeInlayEnumMemberValueHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayParameterNameHints = 'all',
  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayVariableTypeHints = true,
}

---@type vim.lsp.Config
return {
  filetypes = filetypes,
  root_dir = function(bufnr, on_dir)
    local project_root = vue_project.root(bufnr)
    -- Vue2 的 .vue 交给 vuels（Vetur），ts_ls 不接管
    if vim.bo[bufnr].filetype == 'vue' and vue_project.version(project_root) == 2 then
      return
    end

    local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
      or vim.list_extend(root_markers, { '.git' })

    local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
    local deno_lock_root = vim.fs.root(bufnr, { 'deno.lock' })
    local root = vim.fs.root(bufnr, root_markers)

    if deno_lock_root and (not root or #deno_lock_root > #root) then
      return
    end
    if deno_root and (not root or #deno_root >= #root) then
      return
    end

    -- 无 lockfile/.git 的项目回退到最近的 package.json，而不是启动 nvim 时的 cwd
    on_dir(root or project_root or vim.fn.getcwd())
  end,
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
        configNamespace = 'typescript',
        enableForWorkspaceTypeScriptVersions = true,
      },
    },
  },
  settings = {
    javascript = { inlayHints = inlayHints },
    typescript = { inlayHints = inlayHints },
  },
}
