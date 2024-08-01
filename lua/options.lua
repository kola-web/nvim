vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.opt.backup = false -- 禁用备份文件的生成
vim.opt.clipboard = 'unnamedplus' -- 启用 unnamedplus
vim.opt.completeopt = 'menu,menuone,noinsert,noselect' -- 设置补全选项：显示菜单、至少一个匹配项、使用弹出窗口
vim.opt.confirm = true -- 在关闭未保存的文件时提示确认
vim.opt.cursorline = true -- 高亮显示当前行
vim.opt.expandtab = true -- 将制表符转换为空格
vim.opt.fileencoding = 'utf-8' -- 设置文件编码为 UTF-8
vim.opt.grepprg = 'rg --vimgrep' -- 使用 ripgrep 作为 grep 的程序
vim.opt.ignorecase = true -- 搜索时忽略大小写
vim.opt.inccommand = 'nosplit' -- 实时替换，但不分割窗口
vim.opt.list = true -- 启用特殊字符的显示（如制表符、空格）
vim.opt.mouse = 'nv' -- 启用鼠标支持，模式为 normal 和 visual
vim.opt.number = true -- 显示行号
vim.opt.pumheight = 10 -- 弹出菜单的最大高度为 10 行
vim.opt.relativenumber = true -- 启用相对行号显示
vim.opt.swapfile = false -- 禁用交换文件
vim.opt.scrolloff = 4 -- 光标上下移动时，保持至少 4 行的缓冲区
vim.opt.shiftround = true -- 缩进时将缩进对齐到最近的 shiftwidth 的倍数
vim.opt.shiftwidth = 2 -- 设置自动缩进的宽度为 2 个空格
vim.opt.showmode = false -- 不显示当前模式（如插入、命令等）
vim.opt.sidescrolloff = 8 -- 左右移动时，保持至少 8 列的缓冲区
vim.opt.signcolumn = 'yes' -- 始终显示符号列（如断点、诊断信息）
vim.opt.smartcase = true -- 启用智能大小写匹配
vim.opt.smartindent = true -- 启用智能缩进
vim.opt.spelloptions = 'camel' -- 拼写检查时支持 camelCase
vim.opt.spelllang = { 'en', 'cjk' } -- 拼写检查的语言设置为英语和中日韩字符
vim.opt.splitbelow = true -- 垂直分割窗口时，新窗口在下方
vim.opt.tabstop = 2 -- 设置制表符宽度为 2 个空格
vim.opt.termguicolors = true -- 启用真彩色支持
vim.opt.timeoutlen = 1000 -- 设置映射序列的超时时间为 1000 毫秒
vim.opt.undofile = true -- 启用撤销文件，保存撤销历史
vim.opt.undolevels = 1000 -- 设置最大撤销级别为 1000
vim.opt.updatetime = 200 -- 设置更新间隔为 200 毫秒
vim.opt.iskeyword:append('-,#') -- 将连字符和井号作为关键词的一部分
vim.opt.wildmode = 'longest:full,full' -- 设置命令行补全模式为最长匹配项和完整补全
vim.opt.wrap = false -- 禁用自动换行

-- gui
vim.opt.guifont = 'JetBrainsMono Nerd Font:h10' -- 在图形化的 neovim 应用程序中使用的字体

vim.o.foldcolumn = '0'
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'indent'
-- vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.g.editorconfig = true
vim.g.markdown_recommended_style = 0

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_scale_factor = 1.4
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_no_idle = false

  vim.keymap.set({ 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' }, '<D-v>', function()
    vim.api.nvim_paste(vim.fn.getreg('+'), true, -1)
  end, { noremap = true, silent = true })
end

if vim.g.vscode then
  local vscode = require('vscode-neovim')
  vim.notify = vscode.notify
end
