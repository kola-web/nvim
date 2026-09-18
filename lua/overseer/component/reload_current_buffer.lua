-- overseer 自定义组件：任务成功后刷新当前 buffer
-- （远端覆盖类任务：git reset --hard / svn revert+update 后磁盘已变，重载当前文件）
-- 非文件 buffer 跳过；有未保存修改时不刷新并提示
local STATUS = require('overseer.constants').STATUS

---@type overseer.ComponentFileDefinition
return {
  desc = '任务成功后刷新当前 buffer（有未保存修改时不刷新）',
  constructor = function()
    return {
      on_complete = function(_, task, status)
        if status ~= STATUS.SUCCESS then
          return
        end
        vim.schedule(function()
          local buf = vim.api.nvim_get_current_buf()
          local name = vim.api.nvim_buf_get_name(buf)
          if vim.bo[buf].buftype ~= '' or name == '' then
            return -- 非文件 buffer 不处理
          end
          if vim.bo[buf].modified then
            vim.notify(
              '当前文件有未保存修改，未自动刷新: ' .. vim.fn.fnamemodify(name, ':t'),
              vim.log.levels.WARN
            )
            return
          end
          vim.cmd('silent! edit!')
          vim.notify('已刷新当前 buffer: ' .. vim.fn.fnamemodify(name, ':t'), vim.log.levels.INFO)
        end)
      end,
    }
  end,
}
