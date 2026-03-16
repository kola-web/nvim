vim.g.mini_file_mini_component = function(state)
  local file = MiniFiles.get_explorer_state().branch
  local currentPath = file[#file]
  local templatePath = vim.fn.expand('~/.config/nvim/template/wxmlComponent')
  local destPath = currentPath .. '/wxmlComponent'

  -- 使用异步 job 避免阻塞
  vim.fn.jobstart({
    'cp',
    '-R',
    templatePath,
    currentPath,
  }, {
    on_exit = function(_, exit_code)
      vim.schedule(function()
        if exit_code == 0 then
          -- 移除只读属性（macOS 不需要像 Windows 那样处理，但保留兼容性）
          vim.fn.jobstart({
            'chmod',
            '-R',
            'u+w',
            destPath,
          }, {
            on_exit = function()
              vim.schedule(function()
                MiniFiles.synchronize()
                vim.notify('Component created successfully', vim.log.levels.INFO)
              end)
            end,
          })
        else
          vim.notify('Failed to create component', vim.log.levels.ERROR)
        end
      end)
    end,
  })
end

vim.g.mini_file_mini_page = function(state)
  local file = MiniFiles.get_explorer_state().branch
  local currentPath = file[#file]
  local templatePath = vim.fn.expand('~/.config/nvim/template/wxmlPage')
  local destPath = currentPath .. '/wxmlPage'

  -- 使用异步 job 避免阻塞
  vim.fn.jobstart({
    'cp',
    '-R',
    templatePath,
    currentPath,
  }, {
    on_exit = function(_, exit_code)
      vim.schedule(function()
        if exit_code == 0 then
          -- 移除只读属性（macOS 不需要像 Windows 那样处理，但保留兼容性）
          vim.fn.jobstart({
            'chmod',
            '-R',
            'u+w',
            destPath,
          }, {
            on_exit = function()
              vim.schedule(function()
                MiniFiles.synchronize()
                vim.notify('Page created successfully', vim.log.levels.INFO)
              end)
            end,
          })
        else
          vim.notify('Failed to create page', vim.log.levels.ERROR)
        end
      end)
    end,
  })
end
