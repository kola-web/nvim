-- 定义一个变量来跟踪当前编译状态
local auto_compile_enabled = false
-- 用于保存自动命令的 ID
local autocmd_id = nil

-- 创建一个函数来切换编译状态
return function()
  auto_compile_enabled = not auto_compile_enabled

  if auto_compile_enabled then
    -- 创建自动命令
    autocmd_id = vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = '*.scss',
      callback = function()
        -- 使用 'sass' 命令编译 SCSS 文件到 CSS 文件
        vim.cmd('silent !sass --no-source-map ' .. vim.fn.expand('%:p') .. ' ' .. vim.fn.expand('%:r') .. '.css')
      end,
    })
    print('自动编译已启用')
  else
    -- 删除自动命令
    if autocmd_id then
      vim.api.nvim_del_autocmd(autocmd_id)
      autocmd_id = nil
    end
    print('自动编译已停止')
  end
end
