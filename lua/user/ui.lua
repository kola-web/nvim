local M = {
  -- icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  -- ui components
  { 'MunifTanjim/nui.nvim', lazy = true },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'rcarriga/nvim-notify',
    },
    opts = {
      cmdline = {
        view = 'cmdline',
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        mode = 'buffers',
        close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
        right_mouse_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
        separator_style = 'thin', -- | "thick" | "thin" | { 'any', 'any' },
        hover = {
          enabled = false, -- requires nvim 0.8+
          delay = 200,
          reveal = { 'close' },
        },
        sort_by = 'id',
      },
    },
  },
}

return M