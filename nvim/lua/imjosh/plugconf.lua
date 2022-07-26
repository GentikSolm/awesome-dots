local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

local mainpopover = wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme({
        -- 'single', 'double', 'rounded' or 'solid'
        -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
        border = 'rounded',
        max_height = '75%',      -- max height of the palette
        min_height = 0,          -- set to the same as 'max_height' for a fixed height window
        prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
        reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
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
)

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
            fuzzy = 1,
            set_pcre2_pattern = 1,
        }),
        wilder.python_search_pipeline({
        pattern = 'fuzzy',
        })
    ),
})
