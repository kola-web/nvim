-- 一键打开浏览器（Windows / macOS / Linux 通用）
-- <leader>ob 打开当前 buffer 文件（file:// URL）
-- <leader>oB 输入 URL 打开（dev server 常用）

local M = {}

local function open_cmd(url)
  if vim.fn.has('win32') == 1 then
    -- start 必须传空 title，否则 URL 带空格会被当成 title
    return { 'cmd', '/c', 'start', '', url }
  elseif vim.fn.has('macunix') == 1 then
    return { 'open', url }
  else
    return { 'xdg-open', url }
  end
end

function M.open_url(url)
  if not url or url == '' then
    return
  end
  vim.fn.jobstart(open_cmd(url), { detach = true })
  vim.notify('浏览器打开：' .. url, vim.log.levels.INFO)
end

function M.open_current_file()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' or vim.uv.fs_stat(path) == nil then
    vim.notify('当前 buffer 没有文件', vim.log.levels.WARN)
    return
  end
  M.open_url(vim.uri_from_fname(path))
end

function M.open_input()
  vim.ui.input({ prompt = '打开 URL：', default = 'http://localhost:8080' }, function(url)
    if url and url ~= '' then
      M.open_url(url)
    end
  end)
end

vim.keymap.set('n', '<leader>ob', M.open_current_file, { desc = 'Browser: 打开当前文件' })
vim.keymap.set('n', '<leader>oB', M.open_input, { desc = 'Browser: 输入 URL 打开' })

return M
