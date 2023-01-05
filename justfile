default:
    @just --list

fresharch:
    sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

    # install yay packages
    yay -Y --devel --combinedupgrade --batchinstall --save
    yay awesome-git
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

    # start docker sercice
    sudo systemctl enable docker.service
