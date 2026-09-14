-- render-markdown.nvim：nvim 内 markdown 渲染（就地渲染 + 右分屏预览）
-- 用法：
--   <leader>od  切换「左编辑右预览」分屏（右侧渲染视图，左侧正常编辑）
--   打开 markdown 文件默认自动就地渲染（表格/代码块/标题美化）
vim.pack.add({
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})

require('render-markdown').setup({
  -- 在哪些模式下保持渲染视图；加入 'i' 使 insert 模式也渲染，不切回源码
  render_modes = { 'n', 'c', 't', 'i' },
  -- 防抖时间：默认 100ms，调大降低滚动时的重绘频率（避免长按 j/k 闪烁）
  debounce = 200,
  anti_conceal = {
    enabled = true,
    -- normal 模式下光标行不切回原始文本（滚动时不再反复增删 extmark，消除闪烁）；
    -- 编辑时进 insert 模式仍会显示原文
    disabled_modes = { 'n' },
  },
  code = {
    -- 不隐藏代码块首尾的 ``` 分隔符：否则滚动到代码块边缘会触发 conceal 重绘导致闪烁
    conceal_delimiters = false,
    -- 不渲染依赖虚拟行的代码块上下边框（同样避免滚动到代码块边缘时重绘）
    border = 'none',
    -- 背景不跳过首尾行：让 ``` 分隔符也处在高亮块内（默认 1 会跳过，导致 ``` 露在高亮块外）
    background_inset = 0,
  },
  overrides = {
    preview = {
      -- 预览分屏 buffer 在所有模式下都渲染
      render_modes = true,
    },
  },
})

-- 左编辑右预览：切换（再按一次关闭预览）
vim.keymap.set('n', '<leader>vm', function()
  require('render-markdown').preview()
end, { desc = 'Toggle markdown preview (right split)' })
