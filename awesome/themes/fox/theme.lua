---------------------------
-- noaccOS' Fox minimal theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = "~/.config/awesome/themes/"

local theme = {}
--local wibar = require("wibar")

theme.font          = "Roboto 12"
theme.transparent   = "#00000000"

theme.bg_normal     = "#2d253a"
theme.bg_focus      = theme.bg_normal
theme.bg_urgent     = theme.bg_normal
theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#ffffff"
theme.fg_focus      = theme.fg_normal
theme.fg_urgent     = theme.fg_normal
theme.fg_minimize   = theme.fg_normal

theme.c_primary     = "#b06f8d"
theme.c_secondary   = "#7facbf"
theme.c_accent      = "#f8c083"

theme.useless_gap   = dpi(15)
theme.border_width  = dpi(1)
theme.border_normal = theme.c_accent
theme.border_marked = theme.c_accent

theme.tasklist_bg_focus = theme.transparent
theme.tasklist_icon_size = dpi(5)
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."defaults/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = themes_path.."fox/background.jpg"
theme.background = "#2d253a"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil


theme.taglist_text_font = "Typicons 25"
theme.taglist_text_empty    =  {"","","","","","","","",""}
theme.taglist_text_occupied =  {"","","","","","","","",""}
theme.taglist_text_focused  = {"","","","","","","","",""}
theme.taglist_text_urgent   = {"","","","","","","","",""}

theme.taglist_font = "Roboto 12"
theme.taglist_bg_focus = theme.bg_normal .. "00"
theme.taglist_fg_focus = theme.c_accent
theme.taglist_bg_occupied = theme.bg_normal .. "00"
theme.taglist_fg_occupied = theme.c_primary
theme.taglist_bg_empty = theme.bg_normal .. "00"
theme.taglist_fg_empty = theme.c_primary
theme.taglist_bg_urgent = theme.bg_normal .. "00"
theme.taglist_fg_urgent = theme.bg_normal

return theme
