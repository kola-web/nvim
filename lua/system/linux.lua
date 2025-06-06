vim.g.mini_file_mini_component = function(state)
  local file = MiniFiles.get_explorer_state().branch
  local currentPath = file[#file]
  vim.fn.system({
    'cp',
    '-R',
    '/Users/lijialin/.config/nvim/template/' .. 'wxmlComponent',
    currentPath,
  })
  MiniFiles.synchronize()
end

vim.g.mini_file_mini_page = function(state)
  local file = MiniFiles.get_explorer_state().branch
  local currentPath = file[#file]
  vim.fn.system({
    'cp',
    '-R',
    '/Users/lijialin/.config/nvim/template/' .. 'wxmlPage',
    currentPath,
  })
  MiniFiles.synchronize()
end
