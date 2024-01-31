default:
    @just --list

update:
    yay
    flatpak update

fresharch:
    sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

    # install yay packages yay -Y --devel --combinedupgrade --batchinstall --save yay awesome-git
    yay rofi
    yay picom-git
    yay feh
    yay flatpak
    yay neovim-git
    yay rg
    yay xclip
    yay tldr
    yay bat
    yay docker-git
    # research docker compose installation
    yay kitty-git
    yay lua
    yay wireguard-tools
    
    # cli
    yay zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # start docker sercice
    sudo systemctl enable docker.service

# Im just putting this here so i dont lose it.
_fixnetwork:
    sudo systemctl restart nscd.service

mirrors:
    @sudo reflector --sort rate -l 5 --country "US" -p https,rsync --save /etc/pacman.d/mirrorlist

tripple:
  xrandr --output DP-2 --primary --mode 2560x1440 --rate 120 --pos 2560x0 --rotate normal --output DP-4 --rate 144 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-0 --mode 2560x1440 --rate 144 --pos 5120x0 --rotate normal --output DP-4 --off

screenpad:
    #!/bin/bash
    set -euxo pipefail
    sudo dkms remove -m asus-wmi -v 1.0 --all
    sudo rm -rf /usr/src/asus-wmi-1.0
    sudo mkdir /usr/src/asus-wmi-1.0
    cd /usr/src/asus-wmi-1.0
    sudo wget 'https://github.com/Plippo/asus-wmi-screenpad/archive/master.zip'
    sudo unzip master.zip
    sudo mv asus-wmi-screenpad-master/* .
    sudo rmdir asus-wmi-screenpad-master
    sudo rm master.zip
    sudo sh prepare-for-current-kernel.sh
    sudo dkms add -m asus-wmi -v 1.0
    sudo dkms build -m asus-wmi -v 1.0
    sudo dkms install --force -m asus-wmi -v 1.0
    echo "Installed! Please Restart"
