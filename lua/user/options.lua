vim.opt.backup = false                          -- 不创建备份文件
vim.opt.clipboard = 'unnamedplus'               -- 允许 Neovim 访问系统剪贴板
vim.opt.cmdheight = 1                           -- 命令行高度，用于显示信息
vim.opt.completeopt = { 'menuone', 'noselect' } -- 自动补全菜单选项
vim.opt.conceallevel = 0                        -- 在 markdown 文件中显示 `` 符号
vim.opt.fileencoding = 'utf-8'                  -- 文件编码为 UTF-8
vim.opt.hlsearch = true                         -- 高亮搜索结果
vim.opt.ignorecase = false                      -- 忽略搜索中的大小写
vim.opt.mouse = 'a'                             -- 允许使用鼠标
vim.opt.pumheight = 10                          -- 弹出菜单的高度
vim.opt.showmode = false                        -- 隐藏 -- INSERT -- 等模式信息
vim.opt.showtabline = 0                         -- 总是显示标签页
vim.opt.smartcase = true                        -- 智能匹配大小写
vim.opt.smartindent = true                      -- 智能缩进
vim.opt.splitbelow = true                       -- 水平分屏在下方
vim.opt.splitright = true                       -- 垂直分屏在右侧
vim.opt.swapfile = false                        -- 不创建交换文件
vim.opt.termguicolors = true                    -- 支持终端图形颜色
vim.opt.timeoutlen = 1000                       -- 映射键时等待的时间（毫秒）
vim.opt.undofile = true                         -- 启用持久化撤销
vim.opt.updatetime = 250                        -- 自动完成等待时间（默认为 4000 毫秒）
vim.opt.writebackup = false                     -- 如果文件正在被其他程序编辑（或在编辑时写入文件），则不允许编辑
vim.opt.expandtab = true                        -- 将制表符转换为空格
vim.opt.shiftwidth = 2                          -- 每次缩进的空格数
vim.opt.tabstop = 2                             -- 缩进时的空格数
vim.opt.cursorline = true                       -- 高亮当前行
vim.opt.number = true                           -- 显示行号
vim.opt.relativenumber = true
vim.opt.laststatus = 3                          -- 只有最后一个窗口始终显示状态栏
vim.opt.showcmd = false                         -- 隐藏命令行中的（部分）命令
vim.opt.ruler = false                           -- 隐藏光标所在位置的行号和列号
vim.opt.numberwidth = 4                         -- 行号最小宽度（默认为 4）
vim.opt.signcolumn = 'yes'                      -- 总是显示标记列
vim.opt.wrap = false                            -- 将行作为一行显示
vim.opt.scrolloff = 8                           -- 光标距离屏幕顶部和底部的最小行数
vim.opt.sidescrolloff = 8                       -- 当 wrap=false 时，光标距离屏幕左侧和
vim.opt.guifont = 'FiraCode Nerd Font:h17'      -- 在图形化的 neovim 应用程序中使用的字体
vim.opt.fillchars.eob = ' '                     -- 将缓冲区末尾的空行显示为 ` `，默认为 `~`
vim.opt.shortmess:append 'c'                    -- 隐藏所有的自动完成信息，例如 "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.whichwrap:append '<,>,[,],h,l'          -- 允许在到达行首/行尾时使用的键
vim.opt.iskeyword:append '-,#'                  -- 将包含 `-,#` 的单词视为单个单词
vim.opt.formatoptions:remove { 'c', 'r', 'o' }  -- 这是一个描述自动格式化方式的字母序列
vim.opt.linebreak = true                        -- 自动将行换行
vim.opt.foldmethod = 'indent'                   -- 使用缩进来自动折叠代码块
vim.opt.foldlevel = 99                          -- 打开文件时默认折叠级别
vim.o.background = 'dark'                       -- 设置背景颜色为深色模式，或设置为 "light" 来使用浅色模式

-- neovide
if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_cursor_vfx_mode = ''
  vim.g.neovide_cursor_animation_length = 0

  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('t', '<D-v>', [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true })
  vim.keymap.set('i', '<D-v>', '<ESC>"+pA') -- Paste insert mode
  vim.opt.linespace = 14
end

