local status_ok, fzf = pcall(require, 'fzf-lua')
if not status_ok then
  return
end

fzf.setup {
  'telescope',
  files = {
    -- fd_opts = '--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude miniprogram_npm --exclude .yarn --exclude static',
    fd_opts = "--color=never --type f --hidden --follow --exclude '{.git,node_modules,miniprogram_npm,.yarn,static,.svn}'",
  },
}
