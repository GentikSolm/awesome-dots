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
      fuzzy = 2,
      fuzzy_filter = wilder.lua_fzy_filter(),
    }),
    {
      wilder.check(function(ctx, x) return x == '' end),
      wilder.history(),
    },
    wilder.python_search_pipeline({
      pattern = wilder.python_fuzzy_pattern({
        start_at_boundary = 0,
      }),
    })
  ),
})
