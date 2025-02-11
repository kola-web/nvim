local M = {}
M.split = function()
  vim.cmd('set splitbelow')
  vim.cmd('sp')
  vim.cmd('res -5')
end

M.compile_run = function()
  vim.cmd('w')
  -- check file type
  local ft = vim.bo.filetype
  if ft == 'dart' then
    vim.cmd(':FlutterRun -d ' .. vim.g.flutter_default_device .. ' ' .. vim.g.flutter_run_args)
  elseif ft == 'markdown' then
    vim.cmd(':InstantMarkdownPreview')
  elseif ft == 'c' then
    M.split()
    vim.cmd('term gcc % -o %< && ./%< && rm %<')
  elseif ft == 'javascript' then
    M.split()
    vim.cmd('term node %')
  elseif ft == 'lua' then
    M.split()
    vim.cmd('term luajit %')
  elseif ft == 'tex' then
    vim.cmd(':VimtexCompile')
  elseif ft == 'python' then
    M.split()
    vim.cmd('term python3 %')
  elseif ft == 'sh' then
    M.split()
    vim.cmd('term bash %')
  end
end

return M
