require('mini.align').setup({
  mappings = {
    start = 'ge',
    start_with_preview = 'gE',
  },
})

require('mini.surround').setup({
  mappings = {
    add = 'ys', -- Add surrounding in Normal and Visual modes
    delete = 'ds', -- Delete surrounding
    find = nil, -- Find surrounding (to the right)
    find_left = nil, -- Find surrounding (to the left)
    highlight = nil, -- Highlight surrounding
    replace = 'cs', -- Replace surrounding
    update_n_lines = nil, -- Update `n_lines`
    suffix_last = nil, -- Suffix to search with "prev" method
    suffix_next = nil, -- Suffix to search with "next" method
  },
  custom_surroundings = {
    t = {
      input = { '<(%w+)[^<>]->.-</%1>', '^<()%w+().*</()%w+()>$' },
      output = function()
        local tag_name = MiniSurround.user_input('Tag name')
        if tag_name == nil then
          return nil
        end
        return { left = tag_name, right = tag_name }
      end,
    },
  },
})

require('mini.operators').setup({
  evaluate = {
    prefix = nil,
    func = nil,
  },
  exchange = {
    prefix = 'S',
    reindent_linewise = true,
  },
  multiply = {
    prefix = 'gm',
    func = nil,
  },
  replace = {
    prefix = 's',
    reindent_linewise = true,
  },
  sort = {
    prefix = 'gs',
    func = nil,
  },
})

require('mini.splitjoin').setup({
  mappings = {
    toggle = '<leader>J',
  },
})

require('mini.ai').setup({
  n_lines = 500,
  custom_textobjects = {
    t = false,
    -- <div #name name="name" :text="greetingMessage" v-slot="slotProps" #[dynamicSlotName] v-slot:[dynamicSlotName] ></div>
    x = {
      {
        -- Double-quoted: name="val", :prop="val", @click.stop="fn", v-slot:name="val", v-model.trim="val"
        '%s([@:]?[%w:.-]+=").-"',
        -- Single-quoted: name='val', :prop='val'
        "%s([@:]?[%w:.-]+=').-'",
        -- JSX curly braces: onClick={fn}, :prop={val}, @click={handler}
        "%s([@:]?[%w:.-]+={).-}",
        -- Template literal JSX: className={`btn ${active}`}
        '%s([%w-]+=`).-`',
        -- Vue dynamic slot / Angular binding: #[dynamicSlotName] or [ngIf]
        '%s([#]?[%w-]+)%[.-%]',
        -- Vue v-slot:[dynamicSlotName]
        '%s(v%-slot:%[).-%]',
        -- JSX spread: {...props}
        '%s({%.%.%.}).-}',
        -- Unquoted HTML attributes: type=text, name=value
        '%s([%w-]+=)[^%s>"\']+',
        -- Vue #name shorthand (v-slot shorthand, static, no value)
        '%s(#[%w-]+)[%s/>]',
        -- Boolean/valueless attributes: disabled, v-else, v-once, v-cloak, etc.
        '%s([%w-]+)[%s/>]',
      },
      '^().*()$',
    },
  },
})

-- require('mini.jump').setup()
--
-- local jump2d = require('mini.jump2d')
-- jump2d.setup({
--   spotter = jump2d.gen_spotter.pattern('[^%s%p]+'),
--   -- labels = 'asdfghjkl;',
--   view = { dim = true, n_steps_ahead = 2 },
--   silent = true,
-- })
