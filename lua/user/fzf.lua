local M = {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
}

function M.config()
  local status_ok, fzf = pcall(require, "fzf-lua")
  if not status_ok then
    return
  end

  fzf.setup {
    "telescope",
    files = {
      rg_opts = "--color=always --smart-case -g '!{.git,node_modules,miniprogram_npm,.yarn,static,.svn}'",
      fd_opts = "--color=never --type f --hidden --follow --exclude '{.git,node_modules,miniprogram_npm,.yarn,static,.svn}'",
    },
  }
end

return M
