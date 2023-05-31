local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
-- Declare widgets
local spotify_artist = wibox.widget.textbox()
local spotify_title = wibox.widget.textbox()
local spotify_image = wibox.widget.imagebox({
    widget = wibox.widget.imagebox,
    resize = true,
})

-- Main widget that includes all others
local spotify_widget = wibox.widget {
    -- Image widget
    -- Title widget
    {
        align = "center",
        text = "Spotify",
        font = "sans 14",
        widget = spotify_title
    },
    -- Artist widget
    {
        align = "center",
        text = "unavailable",
        font = "sans 10",
        widget = spotify_artist
    },
    spacing = 2,
    layout = wibox.layout.fixed.vertical
}

-- Subcribe to spotify updates
awesome.connect_signal("daemon::spotify", function(artist, title, status, image_url)
    -- Do whatever you want with artist, title, status
    -- ...
    spotify_artist.text = artist
    spotify_title.text = title

    -- Example notification (might not be needed if spotify already sends one)
    -- if status == "playing" then
    -- naughty.notify({ title = "Spotify | Now Playing", message= title.." by "..artist })
    -- end
end)

local function emit_info(playerctl_output)
    local artist = playerctl_output:match('artist_start(.*)title_start')
    if artist == '' then artist = 'Play a song!' end
    local title = playerctl_output:match('title_start(.*)status_start')
    if title == '' then title = 'Spotify' end
    -- Use the lower case of status
    local status = playerctl_output:match('status_start(.*)image_url'):lower()
    local image_url = playerctl_output:match('image_url(.*)')
    awful.spawn.easy_async_with_shell('curl ' .. image_url .. ' --output ~/.config/awesome/artwork', function()
        spotify_image.image = gears.surface.load_uncached('/home/josh/.config/awesome/artwork')
    end)
    status = string.gsub(status, '^%s*(.-)%s*$', '%1')

    awesome.emit_signal("daemon::spotify", artist, title, status, image_url)
end

-- Sleeps until spotify changes state (pause/play/next/prev)
local spotify_script = [[
  sh -c '
    playerctl --player spotify metadata --format 'artist_start{{artist}}title_start{{title}}status_start{{status}}image_url{{mpris:artUrl}}' --follow
  ']]

-- Kill old playerctl process
awful.spawn.easy_async_with_shell(
    "ps x | grep \"playerctl --player spotify metadata\" | grep -v grep | awk '{print $1}' | xargs kill", function()
        -- Emit song info with each line printed
        awful.spawn.with_line_callback(spotify_script, {
            stdout = function(line)
                emit_info(line)
            end
        })
    end)




return { spotify_widget = spotify_widget, spotify_image = spotify_image }
