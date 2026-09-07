-- 运行当前文件脚本（<leader>xr / <leader>xo 中的 run script）
-- 按 buffer 文件类型查表分派运行器；未匹配类型给提示而非返回 nil（nil 会触发 E5108）
return {
  name = 'run script',
  builder = function()
    local file = vim.fn.expand('%:p')
    local ft = vim.bo.filetype
    -- c/cpp：Windows 无 sh，用 bash -c 包装「编译 && 运行」（需 mingw gcc/g++，git bash 自带 bash）
    local out = file:gsub('%.[^.]*$', '.exe')
    local runners = {
      sh = { 'bash', file },
      go = { 'go', 'run', file },
      python = { 'python', file },
      javascript = { 'node', file },
      typescript = { 'npx', '--yes', 'tsx', file },
      c = { 'bash', '-c', ('gcc "%s" -o "%s" && "%s"'):format(file, out, out) },
      cpp = { 'bash', '-c', ('g++ "%s" -o "%s" && "%s"'):format(file, out, out) },
      ruby = { 'ruby', file },
      -- 零依赖：用 nvim 自身 headless 执行 lua 脚本（脚本内可用 nvim API）
      -- 末尾 -c qa 确保执行完自动退出，否则任务会一直挂起
      lua = { vim.v.progpath:gsub('\\', '/'), '--headless', '-c', 'luafile ' .. file, '-c', 'qa' },
    }
    local cmd = runners[ft]
    if not cmd then
      -- 兜底提示：文件类型未配置运行器
      cmd = {
        vim.v.progpath,
        '--headless',
        '-c',
        ('vim.notify("run script: 未支持的文件类型 %s", vim.log.levels.WARN)'):format(ft),
      }
    end
    return {
      cmd = cmd,
      components = {
        { 'on_output_quickfix', set_diagnostics = true, open = true },
        'on_result_diagnostics',
        'on_exit_set_status',
        { 'on_complete_dispose', require_view = { 'SUCCESS', 'FAILURE' } },
        'unique',
        'restart_on_save',
      },
    }
  end,
  condition = {
    filetype = { 'sh', 'python', 'go', 'javascript', 'typescript', 'c', 'cpp', 'ruby', 'lua' },
  },
}
