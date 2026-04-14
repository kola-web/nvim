local ts_comments_ok, ts_comments = pcall(require, 'ts-comments')
if ts_comments_ok then
  ts_comments.setup({
    lang = {
      autohotkey = '; %s',
      ahk = '; %s',
      vue = {
        '<!-- %s -->',
        script_element = '// %s',
      },
    },
  })
end
