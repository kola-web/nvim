-- 提交图片任务：直接执行项目自带的 dist.sh / dist.ps1
-- 查找规则见 utils.overseer_util.resolve_dist：buffer 所在目录 → cwd，各自向上逐级查找
-- 系统匹配：Windows 执行 dist.ps1（pwsh），其他平台执行 dist.sh（bash）
-- 找不到脚本 → 直接 FAILURE 任务并在输出里说明查找范围；执行完成 → on_complete_notify 通知
-- svn 提交 / ssh 远程更新的具体逻辑由 dist 脚本自身负责，任务不重复实现

return {
  name = '提交图片',
  desc = '执行项目 dist 脚本（Windows: dist.ps1 / 其他: dist.sh），从 buffer 目录与 cwd 向上查找',
  builder = function()
    return require('utils.overseer_util').dist_task('提交图片')
  end,
}
