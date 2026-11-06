-- 按 buffer 所属项目判定 Vue 版本，避免用启动时的 cwd 做全局判断。
-- root(bufnr): 最近的有 package.json 的目录
-- version(root): 2 / 3 / nil（没有 vue 依赖或读不到）
local M = {}

---@param bufnr integer
---@return string?
function M.root(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == '' then
    return nil
  end
  return vim.fs.root(vim.fs.dirname(name), { 'package.json' })
end

---@param bufnr integer
---@return string?
function M.dir(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == '' then
    return nil
  end
  return vim.fs.dirname(name)
end

---@param root string?
---@return integer?
function M.version(root)
  if not root then
    return nil
  end
  local fd = io.open(root .. '/package.json', 'r')
  if not fd then
    return nil
  end
  local content = fd:read('*a')
  fd:close()
  local dep = content:match('"vue"%s*:%s*"([^"]+)"')
  if not dep then
    return nil
  end
  dep = dep:gsub('^[%^~%=v%s]+', '')
  return tonumber(dep:match('%d+'))
end

---@param bufnr integer
---@return integer? 2 / 3 / nil
function M.buf_version(bufnr)
  return M.version(M.root(bufnr))
end

---@param bufnr integer
---@return boolean
function M.is_vue2_buffer(bufnr)
  return M.buf_version(bufnr) == 2
end

return M
