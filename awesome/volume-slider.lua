-- ===================================================================
-- Initialization
-- ===================================================================


local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local icons = require("icons")
local dpi = beautiful.xresources.apply_dpi

local offsetx = dpi(56)
local offsety = dpi(256)
local screen = awful.screen.focused()
local icon_dir = gears.filesystem.get_configuration_dir() .. "/icons/"


-- ===================================================================
-- Appearance & Functionality
-- ===================================================================


local volume_icon = wibox.widget{
   widget = wibox.widget.imagebox,
   image = icons.volume
}

-- create the volume_adjust component
local volume_adjust = wibox({
   height = dpi(48),
   width = offsety,
   bg = beautiful.bg_normal,
   shape = gears.shape.rounded_rect,
   visible = false,
   ontop = true,
})

local volume_bar = wibox.widget{
   widget = wibox.widget.progressbar,
   shape = gears.shape.rounded_bar,
   color = beautiful.fg_normal,
   bg = beautiful.bg_normal,
   background_color = beautiful.bg_normal,
   bar_shape = gears.shape.rounded_bar,
   max_value = 100,
   value = 0,
}

volume_adjust:setup {
    layout = wibox.layout.align.horizontal,
    wibox.container.margin(
        volume_icon, dpi(10), dpi(0), dpi(10), dpi(10)
    ),
    {
        wibox.container.margin(
            volume_bar, dpi(20), dpi(15), dpi(20), dpi(20)
       ),
       direction = "north",
       layout = wibox.container.rotate
    }
}

-- create a 4 second timer to hide the volume adjust
-- component whenever the timer is started
local hide_volume_adjust = gears.timer {
   timeout = 5,
   autostart = true,
   callback = function()
      volume_adjust.visible = false
   end
}

-- show volume-adjust when "volume_change" signal is emitted
awesome.connect_signal("volume_change",
function()
    -- set new volume value
    awful.spawn.easy_async_with_shell(
        "amixer sget Master | grep 'Right:' | awk -F '[][]' '{print $2}'| sed 's/[^0-9]//g'",
        function(stdout)
            local volume_level = tonumber(stdout)
            volume_bar.value = volume_level
        end,
        false
    )
    -- make volume_adjust component visible
    screen = awful.screen.focused()
    volume_adjust.screen = screen
    volume_adjust.x = screen.geometry.x + screen.geometry.width - offsety - 16
    volume_adjust.y = screen.geometry.y + screen.geometry.height - offsetx - 16
    if volume_adjust.visible then
        hide_volume_adjust:again()
    else
        volume_adjust.visible = true
        hide_volume_adjust:start()
    end
end
)
