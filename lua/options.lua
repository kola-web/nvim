-- 这个文件由 plugins.core 自动加载
vim.g.mapleader = ' ' -- 设置全局领导键为空格
vim.g.maplocalleader = ',' -- 设置本地领导键为逗号

-- LazyVim 根目录检测
-- 每个条目可以是：
-- * 检测器函数的名称，例如 `lsp` 或 `cwd`
-- * 一个或多个模式，例如 `.git` 或 `lua`
-- * 一个函数，签名为 `function(buf) -> string|string[]`
vim.g.root_spec = { 'lsp', { '.git', 'lua', '.svn' }, 'cwd' }

local opt = vim.opt

opt.autowrite = true -- 启用自动写入

opt.undofile = true -- 启用持久化撤销（另见 `:h undodir`）

opt.backup = false -- 在覆盖文件时不创建备份
opt.writebackup = false -- 在覆盖文件时不创建写入备份

vim.cmd('filetype plugin indent on') -- 启用文件类型插件和自动缩进

opt.breakindent = true -- 使断行与行首对齐
opt.linebreak = true -- 如果设置了 `wrap`，则在 'breakat' 处换行

opt.ruler = false -- 不在命令行中显示光标位置
opt.showmode = false -- 不显示模式，因为我们有状态栏
opt.wrap = false -- 将长行显示为单行

opt.signcolumn = 'yes' -- 始终显示标记列（否则会导致文本位移）
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

opt.ignorecase = true -- 搜索时忽略大小写（使用 `\C` 强制区分大小写）
opt.incsearch = true -- 输入时显示搜索结果
opt.infercase = true -- 推断字母大小写以获得更丰富的内置关键字补全
opt.smartcase = true -- 如果搜索模式包含大写字母，则不忽略大小写
opt.smartindent = true -- 使缩进更加智能

opt.completeopt = 'menu,menuone,noselect' -- 补全选项设置
opt.virtualedit = 'block' -- 允许在可视块模式下超出行尾
opt.formatoptions = 'qjl1' -- 不自动格式化注释

opt.splitbelow = true -- 将新窗口置于当前窗口下方
opt.splitright = true -- 将新窗口置于当前窗口右侧

opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- 减少命令行消息
opt.splitkeep = 'screen' -- 减少窗口拆分时的滚动

opt.pumblend = 10 -- 使内置补全菜单稍微透明
opt.pumheight = 10 -- 使弹出菜单更小
opt.winblend = 10 -- 使浮动窗口稍微透明

opt.list = true -- 显示一些辅助符号
opt.listchars = {
  tab = '> ',
  extends = '…',
  precedes = '…',
  nbsp = '␣',
} -- 定义要显示的辅助符号

opt.clipboard = 'unnamedplus' -- 同步到系统剪贴板

opt.confirm = true -- 退出已修改的缓冲区前确认保存更改
opt.cursorline = true -- 启用当前行高亮
opt.expandtab = true -- 使用空格而不是制表符
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.inccommand = 'nosplit' -- 预览增量替换
opt.iskeyword:append('-,#') -- 将包含 `-,#` 的单词视为单个单词
opt.jumpoptions = 'view'
opt.laststatus = 3 -- 全局状态栏
opt.mouse = 'a' -- 启用鼠标模式

opt.number = true -- 显示行号
opt.relativenumber = true -- 相对行号

opt.scrolloff = 4 -- 上下文行数
opt.winminwidth = 5 -- 最小窗口宽度
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

opt.tabstop = 2 -- 制表符的空格数量
opt.shiftround = true -- 缩进对齐
opt.shiftwidth = 2 -- 缩进的大小
opt.sidescrolloff = 8 -- 左右文档列数

opt.spelllang = { 'en', 'cjk' }
opt.spelloptions:append('noplainbuffer,camel')

opt.termguicolors = true -- 真彩色支持
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- 比默认值低（1000），以快速触发 which-key

opt.undolevels = 10000 -- 设置撤销级别
opt.updatetime = 200 -- 保存交换文件并触发 CursorHold 的时间间隔

opt.wildmode = 'longest:full,full' -- 命令行补全模式

-- opt.whichwrap:append('<,>,[,],h,l') -- 允许在到达行首/行尾时使用的键

-- 图形化界面
opt.guifont = 'JetBrainsMono Nerd Font:h10' -- 在图形化的 neovim 应用程序中使用的字体

-- opt.foldtext = ''
-- opt.foldmethod = 'expr'
-- opt.foldexpr = 'nvim_treesitter#foldexpr()' -- 使用 Treesitter 的表达式进行折叠

opt.foldenable = true -- 启用折叠
opt.foldmethod = 'indent' -- 折叠方法设置为基于缩进
opt.foldlevel = 99 -- 设置折叠级别
opt.foldlevelstart = 99 -- 启动时的折叠级别
opt.foldnestmax = 30 -- 最大嵌套折叠级别

if vim.g.neovide then
  -- 在 Neovide 中才执行的设置
  vim.g.neovide_scale_factor = 1.4 -- Neovide 的缩放因子
  vim.g.neovide_refresh_rate = 60 -- Neovide 的刷新率
  vim.g.neovide_cursor_animation_length = 0 -- 关闭光标动画
  vim.g.neovide_scroll_animation_length = 0 -- 关闭滚动动画
  vim.g.neovide_scroll_animation_far_lines = 0 -- 关闭滚动动画的远距离效果
  vim.g.neovide_no_idle = false -- 禁用空闲时优化

  vim.keymap.set({ 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' }, '<D-v>', function()
    vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) -- 将剪贴板内容粘贴到 Neovim
  end, { noremap = true, silent = true })
end

if vim.g.vscode then
  local vscode = require('vscode-neovim') -- 加载 vscode-neovim 插件
  vim.notify = vscode.notify -- 使用 vscode 的通知方法
end
