vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

-- 常用 parser 预装列表（首次安装较慢；已装后按需加载 .so，不占常驻内存。
-- 可精简：不用的语言（fish/kdl/ron/blade/dart/powershell/php/python/rust 等）
-- 删除即可减少首次安装时间）
local parsers = {
  'bash',
  'blade',
  'css',
  'dart',
  'diff',
  'dockerfile',
  'fish',
  'gitignore',
  'html',
  'http',
  'javascript',
  'jq',
  'jsdoc',
  'json',
  'json5',
  'kdl',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'php',
  'powershell',
  'python',
  'regex',
  'ron',
  'rust',
  'scss',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
  'yaml',
  'ini',
}

local ts = require('nvim-treesitter')

-- 缓存查找表，避免每次 FileType 都重新扫描文件系统
local installed_map --- @type table<string, boolean>|nil
local available_map --- @type table<string, boolean>|nil

--- 已安装 parser 的 O(1) 查找表（懒加载 + 缓存）
--- @return table<string, boolean>
local function get_installed_map()
  if not installed_map then
    local m = {}
    for _, p in ipairs(ts.get_installed('parsers')) do
      m[p] = true
    end
    installed_map = m
  end
  return installed_map
end

--- 可用 parser 的 O(1) 查找表（懒加载 + 缓存）
--- @return table<string, boolean>
local function get_available_map()
  if not available_map then
    local m = {}
    for _, p in ipairs(ts.get_available()) do
      m[p] = true
    end
    available_map = m
  end
  return available_map
end

local function refresh_installed()
  installed_map = nil
end

-- 预装常用 parser；装完刷新缓存，后续 FileType 直接命中已安装分支
ts.install(parsers):await(function()
  refresh_installed()
end)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  -- Check if a parser exists and load it
  if not vim.treesitter.language.add(language) then
    return
  end
  -- Enable syntax highlighting and other treesitter features
  vim.treesitter.start(buf, language)

  -- Enable treesitter based indentation if indent query exists
  -- (fallback to vim's builtin indentexpr otherwise)
  if vim.treesitter.query.get(language, 'indents') ~= nil then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local augroup = vim.api.nvim_create_augroup('kola-treesitter', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then
      return
    end

    if get_installed_map()[language] then
      -- 已安装：直接启用
      treesitter_try_attach(buf, language)
    elseif get_available_map()[language] then
      -- 可用但未安装：安装后启用，并失效缓存
      ts.install(language):await(function()
        refresh_installed()
        treesitter_try_attach(buf, language)
      end)
    else
      -- 兜底：parser 已存在但不来自 nvim-treesitter
      treesitter_try_attach(buf, language)
    end
  end,
})
