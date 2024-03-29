local M = {
  'ibhagwan/fzf-lua',
  event = 'VeryLazy',
}

function M.config()
  local status_ok, fzf = pcall(require, 'fzf-lua')
  if not status_ok then
    return
  end

  fzf.setup({
    fzf_opts = {
      ['--layout'] = 'default',
      ['--marker'] = '+',
      ['--border'] = 'none',
      ['--padding'] = '0%',
      ['--margin'] = '0%',
      ['--no-separator'] = '',
      ['--preview-window'] = 'up,50%',
      ['--info'] = 'default',
    },
    winopts = {},
    fzf_colors = {
      ['bg'] = '-1',
    },
    files = {
      find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/.git/*' -not -path '*/node_modules/*' -not -path '*/miniprogram_npm/*' -not -path '*/.yarn/*' -not -path '*/static/*' -not -path '*/.svn/*' --not -path '*/statics/*' --not -path '*/dist/*']],
      rg_opts = "--color=never --files --hidden --follow -g '!{.git,node_modules,miniprogram_npm,.yarn,static,.svn,statics,dist}'",
      fd_opts = "--color=never --type f --hidden --follow --exclude '{.git,node_modules,miniprogram_npm,.yarn,static,.svn,statics,dist}'",
    },
  })
end

return M
