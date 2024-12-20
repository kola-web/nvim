vim.g.mini_file_mini_component = function(state)
  local file = MiniFiles.get_fs_entry()
  local currentPath = file.fs_type == 'directory' and file.path or string.gsub(file.path, '/' .. escape_pattern(file.name), '', 1)
  vim.fn.system({
    'cp',
    '-R',
    '/Users/lijialin/.config/nvim/template/' .. 'wxmlComponent',
    currentPath,
  })
  MiniFiles.synchronize()
end

vim.g.mini_file_mini_page = function(state)
  local file = MiniFiles.get_fs_entry()
  local currentPath = file.fs_type == 'directory' and file.path or string.gsub(file.path, '/' .. escape_pattern(file.name), '', 1)
  vim.fn.system({
    'cp',
    '-R',
    '/Users/lijialin/.config/nvim/template/' .. 'wxmlPage',
    currentPath,
  })
  MiniFiles.synchronize()
end
