-- pack 管理:一键更新插件 / 一键清理未引用插件
-- 基于 Neovim 0.11+ 内置插件管理器 vim.pack,无需第三方插件

-- 更新所有插件
-- vim.pack.update() 默认会打开内置确认缓冲区:
--   :write 应用更新, :quit 取消更新
local function update_all_plugins()
  vim.pack.update()
end

-- 清理磁盘上已无引用的插件
-- 判断标准:当前配置不再通过 vim.pack.add() 注册(active == false)的残留插件
local function clean_unused_plugins()
  local unused = vim.iter(vim.pack.get())
    :filter(function(p)
      return not p.active
    end)
    :map(function(p)
      return p.spec.name
    end)
    :totable()

  if #unused == 0 then
    vim.notify('[pack] 没有未引用的插件', vim.log.levels.INFO)
    return
  end

  -- 多选确认,避免误删
  vim.ui.select(unused, {
    prompt = '选择要卸载的未引用插件 (Enter 确认)',
    kind = 'warning',
    multi_select = true,
  }, function(choices)
    if not choices or #choices == 0 then
      return
    end
    -- del 默认 force = false,不会误删当前会话仍在使用的插件
    vim.pack.del(choices)
    vim.notify('[pack] 已卸载: ' .. table.concat(choices, ', '), vim.log.levels.INFO)
  end)
end

vim.keymap.set('n', '<leader>Pu', update_all_plugins, { desc = '[P]ack [u]pdate all plugins' })
vim.keymap.set('n', '<leader>Pc', clean_unused_plugins, { desc = '[P]ack [c]lean unused plugins' })
