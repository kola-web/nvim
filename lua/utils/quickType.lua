local M = {
  generate_type = function()
    local Popup = require('nui.popup')
    local Layout = require('nui.layout')

    local popup_one, popup_two =
      Popup({
        enter = true,
        focusable = true,
        buf_options = {
          filetype = 'json',
          modifiable = true,
          readonly = false,
        },
        border = {
          style = 'rounded',
          text = {
            top = '输入',
            top_align = 'center',
          },
        },
      }), Popup({
        buf_options = {
          filetype = 'typescript',
          modifiable = true,
          readonly = false,
        },
        border = {
          style = 'rounded',
          text = {
            top = '输出',
            top_align = 'center',
          },
        },
      })

    local layout = Layout(
      {
        position = '50%',
        relative = 'editor',
        size = {
          width = '80%',
          height = '60%',
        },
      },
      Layout.Box({
        Layout.Box(popup_one, { size = '50%' }),
        Layout.Box(popup_two, { size = '50%' }),
      })
    )
    local function convert_json_to_typescript(json)
      local cmd = 'quicktype -l typescript --just-types --top-level Person'
      local output = vim.fn.system(cmd, json)
      return output
    end

    layout:mount()

    popup_one:map('n', '<cr>', function()
      local buf = vim.api.nvim_get_current_buf()
      local all_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local json_content = table.concat(all_lines, '\n')
      local tsInterface = convert_json_to_typescript(json_content)
      vim.api.nvim_buf_set_lines(popup_two.bufnr, 0, -1, false, vim.split(tsInterface, '\n'))
      vim.api.nvim_set_current_win(popup_two.winid)
    end, { noremap = true })
    popup_two:map('n', '<cr>', function()
      local lines = vim.api.nvim_buf_get_lines(popup_two.bufnr, 0, -1, false)
      vim.fn.setreg('+', table.concat(lines, '\n'))
      layout:unmount()
    end, { noremap = true })

    popup_one:map('n', '<tab>', function()
      vim.api.nvim_set_current_win(popup_two.winid)
    end, { noremap = true })
    popup_two:map('n', '<tab>', function()
      vim.api.nvim_set_current_win(popup_one.winid)
    end, { noremap = true })

    popup_one:map('n', 'q', function()
      layout:unmount()
    end, { noremap = true })
    popup_two:map('n', 'q', function()
      layout:unmount()
    end, { noremap = true })
  end,
}

return M
