local M = {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>v',
      function()
        require('harpoon'):list():append()
      end,
      desc = 'Harpoon file',
    },
    {
      '<Leader>V',
      function()
        require('harpoon'):list():remove()
      end,
      desc = 'Remove location',
    },
    {
      '<C-e>',
      function()
        local harpoon = require('harpoon')
        -- harpoon.ui:toggle_quick_menu(harpoon:list())

        -- basic telescope configuration
        local conf = require('telescope.config').values
        local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end

          require('telescope.pickers')
            .new({}, {
              prompt_title = 'Harpoon',
              finder = require('telescope.finders').new_table({
                results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
              initial_mode = 'normal',
            })
            :find()
        end
        toggle_telescope(harpoon:list())
      end,
      desc = 'Harpoon quick menu',
    },
    {
      '<leader>1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'Harpoon to file 1',
    },
    {
      '<leader>2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'Harpoon to file 2',
    },
    {
      '<leader>3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'Harpoon to file 3',
    },
    {
      '<leader>4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'Harpoon to file 4',
    },
    {
      '<leader>5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = 'Harpoon to file 5',
    },
  },
}

return M
