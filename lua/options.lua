-- 这个文件由 plugins.core 自动加载
vim.g.mapleader = vim.g.vscode and '\\' or ' '
vim.g.maplocalleader = '\\'

-- LazyVim 根目录检测
-- 每个条目可以是：
-- * 检测器函数的名称，例如 `lsp` 或 `cwd`
-- * 一个或多个模式，例如 `.git` 或 `lua`
-- * 一个函数，签名为 `function(buf) -> string|string[]`
-- vim.g.root_spec = { 'lsp', { '.git', 'lua' }, 'cwd' }

local opt = vim.opt

opt.autowrite = true -- 启用自动保存
-- 仅在非 SSH 环境下设置剪贴板，以确保 OSC 52 集成可以自动工作。需要 Neovim >= 0.10.0
opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' -- 与系统剪贴板同步
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 0 -- 隐藏 * 标记用于粗体和斜体，但不隐藏带有替换标记的文本
opt.confirm = true -- 在退出修改过的缓冲区时确认是否保存
opt.cursorline = true -- 启用当前行高亮
opt.expandtab = true -- 使用空格代替制表符
opt.fillchars = {
  diff = '╱', -- 显示差异的字符
  eob = ' ', -- 末尾空白的字符
}

opt.foldenable = true
opt.foldmethod = 'indent' -- 设置折叠方法为按缩进折叠
opt.foldlevel = 99 -- 设置折叠级别为 99，表示不折叠
opt.foldlevelstart = 9 -- 设置折叠级别开始为 1
opt.formatoptions = 'jcroqlnt' -- 设置格式化选项
opt.grepformat = '%f:%l:%c:%m' -- 设置 grep 输出格式
opt.grepprg = 'rg --vimgrep' -- 使用 ripgrep 作为 grep 程序
opt.ignorecase = true -- 搜索时忽略大小写
opt.inccommand = 'nosplit' -- 增量替换预览，不分割窗口
opt.iskeyword:append('-,#') -- 将包含 `-,#` 的单词视为一个单词
opt.jumpoptions = 'view' -- 跳转时使用视图
opt.laststatus = 3 -- 启用全局状态栏
opt.linebreak = true -- 在适当位置换行
opt.list = true -- 显示一些不可见字符（如制表符）
opt.mouse = 'a' -- 启用鼠标模式
opt.number = true -- 显示行号
opt.pumblend = 10 -- 设置弹出窗口的透明度
opt.pumheight = 10 -- 设置弹出窗口中最大显示条目的数量
opt.relativenumber = true -- 显示相对行号
opt.ruler = false -- 禁用默认的光标位置显示
opt.scrolloff = 4 -- 设置上下文行数
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' } -- 设置会话选项
opt.shiftround = true -- 使缩进对齐时舍入到最近的倍数
opt.shiftwidth = 2 -- 设置每次缩进的空格数
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- 设置短消息选项
opt.showmode = false -- 不显示模式，因为我们已经有状态栏显示模式
opt.sidescrolloff = 8 -- 设置水平滚动时的上下文列数
opt.signcolumn = 'yes' -- 始终显示符号列，否则每次符号显示时文本会偏移
opt.smartcase = true -- 启用智能大小写：如果搜索中有大写字母，则不忽略大小写
opt.smartindent = true -- 自动插入缩进
opt.smoothscroll = true -- 启用平滑滚动
opt.spelllang = { 'en' } -- 设置拼写检查语言为英语
opt.splitbelow = true -- 新窗口放在当前窗口下方
opt.splitkeep = 'screen' -- 保持分屏时当前屏幕内容
opt.splitright = true -- 新窗口放在当前窗口右侧
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]] -- 设置状态列
opt.tabstop = 2 -- 设置制表符的宽度
opt.termguicolors = true -- 启用真彩色支持
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- 设置超时长度为 300（小于默认的 1000），以便快速触发 which-key
opt.undofile = true -- 启用撤销文件
opt.undolevels = 10000 -- 设置撤销的最大层数
opt.updatetime = 200 -- 设置更新间隔为 200ms，保存交换文件并触发 CursorHold
opt.virtualedit = 'block' -- 允许光标在视觉块模式下移动到没有文本的位置
opt.wildmode = 'longest:full,full' -- 命令行补全模式
opt.winminwidth = 5 -- 设置最小窗口宽度
opt.wrap = false -- 禁用自动换行
-- 图形化界面
opt.guifont = 'Maple Mono NF CN:h12' -- 在图形化的 neovim 应用程序中使用的字体

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
