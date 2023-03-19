local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

local mainpopover = wilder.popupmenu_renderer({
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = {
        wilder.lua_pcre2_highlighter(),
        wilder.lua_fzy_highlighter()
    },
    highlights = {
        accent = wilder.make_hl('WilderAccent', 'Pmenu', {{a = 1}, {a = 1}, {foreground = '#f4468f'}}),
    },
    left = {
        ' ',
        wilder.popupmenu_devicons(),
        wilder.popupmenu_buffer_flags({
            flags = ' a + ',
            icons = {['+'] = '', a = '', h = ''},
        }),
    },
    right = {
        ' ',
        wilder.popupmenu_scrollbar(),
    },
})

local wildmenu_renderer = wilder.wildmenu_renderer({
    highlighter = highlighters,
    separator = '  ',
    left = {' ', wilder.wildmenu_spinner(), ' '},
    right = {' ', wilder.wildmenu_index()}
})

wilder.set_option('renderer', wilder.renderer_mux({
    [':'] = mainpopover,
    ['/'] = wildmenu_renderer,
    substitute = mainpopover,
}))

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      -- sets the language to use, 'vim' and 'python' are supported
      language = 'python',
      -- 0 turns off fuzzy matching
      -- 1 turns on fuzzy matching
      -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
      fuzzy = 1,
    }),
    wilder.python_search_pipeline({
      -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
      pattern = wilder.python_fuzzy_pattern(),
      -- omit to get results in the order they appear in the buffer
      sorter = wilder.python_difflib_sorter(),
      -- can be set to 're2' for performance, requires pyre2 to be installed
      -- see :h wilder#python_search() for more details
      engine = 're',
    })
  ),
})

