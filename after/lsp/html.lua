return {
  filetypes = { 'html' },
  init_options = {
    configurationSection = { 'html', 'css', 'javascript' },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = false,
    dataPaths = {
      vim.fn.stdpath('config') .. '/html/wxml-data.json',
    },
  },
  handlers = {
    ['html/customDataContent'] = function(err, result, ctx, config)
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
