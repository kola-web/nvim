if not vim.g.vscode then
  return {}
end

local vscode = require('vscode-neovim')
vim.notify = vscode.notify

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local opt = vim.opt
local o = vim.o

opt.autowrite = true -- 启用自动写入
opt.backup = false -- 不创建备份文件
opt.completeopt = 'menu,menuone,noselect' -- 补全选项
opt.conceallevel = 0 -- 在 markdown 文件中显示 `` 符号
opt.confirm = true -- 在退出修改的缓冲区之前确认保存更改
opt.cursorline = true -- 启用当前行高亮
opt.expandtab = true -- 使用空格而不是制表符
opt.fileencoding = 'utf-8' -- 文件编码为 UTF-8
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m' -- grep 命令输出格式
opt.grepprg = 'rg --vimgrep' -- grep 命令
opt.ignorecase = true -- 忽略大小写
opt.inccommand = 'nosplit' -- 预览增量替换
opt.laststatus = 3 -- 全局状态行
opt.list = true -- 显示一些不可见字符（制表符等）
opt.mouse = 'a' -- 启用鼠标模式
opt.number = true -- 显示行号
opt.pumblend = 10 -- 弹出菜单透明度
opt.pumheight = 10 -- 弹出菜单中的最大条目数
opt.relativenumber = true -- 相对行号
opt.swapfile = false -- 不创建交换文件
opt.scrolloff = 4 -- 上下文行数
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' } -- 会话选项
opt.shiftround = true -- 缩进四舍五入
opt.shiftwidth = 2 -- 缩进大小
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- 简短消息选项
opt.showmode = false -- 不显示模式，因为有状态行
opt.sidescrolloff = 8 -- 上下文列数
opt.signcolumn = 'yes' -- 始终显示标志列，否则每次会移动文本
opt.smartcase = true -- 大小写匹配
opt.smartindent = true -- 自动插入缩进
opt.spelloptions = 'camel' -- 忽略驼峰单词
opt.spelllang = { 'en', 'cjk' } -- 拼写语言
opt.splitbelow = true -- 在当前窗口下方打开新窗口
opt.splitkeep = 'screen' -- 保持窗口布局
opt.splitright = true -- 在当前窗口右侧打开新窗口
opt.tabstop = 2 -- 制表符的空格数
opt.termguicolors = true -- 真彩色支持
opt.timeoutlen = 300 -- 默认超时长度为1000毫秒
opt.undofile = true -- 保存撤销历史
opt.undolevels = 10000 -- 可以撤销的最大更改次数
opt.whichwrap:append('<,>,[,],h,l') -- 允许在到达行首/行尾时使用的键
opt.iskeyword:append('-,#') -- 将包含 `-,#` 的单词视为单个单词
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- 窗口的最小宽度
opt.wrap = false -- 禁用换行

opt.foldmethod = 'indent' -- 使用缩进来自动折叠代码块
opt.foldlevel = 99 -- 打开文件时默认折叠级别
o.foldlevelstart = 99

return {}
