local lsp = require('user.lsp')
local M = {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    on_attach = lsp.on_attach,
    capabilities = lsp.capabilities,
    settings = {
      -- expose_as_code_action = 'all',
      tsserver_locale = 'zh-CN',
      code_lens = 'off',
      tsserver_file_preferences = {
        -- disableSuggestions = false, -- 是否禁用代码建议
        -- quotePreference = 'auto', -- 字符串引号首选项，可以是 "auto"、"double" 或 "single"
        -- includeCompletionsForModuleExports = true, -- 启用或禁用在外部模块导出中包含完成列表
        -- includeCompletionsForImportStatements = true, -- 启用或禁用部分类型的导入语句的自动导入风格完成
        -- includeCompletionsWithSnippetText = true, -- 指示是否可以使用片段文本格式化完成
        -- includeCompletionsWithInsertText = true, -- 启用或禁用包含无效标识符名称的完成项，以及如何格式化它们
        -- includeAutomaticOptionalChainCompletions = true, -- 启用或禁用在访问可能为 null 或可能为 undefined 的值时包含带有可选链 (?.) 的完成项
        -- includeCompletionsWithClassMemberSnippets = true, -- 允许类成员完成包括成员的完整声明
        -- includeCompletionsWithObjectLiteralMethodSnippets = true, -- 指定对象字面方法是否应包含方法声明完成条目
        -- useLabelDetailsInCompletionEntries = true, -- 指示是否支持完成条目标签详细信息
        -- allowIncompleteCompletions = true, -- 是否允许不完整的完成
        -- importModuleSpecifierPreference = 'shortest', -- 指定模块导入的首选方式
        -- importModuleSpecifierEnding = 'auto', -- 确定模块导入的方式以及它们是否以 "auto"、"minimal"、"index" 或 "js" 结尾
        -- allowTextChangesInNewFiles = true, -- 指示是否在新文件中允许文本更改
        -- lazyConfiguredProjectsFromExternalProject = true, -- 指定是否应懒加载外部项目中的配置项目
        -- providePrefixAndSuffixTextForRename = true, -- 启用或禁用重命名操作时提供前缀和后缀文本
        -- provideRefactorNotApplicableReason = true, -- 是否提供重构不适用原因
        -- allowRenameOfImportPath = true, -- 指定是否可以重命名导入路径
        -- includePackageJsonAutoImports = 'auto', -- 定义包含或排除 package.json 自动导入的首选项
        -- jsxAttributeCompletionStyle = 'auto', -- 指定 JSX 属性完成的风格，如 "auto"、"braces" 或 "none"
        -- displayPartsForJSDoc = true, -- 是否显示 JSDoc 注释的部分
        -- generateReturnInDocTemplate = true, -- 是否在 JSDoc 模板中生成返回语句
        -- includeInlayParameterNameHints = 'none', -- 指定是否包含内联参数名称提示，选项为 "none"、"literals" 或 "all"
        -- includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- 是否在参数匹配名称时包含内联参数名称提示
        -- includeInlayFunctionParameterTypeHints = true, -- 指定是否包含内联函数参数类型提示
        -- includeInlayVariableTypeHints = true, -- 指定是否包含内联变量类型提示
        -- includeInlayVariableTypeHintsWhenTypeMatchesName = true, -- 在类型匹配名称时是否包含内联变量类型提示
        -- includeInlayPropertyDeclarationTypeHints = true, -- 指定是否包含内联属性声明类型提示
        -- includeInlayFunctionLikeReturnTypeHints = true, -- 指定是否包含内联函数返回类型提示
        -- includeInlayEnumMemberValueHints = true, -- 指定是否包含内联枚举成员值提示
        -- autoImportFileExcludePatterns = {}, -- 用于排除自动导入的文件的字符串模式数组
        -- organizeImportsIgnoreCase = 'auto', -- 指定是否以不区分大小写的方式组织导入
        -- organizeImportsCollation = 'ordinal', -- 定义组织导入的排序方法，可以是 "ordinal" 或 "unicode"
        -- organizeImportsCollationLocale = 'en', -- 指定用于 "unicode" 排序的语言环境
        -- organizeImportsNumericCollation = false, -- 指示是否在字符串中使用数字排序
        -- organizeImportsAccentCollation = true, -- 指定是否考虑重音和变音符号
        -- organizeImportsCaseFirst = false, -- 指示是否首先对大小写进行排序
        -- disableLineTextInReferences = false, -- 是否支持 ReferencesResponseItem.lineText
      },
    },
  },
}

M.config = function(_, opts)
  if not require('neoconf').get('tsserver' .. '.disable') then
    require('typescript-tools').setup(opts)
  end
end

return M
