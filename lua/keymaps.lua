local utils = require('utils')

-- Shorten function name

local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap('i', '<C-e>', '<End>', opts)
keymap('i', '<C-a>', '<Home>', opts)

-- better up/down
keymap({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
keymap({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
keymap({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
keymap({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
keymap('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })

-- Resize window using <ctrl> arrow keys
keymap('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
keymap('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
keymap('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
keymap('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- fold
keymap('n', 'z1', '<cmd>set foldlevel=1<cr>', { desc = 'Fold level 1' })
keymap('n', 'z2', '<cmd>set foldlevel=2<cr>', { desc = 'Fold level 2' })
keymap('n', 'z3', '<cmd>set foldlevel=3<cr>', { desc = 'Fold level 3' })
keymap('n', 'z4', '<cmd>set foldlevel=4<cr>', { desc = 'Fold level 4' })
keymap('n', 'z5', '<cmd>set foldlevel=5<cr>', { desc = 'Fold level 5' })
keymap('n', 'z6', '<cmd>set foldlevel=6<cr>', { desc = 'Fold level 6' })
keymap('n', 'z7', '<cmd>set foldlevel=7<cr>', { desc = 'Fold level 7' })
keymap('n', 'z8', '<cmd>set foldlevel=8<cr>', { desc = 'Fold level 8' })
keymap('n', 'z9', '<cmd>set foldlevel=9<cr>', { desc = 'Fold level 9' })
keymap('n', 'z0', '<cmd>set foldlevel=99<cr>', { desc = 'Fold level 99' })

-- All
keymap('', '<S-l>', '$', opts)
keymap('', '<S-h>', '^', opts)

keymap('n', 'BB', '<cmd>enew<cr>', opts)
-- keymap('n', 'BS', '<cmd>enew<cr><cmd>set filetype=json<cr>', opts)
-- keymap('n', 'BJ', '<cmd>enew<cr><cmd>set filetype=javascript<cr>', opts)
-- keymap('n', 'BT', '<cmd>enew<cr><cmd>set filetype=typescript<cr>', opts)
-- keymap('n', 'BV', '<cmd>enew<cr><cmd>set filetype=vue<cr>', opts)
-- keymap('n', 'BH', '<cmd>enew<cr><cmd>set filetype=html<cr>', opts)
-- keymap('n', 'BL', '<cmd>enew<cr><cmd>set filetype=lua<cr>', opts)

-- stylua: ignore start
keymap('n', 'BC', function() utils.scratch_open(vim.bo.filetype) end, opts)
keymap('n', 'BS', function() utils.scratch_open('json') end, opts)
keymap('n', 'BJ', function() utils.scratch_open('javascript') end, opts)
keymap('n', 'BT', function() utils.scratch_open('typescript') end, opts)
keymap('n', 'BV', function() utils.scratch_open('vue') end, opts)
keymap('n', 'BH', function() utils.scratch_open('html') end, opts)
keymap('n', 'BL', function() utils.scratch_open('lua') end, opts)
keymap('n', 'BP', function() utils.scratch_open('python') end, opts)
-- stylua: ignore end

-- vue jump
keymap('n', ']s', '/<script<cr>', opts)
keymap('n', ']c', '/<style<cr>', opts)

-- Navigate buffers
keymap('n', '<tab>', '<Cmd>bnext<CR>', opts)
keymap('n', '<S-tab>', '<Cmd>bprevious<CR>', opts)

-- add space line
keymap('n', ']<space>', "<Cmd>put =repeat(nr2char(10), v:count1) <Bar> '[-1<CR>", opts)
keymap('n', '[<space>', "<Cmd>put! =repeat(nr2char(10), v:count1) <Bar> ']+1<CR>", opts)

-- Better paste
keymap('v', 'p', '"_dP', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

keymap('n', '<leader>h', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / clear hlsearch / diff update' })

-- replace & complie
keymap('n', '<leader>rc', require('utils.compile_scss'), { desc = 'toggle scss compile' })
keymap('n', '<leader>rd', '<cmd>%s/<div/<view/g<cr><cmd>%s/<\\/div/<\\/view/g<cr>', { desc = 'div -> view' })
keymap('n', '<leader>rv', '<cmd>%s/<view/<div/g<cr><cmd>%s/<\\/view/<\\/div/g<cr>', { desc = 'view -> div' })
keymap('n', '<leader>rp', '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%d",submatch(1))."rpx"#g<cr>', { desc = 'px -> rpx' })
keymap('n', '<leader>rP', '<cmd>%s#\\(\\d\\+\\)rpx#\\=printf("%d",submatch(1))."px"#g<cr>', { desc = 'rpx -> px' })
keymap('n', '<leader>ro', '<cmd>%s#\\(\\d\\+\\)rpx#\\=printf("%d",submatch(1) / 2)."px"#g<cr>', { desc = 'rpx/2 -> px' })
keymap('n', '<leader>re', '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%f",submatch(1) / 100.0)."rem"#g<cr>', { desc = 'px -> rem' })
keymap('n', '<leader>rl', '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%.2f",submatch(1) / 1080.0 * 750)."px"#g<cr>', { desc = '1080px -> 750px' })
keymap('n', '<leader>rr', require('utils.quickType').generate_type, { desc = 'quicktype' })

vim.keymap.set({ 'n' }, '<leader>rt', require('utils').wrap_book_bracket_to_text_tag, {
  desc = '将光标所在《xxx》替换为 <text>xxx</text>',
})

keymap('n', '<leader>lv', function()
  utils.compare_to_clipboard()
end, { desc = 'diff clip' })

keymap('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
keymap('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix List' })

-- fzf-lua
keymap('t', '<esc>', [[<C-\><C-n>]])

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
keymap('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
keymap('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
keymap('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
keymap('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
keymap('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
keymap('i', ',', ',<c-g>u')
keymap('i', '.', '.<c-g>u')
keymap('i', ';', ';<c-g>u')
keymap('i', ':', ':<c-g>u')

keymap('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
keymap('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
keymap('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
keymap('n', '<leader><tab>n', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
keymap('n', '<leader><tab>c', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
keymap('n', '<leader><tab>p', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- save file
keymap('n', '<leader>w', '<Cmd>silent! update | redraw<CR>', { desc = 'save file' })

-- vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#<cr>", {desc="Close all buffers but the current one"}) -- https://stackoverflow.com/a/42071865/516188

-- terminal mappings
keymap('t', '<C-\\>', '<cmd>close<cr>', { desc = 'Hide Terminal' })

-- 按下 <leader>oz 用 Zed 打开当前项目、当前文件、定位到相同行
keymap('n', '<leader>oz', function()
  local file = vim.api.nvim_buf_get_name(0)
  local cwd = vim.fn.getcwd()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  -- zed 命令：zed [项目根目录] [文件:行号]
  local cmd = { 'zed', cwd, file .. ':' .. line }
  vim.fn.jobstart(cmd, { detach = true })
end, { desc = 'Open current file & project in Zed, keep cursor line' })

-- open in VSCode
keymap('n', '<leader>oc', function()
  local file = vim.api.nvim_buf_get_name(0)
  local cwd = vim.fn.getcwd()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local cmd = { 'code', cwd, '--goto', file .. ':' .. line }
  vim.fn.jobstart(cmd, { detach = true })
end, { desc = 'Open current file & project in VSCode, keep cursor line' })

-- open file explorer, compatible Windows / Mac / Linux
keymap('n', '<leader>oe', function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath == nil or filepath == '' then
    vim.notify('无文件buffer', vim.log.levels.WARN)
    return
  end

  -- ✨直接取nvim启动打开的文件夹 cwd
  local root_dir = vim.fn.getcwd()

  -- 跨平台打开资源管理器
  if vim.fn.has('win32') == 1 then
    vim.fn.system(string.format([[cmd /c start "" "%s"]], root_dir))
  elseif vim.fn.has('mac') == 1 then
    vim.fn.system({ 'open', root_dir })
  else
    vim.fn.system({ 'xdg-open', root_dir })
  end
end, { desc = 'Open folder in file explorer' })

-- SVN update 当前文件所在目录
keymap('n', '<leader>us', function()
  local cwd = vim.fn.expand('%:p:h')
  vim.notify('svn update: ' .. cwd, vim.log.levels.INFO)
  vim.fn.jobstart({ 'svn', 'update', cwd }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end
      -- 清除\r回车符，过滤空字符串
      local out = {}
      for _, line in ipairs(data) do
        local s = line:gsub('\r', '')
        if s ~= '' then
          table.insert(out, s)
        end
      end
      if #out > 0 then
        vim.notify(table.concat(out, '\n'), vim.log.levels.INFO)
      end
    end,
    on_stderr = function(_, data)
      if not data then
        return
      end
      local err = {}
      for _, line in ipairs(data) do
        local s = line:gsub('\r', '')
        if s ~= '' then
          table.insert(err, s)
        end
      end
      if #err > 0 then
        vim.notify(table.concat(err, '\n'), vim.log.levels.ERROR)
      end
    end,
  })
end, { desc = 'SVN update 当前文件目录', noremap = true, silent = false })

vim.keymap.set('n', '<leader>ug', function()
  local filepath = vim.fn.expand('%:p')
  if filepath == '' then
    vim.notify("没有打开文件，无法查找git仓库", vim.log.levels.WARN)
    return
  end

  local function find_nearest_git_root(start_path)
    local path = start_path
    while true do
      local git_dir = vim.fn.fnamemodify(path, ':p') .. '.git'
      if vim.fn.isdirectory(git_dir) == 1 then
        return vim.fn.fnamemodify(path, ':p')
      end
      local parent = vim.fn.fnamemodify(path, ':h')
      if parent == path then
        return nil
      end
      path = parent
    end
  end

  local git_root = find_nearest_git_root(vim.fn.fnamemodify(filepath, ':h'))
  if not git_root then
    vim.notify("未找到git仓库(.git)，向上遍历完毕", vim.log.levels.ERROR)
    return
  end

  vim.notify('git pull 最近仓库根目录: ' .. git_root, vim.log.levels.INFO)

  -- 增加 -c core.quotepath=false 关闭八进制文件名转义
  vim.fn.jobstart({ 'git', '-c','core.quotepath=false', '-C', git_root, 'pull' }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if not data then return end
      local out = {}
      for _, line in ipairs(data) do
        local s = line:gsub('\r', '')
        if s ~= '' then
          table.insert(out, s)
        end
      end
      if #out > 0 then
        vim.notify(table.concat(out, '\n'), vim.log.levels.INFO)
      end
    end,
    on_stderr = function(_, data)
      if not data then return end
      local err = {}
      for _, line in ipairs(data) do
        local s = line:gsub('\r', '')
        if s ~= '' then
          table.insert(err, s)
        end
      end
      if #err > 0 then
        vim.notify(table.concat(err, '\n'), vim.log.levels.ERROR)
      end
    end,
  })
end, { desc = 'Git pull：更新当前文件最近的git仓库', noremap = true, silent = false })
