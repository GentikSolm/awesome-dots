
local awful = require('awful')
local gears = require('gears')
local menubar = require('menubar')
local naughty = require('naughty')
local beautiful = require('beautiful')
local icons = require('icons')

require('awful.autofocus')
local config_dir = gears.filesystem.get_configuration_dir()
local modkey = "Mod4"
local altkey = "Mod1"

local function notif()
    naughty.notify({
        text = beautiful.bg_normal,
        title = "hello",
        duration = 10,
        icon = icons.volume
    })
end

local global_keys = awful.util.table.join(
	awful.key(
		{modkey},
		'c',
		function()
            local c = client.focus
			c.fullscreen = false
			c.maximized = false
			c.floating = not c.floating
			c:raise()
		end,
		{description = 'toggle floating', group = 'client'}
	),
    awful.key({altkey, "Control"},
        "w",
        function()
            awful.spawn.with_shell(config_dir .. "scripts/set_wallpapers")
        end,
        {description = "reset wallpapers", group = "utility"}
    ),

    awful.key({ modkey, "Shift"}, "p", function () awful.spawn.with_shell("~/.config/awesome/power_menu.sh") end,
              {description = "Power menu", group = "utility"}),

    awful.key({ modkey,           }, "s", function () awful.spawn("com.spotify.Client") end,
              {description = "open Spotify", group = "app"}),
    awful.key({ modkey,           }, "t", function () awful.spawn("org.telegram.desktop") end,
              {description = "open Telegram", group = "app"}),
    awful.key({ modkey,           }, "d", function () awful.spawn("com.discordapp.Discord") end,
              {description = "open Discord", group = "app"}),
    awful.key({ modkey,           }, "space", function () awful.spawn("rofi -show drun -display-drun '❯'") end,
       {description = "show rofi", group = "app"}),
    awful.key({ modkey, "Shift"}, ";", function () awful.spawn("splatmoji type") end,
      {description = "rofimoji", group = "app"}),
    awful.key({ modkey,           }, "b", function () awful.spawn("firefox") end,
       {description = "open firefox", group = "app"}),
    awful.key({ modkey, "Shift"}, "t", function()  awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
                                       end, {description = "Toggle systray visibility", group = "custom"}),
    awful.key({ modkey}, "0",
      function()
        local activetags = _ENV.activetags
        local s = awful.screen.focused()
        local h = require('helpers')
        if activetags[s] == nil then
          activetags[s] = h.copy(s.selected_tags)
          awful.tag.viewmore(s.tags, s)
        else
          awful.tag.viewnone(s)
          for _,tag in ipairs(activetags[s]) do
            tag.selected = true
          end
          activetags[s] = nil
        end
      end,
      {description = "Toggle all tags visibility", group = "custom"}
    ),

-- Screenshot
    awful.key(
        {  },
        "Print",
        function ()
            awful.spawn.easy_async_with_shell(config_dir .. 'scripts/snap full',function() end)
        end,
        {description = 'fullscreen screenshot', group = 'Utility'}
    ),
    awful.key(
        { modkey, "Shift" },
        "s",
        function ()
            awful.spawn.easy_async_with_shell(config_dir  .. 'scripts/snap area',function() end)
        end,
        {description = 'area/selected screenshot', group = 'Utility'}
    ),

-- Media
    awful.key({ },
        "XF86AudioRaiseVolume",
        function ()
            awful.util.spawn("amixer -D pulse sset Master 2%+", false)
            awesome.emit_signal("volume_change")
        end
    ),
    awful.key({ },
        "XF86AudioLowerVolume",
        function () 
            awful.util.spawn("amixer -D pulse sset Master 2%-", false)
            awesome.emit_signal("volume_change")
        end
    ),
    awful.key({ },
        "XF86AudioMute",
        function () 
            awful.util.spawn("amixer -D pulse set Master 1+ toggle", false) 
        end
    ),
    awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause", false) end),
    awful.key({ }, "XF86AudioNext", function () awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next", false) end),
    awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous", false) end),

-- Default keybingings
    awful.key(
        {'Control', altkey},
        'Left',
        awful.tag.viewprev,
        {description = 'view previous tag', group = 'tag'}
    ),
    awful.key(
        {'Control', altkey},
        'Right',
        awful.tag.viewnext,
        {description = 'view next tag', group = 'tag'}
    ),
    awful.key({ modkey},
        "Right",
        awful.client.movetoscreen,
        {description = "view previous", group = "tag"}
    ),
    awful.key({modkey},
        "Left",
        function()
            local c = client.focus
            if c then
                awful.client.movetoscreen(c, c.screen.index-1)
            end
        end,
        {description = "view next", group = "tag"}
    ),
    awful.key({modkey},
        'f',
        function()
            local c = client.focus
            c.fullscreen = false
            c.maximized = false
            c.ontop = not c.ontop
            c:raise()
        end,
        {description = "toggle floating", group = "client"}
    ),
    awful.key({modkey, 'Shift'},
        'Right',
        function()
            awful.screen.focus_relative(1)
        end,
        {description = 'focus the previous screen', group = 'screen'}
    ),
    awful.key({modkey, 'Shift'},
        'Left',
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = 'focus the next screen', group = 'screen'}
    ),
    awful.key({modkey, "Control"},
        'Left',
        function()
            local t = client.focus and client.focus.first_tag or nil
            if t == nil then
                return
            end
            local tag = client.focus.screen.tags[(t.index -2) % 9 +1]
            awful.client.movetotag(tag)
            awful.tag.viewprev()
        end,
        {description = 'move client to prevois tag and switch to it', group = 'layout'}
    ),
    awful.key({modkey, "Control"},
        'Right',
        function()
            local t = client.focus and client.focus.first_tag or nil
            if t == nil then
                return
            end
            local tag = client.focus.screen.tags[(t.index % 9) +1]
            awful.client.movetotag(tag)
            awful.tag.viewnext()
        end,
        {description = 'move client to next tag and switch to it', group = 'layout'}
    ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),

    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r",
      function()
        local file = io.open(gears.filesystem.get_configuration_dir() .. "reload.lck", "w")
        file:write("reloading awesome...")
        file:close()

        awesome.restart()
      end,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "e", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    -- awful.key({ modkey, "Shift"     }, "space", function () awful.layout.inc( 1)                end,
    --          {description = "select next", group = "layout"}),
    --Pretty useless with few layouts
    --awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
    --          {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

return global_keys
