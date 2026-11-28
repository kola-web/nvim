-- 打包上线任务：直接执行项目自带的 dist.sh / dist.ps1
-- 查找规则见 utils.overseer_util.resolve_dist：buffer 所在目录 → cwd，各自向上逐级查找
-- 系统匹配：Windows 执行 dist.ps1（pwsh），其他平台执行 dist.sh（bash）
-- 构建/提交/ssh 远程更新的具体逻辑由 dist 脚本自身负责，任务不重复实现（换项目即换脚本）

return {
  name = '打包上线',
  desc = '执行项目 dist 脚本（Windows: dist.ps1 / 其他: dist.sh），从 buffer 目录与 cwd 向上查找',
  builder = function()
    return require('utils.overseer_util').dist_task('打包上线')
  end,
}
