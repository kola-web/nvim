-- 这个文件由 plugins.core 自动加载

-- ===========================
-- 基础配置与领导者键设置
-- ===========================
-- 设置领导者键：VSCode环境下使用反斜杠，否则使用空格
vim.g.mapleader = vim.g.vscode and '\\' or ' '
-- 设置局部领导者键
vim.g.maplocalleader = '\\'

vim.g.ai = 'NeoCodeium'

-- ===========================
-- 显示与界面设置
-- ===========================
-- 启用真彩色支持，使终端显示更丰富的颜色
vim.opt.termguicolors = true

-- 跳转时恢复窗口视图（如折叠、光标等），让 <C-o>/<C-i> 跳转更完整和直观
vim.opt.jumpoptions = 'view'

-- 行号设置
vim.opt.number = true -- 显示绝对行号
vim.opt.relativenumber = true -- 显示相对行号（便于快速跳转）
vim.opt.cursorline = true -- 高亮当前光标所在行

-- 标志列设置
vim.opt.signcolumn = 'yes' -- 始终显示左侧标志列（用于LSP提示等）

-- 状态栏与模式设置
vim.opt.showmode = false -- 不在底部显示模式（已在状态栏显示）
vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]] -- 自定义状态列

-- 滚动设置
vim.opt.scrolloff = 10 -- 光标上下方最少保留10行屏幕空间

-- ===========================
-- 编辑行为设置
-- ===========================
-- 鼠标支持
vim.opt.mouse = 'a' -- 启用所有模式下的鼠标支持（如调整分屏）

-- 剪贴板设置
-- 延迟设置以减少启动时间，同步系统剪贴板
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- 文本换行与缩进
vim.opt.wrap = false -- 禁用自动换行
vim.opt.breakindent = true -- 启用断行缩进（换行时保持缩进）

-- 单词识别设置
vim.opt.iskeyword:append('-,#') -- 将包含'-'和'#'的字符串视为完整单词

-- 搜索行为
vim.opt.ignorecase = true -- 搜索时忽略大小写
vim.opt.smartcase = true -- 当搜索词包含大写字母时自动区分大小写
vim.opt.inccommand = 'split' -- 实时预览替换效果

-- 撤销历史
vim.opt.undofile = true -- 保存撤销历史到文件
vim.opt.undolevels = 10000 -- 最大撤销层级

-- 操作确认
vim.opt.confirm = true -- 执行可能丢失数据的操作时弹出确认对话框

-- ===========================
-- 分屏与窗口设置
-- ===========================
-- 分屏方向
vim.opt.splitright = true -- 垂直分屏时新窗口在右侧
vim.opt.splitbelow = true -- 水平分屏时新窗口在下方

-- ===========================
-- 空白字符与缩进设置
-- ===========================
-- 空白字符显示
vim.opt.list = true -- 显示特殊空白字符
vim.opt.listchars = { -- 配置特殊空白字符的显示方式
  tab = '» ', -- 制表符显示为»+空格
  trail = '·', --  trailing空格显示为·
  nbsp = '␣', -- 非断行空格显示为␣
}

-- Tab与缩进设置
vim.opt.expandtab = true -- 使用空格代替制表符
vim.opt.shiftwidth = 2 -- 自动缩进的空格数
vim.opt.shiftround = true -- 缩进时对齐到最近的倍数
vim.opt.smartindent = true -- 自动智能缩进

-- ===========================
-- 性能与超时设置
-- ===========================
vim.opt.updatetime = 250 -- 事件更新时间（影响光标保持等功能）
vim.opt.timeoutlen = 300 -- 映射序列等待时间（影响快捷键响应）

-- ===========================
-- 折叠设置
-- ===========================
vim.opt.foldenable = true -- 启用折叠功能
vim.opt.foldmethod = 'indent' -- 基于缩进的折叠方式
vim.opt.foldlevel = 99 -- 折叠层级（99表示几乎不自动折叠）
vim.opt.foldlevelstart = 9 -- 打开文件时的初始折叠层级

-- ===========================
-- 拼写检查
-- ===========================
vim.opt.spelllang = { 'en', 'cjk' } -- 拼写检查支持英语和中日韩语言

-- ===========================
-- GUI 相关设置
-- ===========================
-- 图形化Neovim使用的字体设置
vim.opt.guifont = 'Maple Mono NF CN:h12'

-- ===========================
-- 插件相关设置
-- ===========================
-- 修复markdown默认缩进样式
vim.g.markdown_recommended_style = 0
