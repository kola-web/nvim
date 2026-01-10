local M = {
  {
    'MagicDuck/grug-far.nvim',
    event = 'VeryLazy',
    cmd = 'GrugFar',
    opts = {
      headerMaxWidth = 80,
      engines = {
        ripgrep = {
          extraArgs = '-P',
        },
      },
      keymaps = {
        -- replace = { n = '<localleader>r' },
        -- qflist = { n = '<localleader>q' },
        -- syncLocations = { n = '<localleader>s' },
        -- syncLine = { n = '<localleader>l' },
        -- close = { n = '<localleader>c' },
        -- historyOpen = { n = '<localleader>t' },
        -- historyAdd = { n = '<localleader>a' },
        -- refresh = { n = '<localleader>f' },
        -- openLocation = { n = '<localleader>o' },
        -- openNextLocation = { n = '<down>' },
        -- openPrevLocation = { n = '<up>' },
        -- gotoLocation = { n = '<enter>' },
        -- pickHistoryEntry = { n = '<enter>' },
        -- abort = { n = '<localleader>b' },
        -- toggleShowCommand = { n = '<localleader>w' },
        -- swapEngine = { n = '<localleader>e' },
        -- previewLocation = { n = '<localleader>i' },
        -- swapReplacementInterpreter = { n = '<localleader>x' },
        -- applyNext = { n = '<localleader>j' },
        -- applyPrev = { n = '<localleader>k' },
        -- syncNext = { n = '<localleader>n' },
        -- syncPrev = { n = '<localleader>p' },
        -- syncFile = { n = '<localleader>v' },
        -- nextInput = { n = '<tab>' },
        -- prevInput = { n = '<s-tab>' },
        close = { n = 'q' },
      },
    },
    keys = {
      {
        '<leader>rs',
        function()
          local grug = require('grug-far')
          grug.open({
            transient = true,
            prefills = {
              -- filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace',
      },
      {
        '<leader>ri',
        function()
          local grug = require('grug-far')
          grug.open({
            transient = true,
            prefills = {
              search = '([\'"(])(/images/)(.*)(\\1)',
              replacement = '$1{{imageUrl}}$3?t={{Timestamp}}$4',
              filesFilter = '*.wxml',
              flags = '-g !src/custom-tab-bar',
            },
          })
        end,
        mode = { 'n' },
        desc = 'Replace images',
      },
    },
  },
}
return M
