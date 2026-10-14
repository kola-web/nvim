return {
  -- wxml 使用独立 filetype（见 filetype.lua），需显式纳入 html LSP 以保留 wxml-data 补全
  filetypes = { 'html', 'wxml' },
  init_options = {
    configurationSection = { 'html', 'css', 'javascript' },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = false,
    dataPaths = {
      vim.fn.stdpath('config') .. '/custom-data/wxml-data.json',
    },
  },
  handlers = {
    ['html/customDataContent'] = function(err, result, ctx, config)
      local function exists(name)
        if type(name) ~= 'string' then
          return false
        end
        return vim.uv.fs_stat(name) ~= nil
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
