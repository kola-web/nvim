-- render-markdown.nvim：nvim 内 markdown 渲染（右分屏预览）
-- 用法：
--   <leader>vm  切换「左编辑右预览」分屏（右侧渲染视图，左侧正常编辑）
--   markdown 默认不渲染（源码视图），仅分屏预览时渲染
vim.pack.add({
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})

require('render-markdown').setup({
  -- 默认不渲染：只有按 <leader>vm 打开分屏预览时才渲染
  enabled = false,
  -- 渲染范围：markdown 文件 + codecompanion 聊天界面（内容是 markdown，但 filetype 是 codecompanion）
  file_types = { 'markdown', 'codecompanion' },
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
      -- 预览右屏 buffer 强制渲染：全局 enabled=false 默认关闭渲染，
      -- 但右屏预览必须渲染（否则 split 出来没有预览效果）
      enabled = true,
      -- 预览分屏 buffer 在所有模式下都渲染
      render_modes = true,
    },
  },
})

-- 左编辑右预览：切换（再按一次关闭预览）
-- 自己维护开关状态：打开前源 buffer 先开启渲染（enabled=false 需手动 attach），
-- preview() 打开右屏后会自动关闭源渲染；关闭时删除右屏并把源设回不渲染
local md_preview_open = false
vim.keymap.set('n', '<leader>vm', function()
  local rmd = require('render-markdown')
  if md_preview_open then
    rmd.preview() -- 关闭右屏
    rmd.set_buf(false) -- 源 buffer 回到不渲染
    md_preview_open = false
  else
    rmd.set_buf(true) -- 源开启渲染（attach 后生效）
    rmd.preview() -- 打开右屏（内部会自动关闭源渲染）
    md_preview_open = true
  end
end, { desc = 'Toggle markdown preview (right split)' })

-- 兜底：预览右屏被任何方式关闭（如 :q、:bd）时，同步状态并把源 buffer 设回不渲染。
-- 官方 preview 在 BufWipeout 时会自动把源恢复渲染（enabled=true），这里需关回去，
-- 否则关闭预览后源会就地渲染，违背「默认不渲染、仅分屏预览」的设定。
vim.api.nvim_create_autocmd('BufWipeout', {
  callback = function()
    if not md_preview_open then
      return
    end
    vim.schedule(function()
      local pv = require('render-markdown.core.preview')
      local still_open = false
      for _, dst in pairs(pv.buffers) do
        if vim.api.nvim_buf_is_valid(dst) then
          still_open = true
          break
        end
      end
      if not still_open then
        md_preview_open = false
        pcall(require('render-markdown').set_buf, false)
      end
    end)
  end,
})
