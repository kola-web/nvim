local M = {
  'nvim-telescope/telescope.nvim',
  event = 'Bufenter',
  cmd = { 'Telescope' },
  dependencies = {
    {
      'folke/noice.nvim',
    },
  },
  keys = {
    {
      '<leader>bb',
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      desc = 'Buffers',
    },
    {
      '<leader>f',
      '<cmd>Telescope find_files<cr>',
      desc = 'find file',
    },
    {
      '<leader>F',
      '<cmd>Telescope live_grep theme=ivy<cr>',
      desc = 'grep text',
    },
    {
      '<leader>t',
      '<cmd>Telescope filetypes<cr>',
      desc = 'switch filetypes',
    },

    { '<leader>sc', '<cmd>Telescope colorscheme<cr>', desc = 'colorscheme' },
    { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = 'diagnostics' },
    { '<leader>sh', '<cmd>lua require"telescope.builtin".find_files({ hidden = true })<cr>', desc = 'hidden file' },
    { '<leader>sH', '<cmd>Telescope help_tags<cr>', desc = 'Help' },
    { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
    { '<leader>sr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent File' },
    { '<leader>s`', '<cmd>Telescope registers<cr>', desc = 'Registers' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
    { '<leader>sp', '<cmd>Telescope package_info<cr>', desc = 'package_info' },

    { '<leader>lt', '<cmd>Telescope filetypes<cr>', desc = 'filetype' },
  },
}

M.config = function()
  local status_ok, telescope = pcall(require, 'telescope')
  if not status_ok then
    return
  end

  local actions = require('telescope.actions')

  local previewers = require('telescope.previewers')

  local function flash(prompt_bufnr)
    require('flash').jump({
      pattern = '^',
      label = { after = { 0, 0 } },
      search = {
        mode = 'search',
        exclude = {
          function(win)
            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'TelescopeResults'
          end,
        },
      },
      action = function(match)
        local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
        picker:set_selection(match.pos[1] - 1)
      end,
    })
  end

  local open_with_trouble = require('trouble.sources.telescope').open

  local function find_command()
    if 1 == vim.fn.executable('rg') then
      return { 'rg', '--files', '--color', 'never', '-g', '!.git' }
    elseif 1 == vim.fn.executable('fd') then
      return { 'fd', '--type', 'f', '--color', 'never', '-E', '.git' }
    elseif 1 == vim.fn.executable('fdfind') then
      return { 'fdfind', '--type', 'f', '--color', 'never', '-E', '.git' }
    elseif 1 == vim.fn.executable('find') and vim.fn.has('win32') == 0 then
      return { 'find', '.', '-type', 'f' }
    elseif 1 == vim.fn.executable('where') then
      return { 'where', '/r', '.', '*' }
    end
  end

  local opts = {
    defaults = {
      -- prompt_prefix = ' ',
      prompt_prefix = '',
      selection_caret = ' ',
      file_ignore_patterns = {
        '.git',
        '.svn',
        'node_modules',
        'miniprogram_npm',
        '.yarn',
        'dist',
        'dist_pro',
      },
      mappings = {
        i = {
          ['<Down>'] = actions.move_selection_next,
          ['<Up>'] = actions.move_selection_previous,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-p>'] = actions.move_selection_previous,
          ['<C-j>'] = actions.cycle_history_next,
          ['<C-k>'] = actions.cycle_history_prev,
          ['<CR>'] = actions.select_default,
          ['<c-s>'] = flash,
          ['<c-t>'] = open_with_trouble,
        },
        n = {
          ['?'] = actions.which_key,
          ['<c-s>'] = flash,
          ['<c-t>'] = open_with_trouble,
        },
      },
      get_selection_window = function()
        local wins = vim.api.nvim_list_wins()
        table.insert(wins, 1, vim.api.nvim_get_current_win())
        for _, win in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].buftype == '' then
            return win
          end
        end
        return 0
      end,
    },
    pickers = {
      find_files = {
        find_command = find_command,
        hidden = true,
      },
      buffers = {
        initial_mode = 'normal',
      },
      diagnostics = {
        initial_mode = 'normal',
      },
      lsp_code_actions = {
        initial_mode = 'normal',
      },
    },
    extensions = {
      package_info = {
        initial_mode = 'normal',
      },
    },
  }

  telescope.setup(opts)
  telescope.load_extension('noice')
  telescope.load_extension('package_info')
end

return M
