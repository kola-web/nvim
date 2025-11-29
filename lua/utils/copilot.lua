local M = {}

M.interceptLimit = function()
  local original_snacks_select = vim.ui.select -- 重写 vim.ui.select，拦截 Copilot 免费次数提示
  vim.ui.select = function(items, opts, on_choice)
    -- 检测是否是 Copilot 的额度用尽/升级提示（根据实际弹窗文案调整关键词）
    local is_copilot_limit_prompt = false
    -- 1. 检查 prompt 关键词（弹窗标题）
    if opts and opts.prompt then
      local prompt = type(opts.prompt) == 'string' and opts.prompt or tostring(opts.prompt)
      is_copilot_limit_prompt = string.match(prompt, 'your monthly code completion limit')
    end

    -- 如果是目标提示，直接跳过（调用 on_choice 传递 nil，不显示弹窗）
    if is_copilot_limit_prompt then
      M.disableCopilot()
      M.enableNeoCodeium()
      on_choice(nil, nil)
      return
    end

    -- 非目标弹窗，调用 snacks.nvim 的原始 picker
    original_snacks_select(items, opts, on_choice)
  end
end

M.disableCopilot = function()
  vim.cmd([[Copilot disable]])

  vim.keymap.del('i', '<C-l>')
  vim.keymap.del('i', '<C-j>')
  vim.keymap.del('i', '<C-k>')
  vim.keymap.del('i', '<C-]>')
end

M.enableNeoCodeium = function()
  vim.cmd([[NeoCodeium enable]])

  local neocodeium = require('neocodeium')

  vim.keymap.set('i', '<C-l>', neocodeium.accept)
  vim.keymap.set('i', '<C-j>', function()
    neocodeium.cycle_or_complete()
  end)
  vim.keymap.set('i', '<C-k>', function()
    neocodeium.cycle_or_complete(-1)
  end)
  vim.keymap.set('i', '<C-]>', function()
    neocodeium.clear()
  end)
end

return M
