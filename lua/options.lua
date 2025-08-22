-- 这个文件由 plugins.core 自动加载
vim.g.mapleader = vim.g.vscode and '\\' or ' '
vim.g.maplocalleader = '\\'

-- 默认显示行号
vim.o.number = true
-- 你也可以添加相对行号，有助于跳转。
--  自己试试看是否喜欢！
vim.o.relativenumber = true

-- 启用鼠标模式，例如用于调整分屏大小！
vim.o.mouse = 'a'

-- 不显示模式，因为已经在状态栏显示了
vim.o.showmode = false

-- 同步操作系统和 Neovim 的剪贴板。
--  在 `UiEnter` 之后设置，因为可能会增加启动时间。
--  如果你希望操作系统剪贴板保持独立，可以移除此选项。
--  参见 `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- 启用断行缩进
vim.o.breakindent = true

-- 保存撤销历史
vim.o.undofile = true

-- 搜索时忽略大小写，除非搜索词中有 \C 或一个以上大写字母
vim.o.ignorecase = true
vim.o.smartcase = true

-- 默认保持标志列开启
vim.o.signcolumn = 'yes'

-- 减少更新时间
vim.o.updatetime = 250

-- 减少映射序列等待时间
vim.o.timeoutlen = 300

-- 配置新分屏的打开方式
vim.o.splitright = true
vim.o.splitbelow = true

-- 设置 Neovim 在编辑器中显示某些空白字符的方式。
--  参见 `:help 'list'`
--  和 `:help 'listchars'`
--
--  注意 listchars 使用 `vim.opt` 设置，而不是 `vim.o`。
--  它与 `vim.o` 非常相似，但为方便与表交互提供了接口。
--   参见 `:help lua-options`
--   和 `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- 实时预览替换效果
vim.o.inccommand = 'split'

-- 显示光标所在的行
vim.o.cursorline = true

-- 光标上下方最少保留的屏幕行数
vim.o.scrolloff = 10

-- 如果执行操作因缓冲区未保存而失败（如 `:q`），
-- 则弹出对话框询问是否保存当前文件
-- 参见 `:help 'confirm'`
vim.o.confirm = true

vim.o.foldenable = true
vim.o.foldmethod = 'indent' -- 设置折叠方法为按缩进折叠
vim.o.foldlevel = 99 -- 设置折叠级别为 99，表示不折叠
vim.o.foldlevelstart = 9 -- 设置折叠级别开始为 1

vim.opt.spelllang = { 'en', 'cjk' } -- 设置拼写检查语言为英语和中日韩

vim.o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]] -- 设置状态列

-- 图形化界面
vim.o.guifont = 'Maple Mono NF CN:h12' -- 在图形化的 neovim 应用程序中使用的字体

-- 修复 markdown 缩进设置
vim.g.markdown_recommended_style = 0
