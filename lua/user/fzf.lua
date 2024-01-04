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
    'telescope',
    -- 'fzf-tmux',
    files = {
      find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/.git/*' -not -path '*/node_modules/*' -not -path '*/miniprogram_npm/*' -not -path '*/.yarn/*' -not -path '*/static/*' -not -path '*/.svn/*' --not -path '*/statics/*']],
      rg_opts = "--color=never --files --hidden --follow -g '!{.git,node_modules,miniprogram_npm,.yarn,static,.svn,statics}'",
      fd_opts = "--color=never --type f --hidden --follow --exclude '{.git,node_modules,miniprogram_npm,.yarn,static,.svn,statics}'",
    },
    -- winopts = {
    -- Use **only one** of the below options
    -- split = 'belowright new', -- open in split below current window
    -- },
  })
end

return M
