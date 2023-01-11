-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local helpers = require("helpers")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other appfull_-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local config_dir = gears.filesystem.get_configuration_dir()

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/nord/theme.lua")

-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index)
  if tag.selected then
    item.markup = helpers.colorize_text(beautiful.taglist_text_focused[index], beautiful.taglist_fg_focus)
  elseif tag.urgent then
    item.markup = helpers.colorize_text(beautiful.taglist_text_urgent[index], beautiful.taglist_fg_urgent)
  elseif #tag:clients() > 0 then
    item.markup = helpers.colorize_text(beautiful.taglist_text_occupied[index], beautiful.taglist_fg_occupied)
  else
    item.markup = helpers.colorize_text(beautiful.taglist_text_empty[index], beautiful.taglist_fg_empty)
  end
end

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Notifications icon size
naughty.config.defaults['icon_size'] = 100

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Tray menu
tray = wibox.widget.systray()
tray.base_size = 25
tray.visible = false

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

awful.screen.connect_for_each_screen(function(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        widget_template = {
          widget = wibox.widget.textbox,
          create_callback = function(self, tag, index, _)
            self.align = "left"
            self.valign = "center"
            self.font = beautiful.taglist_text_font

            update_taglist(self, tag, index)
          end,
          update_callback = function(self, tag, index, _)
            update_taglist(self, tag, index)
          end,
        },
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,

        widget_template = {
          {
            {
                id     = 'clienticon',
                widget = awful.widget.clienticon,
            },
            margins = 5,
            widget  = wibox.container.margin
          },
          nil,
          layout = wibox.layout.align.vertical,
        },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s , bg = beautiful.bg_normal})

    s.systray = wibox.widget.systray()
    s.systray.visible = true

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
	expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.margin(s.mytaglist, 5, 0, 0),
            s.mypromptbox,
        },
        mytextclock,--s.mytasklist, -- Middle widget
        { -- Right widgets
	    layout = wibox.layout.fixed.horizontal,
            wibox.container.margin(s.systray, 0, 0, 3, 3),
            s.mytasklist,
            -- s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

activetags = {}

-- {{{ Key bindings
clientkeys = gears.table.join(
    awful.key({ modkey},
        "q",
        function (c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),
    awful.key({modkey},
        "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    ),
    awful.key({modkey, "Control" },
        "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}
    ),
    awful.key({ modkey, "Shift"},
        "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = "(un)maximize horizontally", group = "client"}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- focused client
    {rule = { focus = true },
     proprieties = { border_color = beautiful.border_focus,
                     border_width = border_focus_width}},

    -- Floating clients.
    { rule_any = {
        instance = {
          "Devtools",
        },
        class = {
          "Arandr",
          "Blueman-manager",
      },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",
        },
        role = {
          "pop-up"       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }}
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    c:emit_signal(
        'request::active',
        'mouse_enter',
        {
            raise = true
        }
    )
    if not awesome.startup then
        awful.client.setslave(c)
    end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = true})
end)

client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{
-- Startup Applications
do
    local run_on_startup = {
        "picom -b --dbus --config ~/.config/picom/picom.conf",
        "xrdb $HOME/.Xresources",
        "xset r rate 200 50"
        config_dir .. "scripts/set_wallpapers /home/josh/Pictures/nordic-wallpapers/wallpapers",
    }
    for app = 1, #run_on_startup do
        awful.spawn.with_shell(run_on_startup[app])
    end
end


-- Set keys
root.keys(require('keys'))
require("volume-slider")
