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
      -- ['bg+'] = '-1',
    },
    -- fzf_colors = {
    --   ['fg'] = { 'fg', 'CursorLine' },
    --   ['bg'] = { 'bg', 'Normal' },
    --   ['hl'] = { 'fg', 'Comment' },
    --   ['fg+'] = { 'fg', 'Normal' },
    --   ['bg+'] = { 'bg', 'PmenuSel' },
    --   ['hl+'] = { 'fg', 'Statement', 'italic' },
    --   ['info'] = { 'fg', 'Comment', 'italic' },
    --   ['prompt'] = { 'fg', 'Underlined' },
    --   ['pointer'] = { 'fg', 'Exception' },
    --   ['marker'] = { 'fg', '@character' },
    --   ['spinner'] = { 'fg', 'DiagnosticOk' },
    --   ['header'] = { 'fg', 'Comment' },
    --   ['gutter'] = { 'bg', 'Normal' },
    --   ['separator'] = { 'fg', 'Comment' },
    -- },
    files = {
      find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/.git/*' -not -path '*/node_modules/*' -not -path '*/miniprogram_npm/*' -not -path '*/.yarn/*' -not -path '*/static/*' -not -path '*/.svn/*' --not -path '*/statics/*']],
      rg_opts = "--color=never --files --hidden --follow -g '!{.git,node_modules,miniprogram_npm,.yarn,static,.svn,statics}'",
      fd_opts = "--color=never --type f --hidden --follow --exclude '{.git,node_modules,miniprogram_npm,.yarn,static,.svn,statics}'",
    },
  })
end

return M
