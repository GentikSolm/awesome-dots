local awful = require('awful')
local gears = require('gears')
local menubar = require('menubar')
require('awful.autofocus')
local config_dir = gears.filesystem.get_configuration_dir()
local modkey = "Mod4"
local altkey = "Mod1"

local global_keys = awful.util.table.join(
-- Tag Control
    awful.key({ modkey, "Shift" },
        'j',
        awful.tag.viewprev,
        { description = 'view previous tag', group = 'tag' }
    ),
    awful.key({ modkey, "Shift" },
        'k',
        awful.tag.viewnext,
        { description = 'view next tag', group = 'tag' }
    ),
    awful.key({ modkey },
        "h",
        awful.client.movetoscreen,
        { description = "Move client to next screen", group = "tag" }
    ),
    awful.key({ modkey },
        "l",
        function()
            local c = client.focus
            if c then
                awful.client.movetoscreen(c, c.screen.index - 1)
            end
        end,
        { description = "Move client to previous screen", group = "tag" }
    ),
    awful.key({ modkey, "Shift" },
        "h",
        function()
            awful.screen.focus_relative(1)
        end,
        { description = "Focus the next screen", group = "screen" }
    ),
    awful.key({ modkey, "Shift" },
        "l",
        function()
            awful.screen.focus_relative(-1)
        end,
        { description = "Focus the previous screen", group = "screen" }
    ),
    awful.key({ modkey },
        'j',
        function()
            local t = client.focus and client.focus.first_tag or nil
            if t == nil then
                return
            end
            local tag = client.focus.screen.tags[(t.index - 2) % 9 + 1]
            awful.client.movetotag(tag)
            awful.tag.viewprev()
        end,
        { description = 'move client to prevois tag and switch to it', group = 'layout' }
    ),
    awful.key({ modkey },
        'k',
        function()
            local t = client.focus and client.focus.first_tag or nil
            if t == nil then
                return
            end
            local tag = client.focus.screen.tags[(t.index % 9) + 1]
            awful.client.movetotag(tag)
            awful.tag.viewnext()
        end,
        { description = 'move client to next tag and switch to it', group = 'layout' }
    ),
    awful.key({ modkey },
        "Escape",
        awful.tag.history.restore,
        { description = "go back", group = "tag" }
    ),
    awful.key({ modkey }, "0",
        function()
            local activetags = _ENV.activetags
            local s = awful.screen.focused()
            local h = require('helpers')
            if activetags[s] == nil then
                activetags[s] = h.copy(s.selected_tags)
                awful.tag.viewmore(s.tags, s)
            else
                awful.tag.viewnone(s)
                for _, tag in ipairs(activetags[s]) do
                    tag.selected = true
                end
                activetags[s] = nil
            end
        end,
        { description = "Toggle all tags visibility", group = "custom" }
    ),

    -- Launch Application
    awful.key({ modkey },
        "Return",
        function()
            awful.spawn(terminal)
        end,
        { description = "open a terminal", group = "launcher" }
    ),
    awful.key({ modkey },
        "s",
        function()
            awful.spawn("com.spotify.Client")
        end,
        { description = "open Spotify", group = "app" }
    ),
    awful.key({ modkey },
        "t",
        function()
            awful.spawn("org.telegram.desktop")
        end,
        { description = "open Telegram", group = "app" }
    ),
    awful.key({ modkey },
        "d",
        function()
            awful.spawn("com.discordapp.Discord")
        end,
        { description = "open Discord", group = "app" }
    ),
    awful.key({ modkey },
        "b",
        function()
            awful.spawn("firefox")
        end,
        { description = "open firefox", group = "app" }
    ),
    awful.key({ modkey },
        "o",
        function()
            awful.spawn("obsidian")
        end,
        { description = "open obsidian", group = "app" }
    ),

    -- Screenshot
    awful.key({},
        "Print",
        function()
            awful.spawn.easy_async_with_shell(config_dir .. 'scripts/snap full', function() end)
        end,
        { description = 'fullscreen screenshot', group = 'Utility' }
    ),
    awful.key({ modkey, "Shift" },
        "s",
        function()
            awful.spawn.easy_async_with_shell(config_dir .. 'scripts/snap area', function() end)
        end,
        { description = 'area/selected screenshot', group = 'Utility' }
    ),

    -- Laptop
    awful.key({},
        "XF86MonBrightnessDown",
        function()
            awful.util.spawn("backlight_control -5", false)
        end
    ),
    awful.key({},
        "XF86MonBrightnessUp",
        function()
            awful.util.spawn("backlight_control  +5", false)
        end
    ),
    awful.key({ modkey },
        "XF86MonBrightnessDown",
        function()
            awful.spawn.with_shell("~/.config/awesome/scripts/screenpad.sh -12", false)
        end
    ),
    awful.key({ modkey },
        "XF86MonBrightnessUp",
        function()
            awful.spawn.with_shell("~/.config/awesome/scripts/screenpad.sh 12", false)
        end
    ),

    -- Media
    awful.key({ modkey },
        "XF86AudioNext",
        function()
            awful.spawn.with_shell("~/.config/awesome/scripts/audio_switcher.sh")
        end,
        { description = "Move to next audio sink", group = "audio" }
    ),
    awful.key({},
        "XF86AudioRaiseVolume",
        function()
            awful.util.spawn("amixer -D pulse sset Master 2%+", false)
            awesome.emit_signal("volume_change")
        end
    ),
    awful.key({},
        "XF86AudioLowerVolume",
        function()
            awful.util.spawn("amixer -D pulse sset Master 2%-", false)
            awesome.emit_signal("volume_change")
        end
    ),
    awful.key({},
        "XF86AudioMute",
        function()
            awful.util.spawn("amixer -D pulse set Master 1+ toggle", false)
        end
    ),
    awful.key({},
        "XF86AudioPlay",
        function()
            awful.util.spawn(
            "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause",
                false)
        end
    ),
    awful.key({},
        "XF86AudioNext",
        function()
            awful.util.spawn(
            "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next",
                false)
        end
    ),
    awful.key({},
        "XF86AudioPrev",
        function()
            awful.util.spawn(
            "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous",
                false)
        end
    ),

    -- Client Management
    awful.key({ altkey, "Shift" },
        "Tab",
        function()
            if cl_menu then
                cl_menu:hide()
                cl_menu = nil
            else
                client_list = {}
                local tag = awful.tag.selected()
                for i = 1, #tag:clients() do
                    cl = tag:clients()[i]
                    if tag:clients()[i].minimized then
                        prefix = "_ "
                    else
                        prefix = "* "
                    end
                    if not awful.rules.match(cl, { class = "Conky" }) then
                        client_list[i] =
                        { prefix .. cl.name,
                            function()
                                tag:clients()[i].minimized = not tag:clients()[i].minimized
                            end,
                            cl.icon
                        }
                    end
                end
                cl_menu = awful.menu({ items = client_list, theme = { width = 300 } })
                cl_menu:show()
            end
        end,
        { description = "select clients", group = "client" }
    ),
    awful.key({ altkey, "Shift" },
        "k",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ altkey, "Shift" },
        "j",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),
    awful.key({ altkey },
        'f',
        function()
            local c = client.focus
            c.fullscreen = false
            c.maximized = false
            c.ontop = not c.ontop
            c:raise()
        end,
        { description = "Force client to stay ontop", group = "client" }
    ),
    awful.key({ altkey },
        'c',
        function()
            local c = client.focus
            c.fullscreen = false
            c.maximized = false
            c.floating = not c.floating
            c:raise()
        end,
        { description = 'toggle floating', group = 'client' }
    ),
    awful.key({ altkey },
        'm',
        function()
            client.focus.floating = not client.focus.floating
            client.focus.fullscreen = not client.focus.fullscreen
        end,
        { description = 'Maximize client', group = 'client' }
    ),
    awful.key({ altkey },
        "u",
        awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }
    ),
    awful.key({ altkey },
        "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }
    ),
    awful.key({ modkey, altkey },
        "k",
        function()
            awful.client.swap.byidx(1)
        end,
        { description = "swap with next client by index", group = "client" }
    ),
    awful.key({ modkey, altkey },
        "j",
        function()
            awful.client.swap.byidx(-1)
        end,
        { description = "swap with previous client by index", group = "client" }
    ),

    -- AwesomeWM
    awful.key({ modkey, "Shift" },
        "r",
        function()
            local file = io.open(gears.filesystem.get_configuration_dir() .. "reload.lck", "w")
            file:write("reloading awesome...")
            file:close()
            awesome.restart()
        end,
        { description = "reload awesome", group = "awesome" }
    ),
    awful.key({ modkey, "Shift" },
        "e",
        awesome.quit,
        { description = "quit awesome", group = "awesome" }
    ),
    awful.key({ modkey },
        "w",
        function()
            mymainmenu:show()
        end,
        { description = "show main menu", group = "awesome" }
    ),

    --Prompt / Top Bar
    awful.key({ modkey },
        "r",
        function()
            awful.screen.focused().mypromptbox:run()
        end,
        { description = "run prompt", group = "launcher" }
    ),
    awful.key({ modkey },
        "x",
        function()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { description = "lua execute prompt", group = "awesome" }
    ),
    awful.key({ modkey },
        "p",
        function()
            menubar.show()
        end,
        { description = "show the menubar", group = "launcher" }
    ),
    awful.key({ modkey, "Shift" },
        "t",
        function()
            awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
        end,
        { description = "Toggle systray visibility", group = "custom" }
    ),

    -- Rofi Menues
    awful.key({ modkey, "Shift" },
        "p",
        function()
            awful.spawn.with_shell("~/.config/awesome/scripts/power_menu.sh")
        end,
        { description = "Power menu", group = "utility" }
    ),
    awful.key({ modkey },
        "space",
        function()
            awful.spawn("rofi -show drun -display-drun '❯'")
        end,
        { description = "show rofi", group = "app" }
    ),

    -- Wallpaper
    awful.key({ altkey, "Control" },
        "w",
        function()
            awful.spawn.with_shell(config_dir ..
            "scripts/set_wallpapers /home/josh/Pictures/nordic-wallpapers/wallpapers")
        end,
        { description = "reset wallpapers", group = "utility" }
    )
)

return global_keys
