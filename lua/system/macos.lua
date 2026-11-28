-- mini.files 的 wp/wc 已统一收敛到 utils.init.create_mini_from_template（跨平台）
-- 原 vim.g.mini_file_mini_component / mini_file_mini_page 定义已移除

-- PATH 补齐：macOS 从 Dock / Finder / GUI 启动的 nvim（含 Neovide）只继承最小 PATH
-- （/usr/bin:/bin:/usr/sbin:/sbin），此时 overseer 任务里的 dist.sh 会找不到
-- brew 的 svn、volta 的 pnpm/node，表现就是「任务秒失败」或「完全没反应」。
-- 与 Windows 侧 lua/system/windows.lua 里补 node 到 PATH 的处理对齐：幂等前置，重复加载不叠加。
local function prepend_path(dir)
  if not dir or vim.fn.isdirectory(dir) ~= 1 then
    return
  end
  local current = vim.fn.getenv('PATH') or ''
  if current == vim.NIL then
    current = ''
  end
  -- 已存在则不重复前置，避免多次 require 把 PATH 越叠越长
  for entry in vim.gsplit(current, ':', { plain = true }) do
    if entry == dir then
      return
    end
  end
  vim.fn.setenv('PATH', current == '' and dir or (dir .. ':' .. current))
end

-- 顺序有意义：越靠前优先级越高
prepend_path(vim.fn.expand('~/.volta/bin')) -- pnpm / node（volta）
prepend_path(vim.fn.expand('~/.local/bin'))
prepend_path('/opt/homebrew/sbin')
prepend_path('/opt/homebrew/bin') -- svn / ssh / git 等 brew 工具，放最后前置 => 优先级最高
