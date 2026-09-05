-- overseer 自定义组件：环境切换任务成功后，自动 reload 被修改的 buffer
-- 通过 runtimepath 发现（nvim_get_runtime_file 扫描所有 rtp 的 lua/overseer/component/*.lua）
local STATUS = require("overseer.constants").STATUS

---@type overseer.ComponentFileDefinition
return {
  desc = "环境切换成功后自动刷新 app.ts / project.config.json buffer",
  constructor = function()
    return {
      on_complete = function(_, task, status)
        if status ~= STATUS.SUCCESS then
          return
        end
        local files = task and task.metadata and task.metadata.files
        if not files then
          return
        end
        vim.schedule(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) then
              local buf_name = vim.fs.normalize(vim.api.nvim_buf_get_name(buf))
              for _, f in ipairs(files) do
                if buf_name == vim.fs.normalize(f) then
                  vim.api.nvim_buf_call(buf, function()
                    if vim.bo.modified then
                      vim.notify(
                        ("环境切换后 %s 有未保存修改，未自动刷新"):format(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")),
                        vim.log.levels.WARN
                      )
                    else
                      vim.cmd("silent! edit!")
                    end
                  end)
                end
              end
            end
          end
        end)
      end,
    }
  end,
}
