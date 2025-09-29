return {
  filetypes = { 'css', 'scss', 'less' },
  init_options = {
    provideFormatter = false,
  },
  settings = {
    css = {
      customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/custom-data/css-data.json') },
    },
    scss = {
      customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/custom-data/css-data.json') },
    },
    less = {
      customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/custom-data/css-data.json') },
    },
  },
  handlers = {
    ['css/customDataChanged'] = function(err, result, ctx, config)
      local function exists(name)
        if type(name) ~= 'string' then
          return false
        end
        return os.execute('test -e ' .. name)
      end

      if not vim.tbl_isempty(result) and #result == 1 then
        if not exists(result[1]) then
          return ''
        end
        local content = vim.fn.join(vim.fn.readfile(result[1]), '\n')
        return content
      end
      return ''
    end,
  },
}
