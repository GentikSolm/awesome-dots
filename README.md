# The `Awesome` Dotfiles.

A very minimal set of dotfiles for awesome.
Enough to get the job done without sacrificing speed.

## Dependencies

* Picom
    * Picom adds blur effect to most windows.
* maim
    * Screenshotter
* xclip
    * Copy screenshots
* https://github.com/linuxdotexe/nordic-wallpapers
    * Wallpapers
    * See `awesome/scripts/set_wallpapers`
* amixer
    * Used for audio management
* Rofi
    * Various menu's

Make sure to check `rc.lua` for `terminal`, `editor`, and `editor_cmd` and set them as such.

## Structure

All keybinds are in `keys.lua`  
Helper functions are in `helpers.lua`  
Shell scripts are in `scripts`  
Volume Slider is, well I think you can find it.  

These will be most likely be further broken out as I work on the files
The goal is for these to be extreemly portable, and stay as fast as possible.

