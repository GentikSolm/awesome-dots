# The `Awesome` Dotfiles.

A very minimal set of dotfiles for awesome.
Enough to get the job done without sacrificing speed.

## Features

Lightweight volume popup that I spent far too much time on  
Toggles for `stay ontop` and converting tiled clients to floating (modkey + f and modkey + c respectfully)  
`Blazing Fast`  
Random wallpapers from nordic github repo (Regenerate via Control + alt + w)  
Rofi menu's for starting applications + powermenu  
Screenshotter that copys to clipboard  
Blur effects (thanks picom)  
Optimized for multihead setup (lots of client -> screen keybinds)  

## Dependencies

* awesome-git
    * Is not compatable with `awesome`, need the git version
* Picom
    * Picom adds blur effect to most windows.
* maim
    * Screenshotter
* xclip
    * Copy screenshots
* nordic-wallpapers-git
    * Wallpapers
    * https://github.com/linuxdotexe/nordic-wallpapers
    * `yay -S nordic-wallpapers-git` if your on arch
    * See `awesome/scripts/set_wallpapers` if you want to change the location
* amixer
    * Used for audio management
* Rofi
    * Various menus

Make sure to check `rc.lua` for `terminal`, `editor`, and `editor_cmd` and set them as such.

## Structure

All keybinds are in `keys.lua`  
Helper functions are in `helpers.lua`  
Shell scripts are in `scripts`  
Volume Slider is, well I think you can find it.  

These will be most likely be further broken out as I work on the files
The goal is for these to be extremely portable, and stay as fast as possible.

