local M = {
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
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
    keys = {
      {
        '<leader>ss',
        function()
          local is_visual = vim.fn.mode():lower():find('v')
          if is_visual then -- needed to make visual selection work
            vim.cmd([[normal! v]])
          end
          local grug = require('grug-far')
          local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
          local filesFilter = ext and ext ~= '' and '*.' .. ext or nil;
          (is_visual and grug.with_visual_selection or grug.grug_far)({
            prefills = { filesFilter = filesFilter },
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace',
      },
    },
  },
}
return M
