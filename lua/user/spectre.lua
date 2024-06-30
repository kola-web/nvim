local M = {
  {
    'MagicDuck/grug-far.nvim',
    opts = {
      keymaps = {
        replace = { n = '<localleader>r' },
        qflist = { n = '<localleader>q' },
        syncLocations = { n = '<localleader>s' },
        syncLine = { n = '<enter>' },
        close = { n = 'q' },
        historyOpen = { n = '<localleader>t' },
        historyAdd = { n = '<localleader>a' },
        refresh = { n = '<localleader>f' },
        gotoLocation = { n = 'o' },
        pickHistoryEntry = { n = '<enter>' },
        abort = { n = '<localleader>b' },
      },
    },
  },
}
return M
