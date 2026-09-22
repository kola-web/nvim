vim.pack.add({
  'https://github.com/stevearc/aerial.nvim',
})

local aerial = require('aerial')

-- 侧边符号大纲（替代 snacks picker 大纲 / 原 outline.nvim）
-- 折叠键（aerial 窗口内）：za/zo/zc/zA/zO/zC/zR/zM、h/l 展开收起
-- z1~z9 折叠到对应层级、z0 全部展开（与全局 foldlevel 语义一致，作用于符号树）
local aerial_keymaps = {}
for i = 1, 9 do
  aerial_keymaps['z' .. i] = {
    callback = function()
      aerial.tree_set_collapse_level(0, i)
    end,
    desc = '折叠到 ' .. i .. ' 级',
  }
end
aerial_keymaps['z0'] = 'actions.tree_open_all'

aerial.setup({
  -- markdown 优先用纯 markdown 后端（只提取标题、自动跳过代码块）；
  -- 其他语言按 treesitter → LSP 顺序
  backends = {
    markdown = { 'markdown' },
    default = { 'treesitter', 'lsp', 'markdown' },
  },
  layout = {
    max_width = { 40, 0.2 },
    min_width = 10,
    default_direction = 'left', -- 左侧侧边栏
    placement = 'window',
    resize_to_content = false,
  },
  -- 对齐 utils.kind_filter：默认显示常见代码符号；markdown 只显示标题
  filter_kind = {
    default = {
      'Class',
      'Constructor',
      'Enum',
      'Field',
      'Function',
      'Interface',
      'Method',
      'Module',
      'Namespace',
      'Package',
      'Property',
      'Struct',
      'Trait',
    },
    markdown = { 'Interface' },
    help = false,
  },
  keymaps = aerial_keymaps,
})

-- <leader>so 切换侧边大纲，打开后聚焦到 aerial 窗口
vim.keymap.set('n', '<leader>so', function()
  if aerial.is_open() then
    aerial.close()
  else
    aerial.open()
    aerial.focus() -- 聚焦到大纲窗口
  end
end, { desc = 'LSP Symbols (aerial)' })
