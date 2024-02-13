
eval "$(/opt/homebrew/bin/brew shellenv)"

#   Update all Wallpapers
#
function wallpaper() {
    wallpaper_file=$(find ~/github/nordic-wallpapers/wallpapers -maxdepth 1 | shuf -n 1)
    osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$wallpaper_file\""
}

wallpaper
