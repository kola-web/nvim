-- ~/.config/nvim/ftplugin/markdown.lua
-- 仅markdown缓冲区生效

local opts = { buffer = 0, noremap = true, silent = true }

--- 将剪贴板TSV粘贴转换为Markdown表格
local function PasteTsvToMdTable()
  local text = vim.fn.getreg('+')
  local lines = vim.split(text, '\n')
  local out = {}
  for _, line in ipairs(lines) do
    if line ~= '' then
      local row = '| ' .. string.gsub(line, '\t', ' | ') .. ' |'
      table.insert(out, row)
    end
  end
  if #out == 0 then
    return
  end
  -- 生成标准md表格分隔行
  local sep_parts = {}
  for _ in string.gmatch(out[1], '|') do
    table.insert(sep_parts, '---')
  end
  local sep_line = table.concat(sep_parts, ' ')
  table.insert(out, 2, sep_line)

  vim.api.nvim_put(out, 'l', true, true)
end

--- 可视模式复制md片段，携带ZedAI @file#Lxx-Lyy 引用到系统剪贴板
local function zed_ai_yank_selection()
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' and mode ~= '\22' then
    vim.notify('请先在可视模式选中md片段', vim.log.levels.WARN)
    return
  end
  local start_pos = vim.fn.getpos('v')
  local end_pos = vim.fn.getpos('.')
  local start_line = math.min(start_pos[2], end_pos[2])
  local end_line = math.max(start_pos[2], end_pos[2])
  local filepath = vim.fn.expand('%:p')
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local selected_text = table.concat(lines, '\n')
  local zed_context = string.format('@%s#L%d-L%d\n%s', filepath, start_line, end_line, selected_text)
  vim.fn.setreg('+', zed_context)
  vim.notify(string.format('ZedAI上下文已复制 %s#L%d-L%d', vim.fn.expand('%:t'), start_line, end_line))
end

-- 外部预览peek快捷键（命令定义放在init.lua）
vim.keymap.set('n', '<leader>qo', ':PeekOpen<CR>', vim.tbl_extend('force', opts, { desc = 'Markdown: PeekOpen browser preview' }))
vim.keymap.set('n', '<leader>qc', ':PeekClose<CR>', vim.tbl_extend('force', opts, { desc = 'Markdown: PeekClose browser preview' }))

-- TSV粘贴转md表格
vim.keymap.set('n', '<leader>rm', PasteTsvToMdTable, vim.tbl_extend('force', opts, { desc = 'Markdown: Paste TSV to markdown table' }))

-- <++> 占位符跳转
vim.keymap.set('i', ',f', '<Esc>/<++><CR>:nohlsearch<CR>"_c4l', vim.tbl_extend('force', opts, { desc = 'Markdown: jump to <++> placeholder' }))
vim.keymap.set('i', '<C-e>', '<Esc>/<++><CR>:nohlsearch<CR>"_c4l', vim.tbl_extend('force', opts, { desc = 'Markdown: jump to <++> placeholder' }))
vim.keymap.set('i', ',w', '<Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>', vim.tbl_extend('force', opts, { desc = 'Markdown: jump to space + <++> placeholder' }))

-- 分隔线
vim.keymap.set('i', ',n', '---<CR><CR>', vim.tbl_extend('force', opts, { desc = 'Markdown: insert hr ---' }))
vim.keymap.set('i', ',l', '--------<CR>', vim.tbl_extend('force', opts, { desc = 'Markdown: insert long hr' }))

-- 文本格式：粗体、删除线、斜体、行内代码
vim.keymap.set('i', ',b', '**** <++><Esc>F*hi', vim.tbl_extend('force', opts, { desc = 'Markdown: bold' }))
vim.keymap.set('i', ',s', '~~~~ <++><Esc>F~hi', vim.tbl_extend('force', opts, { desc = 'Markdown: strikethrough' }))
vim.keymap.set('i', ',i', '** <++><Esc>F*i', vim.tbl_extend('force', opts, { desc = 'Markdown: italic' }))
vim.keymap.set('i', ',d', '`` <++><Esc>F`i', vim.tbl_extend('force', opts, { desc = 'Markdown: inline code' }))

-- 代码块
vim.keymap.set('i', ',c', '```<CR><++><CR>```<CR><CR><++><Esc>4kA', vim.tbl_extend('force', opts, { desc = 'Markdown: code block' }))

-- 复选任务列表
vim.keymap.set('i', ',m', '- [ ] ', vim.tbl_extend('force', opts, { desc = 'Markdown: checkbox task' }))

-- 图片、链接
vim.keymap.set('i', ',p', '![](<++>) <++><Esc>F[a', vim.tbl_extend('force', opts, { desc = 'Markdown: image' }))
vim.keymap.set('i', ',a', '[](<++>) <++><Esc>F[a', vim.tbl_extend('force', opts, { desc = 'Markdown: link' }))

-- 标题 H1‑H4
vim.keymap.set('i', ',1', '# <CR><++><Esc>kA', vim.tbl_extend('force', opts, { desc = 'Markdown: h1 heading' }))
vim.keymap.set('i', ',2', '## <CR><++><Esc>kA', vim.tbl_extend('force', opts, { desc = 'Markdown: h2 heading' }))
vim.keymap.set('i', ',3', '### <CR><++><Esc>kA', vim.tbl_extend('force', opts, { desc = 'Markdown: h3 heading' }))
vim.keymap.set('i', ',4', '#### <CR><++><Esc>kA', vim.tbl_extend('force', opts, { desc = 'Markdown: h4 heading' }))

-- ZedAI 可视模式复制带文件行号引用
vim.keymap.set('v', '<leader>az', zed_ai_yank_selection, vim.tbl_extend('force', opts, { desc = 'Markdown: yank selection for ZedAI @file#Lxx-Lyy' }))
